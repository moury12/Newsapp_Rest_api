import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_app/Model/newsModel.dart';
import 'package:news_app/const/status_code_error_handeling.dart';
String BaseURl ="newsapi.org";
String API_KEY ="cadc63676ddf40729d8c655fb125bbd7";
class NewsApiServices{
 static Future<List<NewsModel>> getAllNews({required int page, required String sortBy}) async{
try{
  //var url = Uri.parse('https://newsapi.org/v2/everything?q=bitcoin&pageSize=8&apiKey=cadc63676ddf40729d8c655fb125bbd7');
  var uri=Uri.https(BaseURl,"/v2/everything",{
    "q":"bitcoin",
    "pageSize":"5",
    "page": page.toString(),
    "sortBy":sortBy
    // "apiKey":API_KEY
  });
  var response = await http.get(uri,
      headers: {"X-Api-Key": API_KEY});
  Map data = jsonDecode(response.body);
  List newsTempList =[];
  if (response.statusCode != 200) {
    throw HttpStatusErrorHandle(status:response.statusCode );
    // throw data['message'];
  }
  for(var v in data["articles"]){
    newsTempList.add(v);
    //log(v.toString());
  }
  return NewsModel.newsFromSnapshot(newsTempList);


 }catch(e){
   throw(e.toString());
 }

}

 static Future<List<NewsModel>> getAlltopTrendings() async{
   try{
     //var url = Uri.parse('https://newsapi.org/v2/everything?q=bitcoin&pageSize=8&apiKey=cadc63676ddf40729d8c655fb125bbd7');
     var uri=Uri.https(BaseURl,"/v2/top-headlines",{
       "country":"us"
     });
     var response = await http.get(uri,
         headers: {"X-Api-Key": API_KEY});
     Map data = jsonDecode(response.body);
     List newsTempList =[];
     if (response.statusCode != 200) {
       throw HttpStatusErrorHandle(status:response.statusCode );
       // throw data['message'];
     }
     for(var v in data["articles"]){
       newsTempList.add(v);
       //log(v.toString());
     }
     return NewsModel.newsFromSnapshot(newsTempList);


   }catch(e){
     throw(e.toString());
   }

 }
}
