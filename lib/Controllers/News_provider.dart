import 'package:flutter/foundation.dart';
import 'package:news_app/const/newsApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/newsModel.dart';
import 'package:news_app/const/status_code_error_handeling.dart';

class NewsProvider with ChangeNotifier{

List<NewsModel> newsList =[];
List<NewsModel> get getNewsList{
  return newsList;
}
NewsModel findByPublishedAt({required String publishedAt}){
  return newsList.firstWhere((newsModel) => newsModel.publishAt==publishedAt);
}
Future<List<NewsModel>> fetchAllNews({ required int page,required String sortBy}) async{
  newsList = await NewsApiServices.getAllNews(page: page,sortBy: sortBy);
  return newsList;
}
/*Future<List<NewsModel>> fetchAllSearchedNews({required String query}) async{
  newsList = await NewsApiServices.getSearchedNews(query: query);
  return newsList;
}*/
  Future<List<NewsModel>> fetchAllSearchedNews({required String query}) async {
    try {
      var uri = Uri.https(BaseURl, "/v2/everything", {
        "q": query,
        "pageSize": "8",
        "apiKey": API_KEY,
      });
      var response = await http.get(uri);

      if (response.statusCode != 200) {
        throw HttpStatusErrorHandle(status: response.statusCode);
      }

      Map<String, dynamic> data = jsonDecode(response.body);
      List<NewsModel> newsList = NewsModel.newsFromSnapshot(data['articles']);
      return newsList;
    } catch (e) {
      throw (e.toString());
    }
  }
Future<List<NewsModel>> fetchAlltopTrending() async{
  newsList = await NewsApiServices.getAlltopTrendings();
  return newsList;
}
}