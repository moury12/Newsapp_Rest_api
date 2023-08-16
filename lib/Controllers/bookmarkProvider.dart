import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:news_app/Model/bookmarks_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/newsModel.dart';
import '../const/newsApi.dart';

class BookmarkProvider with ChangeNotifier {
  var firebaseUrl = "news-ad559-default-rtdb.firebaseio.com";
  var endpoint = "bookmarks.json";
  BookmarksModel? bookmarksModel;
  List<BookmarksModel> bookmarkList = [];
  List<BookmarksModel> get getBookmarkList {
    return bookmarkList;
  }

  bool isinBookmark(String publishDate) {
    return bookmarkList.any((bookmark) => bookmark.publishAt == publishDate);
  }


  Future<List<BookmarksModel>> getAllBookmarks() async {
    bookmarkList = await NewsApiServices.fetchAllBookmark() ?? [];
    notifyListeners();
    return bookmarkList;
  }

  Future<void> addToBookmark({required NewsModel newsModel}) async {
    try {
      // Check if the news is already bookmarked using publishedAt value
      if (!isinBookmark(newsModel.publishAt)) {
        var uri = Uri.https(firebaseUrl, endpoint);
        var response =
        await http.post(uri, body: json.encode(newsModel.toJson()));
        if (response.statusCode == 200) {
          // Add the new bookmark to the local list and notify listeners
          String bookmarkKey = jsonDecode(response.body)['name'];
          BookmarksModel newBookmark = BookmarksModel(
            newsId: newsModel.newsId,
            bookMarkKey: bookmarkKey,
            sourceName: newsModel.sourceName,
            authorName: newsModel.authorName,
            title: newsModel.title,
            description: newsModel.description,
            url: newsModel.url,
            urlToImage: newsModel.urlToImage,
            publishAt: newsModel.publishAt,
            content: newsModel.content,
            dateToshow: newsModel.dateToshow,
            readingTimeText: newsModel.readingTimeText,
          );
          bookmarkList.add(newBookmark);
          notifyListeners();
        }
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<void> deleteBookmark({required String key}) async {
    try {
      var uri = Uri.https(firebaseUrl, "bookmarks/$key.json");
      var response = await http.delete(uri);
      if (response.statusCode == 200) {
        bookmarkList.removeWhere((bookmark) => bookmark.bookMarkKey == key);
        bookmarksModel = null; // Reset bookmarksModel
        notifyListeners(); // Notify listeners after removing from local list
      }
    } catch (e) {
      log('Error deleting bookmark: $e');
      rethrow;
    }
  }}

