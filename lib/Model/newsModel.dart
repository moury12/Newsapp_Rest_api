import 'package:flutter/foundation.dart';
import 'package:news_app/const/global_methods.dart';
import 'package:reading_time/reading_time.dart';

class NewsModel with ChangeNotifier{
  String newsId,
        sourceName,
        authorName,
        title,
        description,
        url,
        urlToImage,
        publishAt,
        content,
        dateToshow,
        readingTimeText;

  NewsModel(
      {
        required this.newsId,
        required this.sourceName,
        required this.authorName,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishAt,
        required this.content,
        required this.dateToshow,
        required this.readingTimeText});

  factory NewsModel.fromJson(dynamic json){
    String title=json["title"]??"";
    String content=json["content"]??"";
    String description=json["description"]??"";
    String dateToshow ="";
    if(json['publishedAt']!=null){
      dateToshow =GlobalMethods.fromattedDateText(json['publishedAt']);
    }
    return NewsModel(
        newsId: json["source"]["id"]??"",
        sourceName: json["source"]["name"]??"",
        authorName: json["author"]??"",
        title: title,
        description: description,
        url: json["url"]??"",
        urlToImage: json["urlToImage"]??"",
        publishAt: json["publishedAt"]??"",
        content: content,
        dateToshow: dateToshow,
        readingTimeText: readingTime(title+description+content).msg);
  }
  static List<NewsModel> newsFromSnapshot(List newSnapshot){

    return newSnapshot.map((e) {
      return NewsModel.fromJson(e);
    }).toList(
    );
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data={
    };
    data["newsId"]=newsId;
    data["sourceName"]= sourceName;
    data["authorName"]= authorName;
    data["title"]= title;
    data["description"]= description;
    data["url"]= url;
    data["urlToImage"]= urlToImage;
    data["publishAt"]= publishAt;
    data["content"]= content;
    data["dateToshow"]= dateToshow;
    data["readingTimeText"]= readingTimeText;
    return data;
  }
}