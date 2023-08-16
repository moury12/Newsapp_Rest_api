import 'package:flutter/cupertino.dart';

class BookmarksModel with ChangeNotifier {
  String bookMarkKey,
      newsId,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishAt,
      dateToshow,
      content,
      readingTimeText;

  BookmarksModel({
    required this.newsId,
    required this.bookMarkKey,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishAt,
    required this.content,
    required this.dateToshow,
    required this.readingTimeText,
  });

  factory BookmarksModel.fromJson({required dynamic json, required bookMarkKey}) {
    return BookmarksModel(
      bookMarkKey: bookMarkKey,
      newsId: json['newsId'] ?? "",
      sourceName: json['sourceName'] ?? "",
      authorName: json['authorName'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishAt: json['publishedAt'] ?? '',
      dateToshow: json['dateToShow'] ?? "",
      content: json['content'] ?? "",
      readingTimeText: json['readingTimeText'] ?? "",
    );
  }

  static List<BookmarksModel> bookmarksFromSnapshot({ required dynamic json, required List allkeys}) {
    return allkeys.map((data) {
      return BookmarksModel.fromJson(bookMarkKey:data,json: json[data]);
    }).toList();
  }
  static BookmarksModel empty() {
    return BookmarksModel(
      newsId: '',
      bookMarkKey: '',
      sourceName: '',
      authorName: '',
      title: '',
      description: '',
      url: '',
      urlToImage: '',
      publishAt: '',
      content: '',
      dateToshow: '',
      readingTimeText: '',
    );
  }
  @override
  String toString() {
    return 'news {newsId: $newsId, sourceName: $sourceName, authorName: $authorName, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishAt, content: $content,}';
  }
}
