import 'package:flutter/foundation.dart';
import 'package:news_app/const/newsApi.dart';

import '../Model/newsModel.dart';

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
Future<List<NewsModel>> fetchAlltopTrending() async{
  newsList = await NewsApiServices.getAlltopTrendings();
  return newsList;
}
}