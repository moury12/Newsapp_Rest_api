import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Controllers/bookmarkProvider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../Controllers/News_provider.dart';
import '../const/utils.dart';

class NewsDetailsScreen extends StatefulWidget {
  static const routeName = "/NewsDetailsScreen";
  NewsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  String? publishedAt;
  late NewsProvider newsProvider;
  late BookmarkProvider bookmarkProvider;

  @override
  void didChangeDependencies() {
    publishedAt = ModalRoute.of(context)!.settings.arguments as String;
    newsProvider = Provider.of<NewsProvider>(context);
    bookmarkProvider = Provider.of<BookmarkProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final currentNews =
        newsProvider.findByPublishedAt(publishedAt: publishedAt!);
    final color = Utils(context).getColor;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "By ${currentNews.authorName}",
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentNews.title,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.bakbakOne(fontSize: 19),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Text(
                      currentNews.dateToshow,
                      style: GoogleFonts.adamina(fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      currentNews.readingTimeText,
                      style: smallTextStyle,
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Hero(
                    tag: currentNews.publishAt,
                    transitionOnUserGestures: true,
                    child: FancyShimmerImage(
                      boxFit: BoxFit.fill,
                      errorWidget: Icon(
                        IconlyBold.image,
                        size: 90,
                      ),
                      imageUrl: currentNews.urlToImage,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Share.share('check out ${currentNews.url}',
                              subject: '');
                        },
                        child: Card(color:Theme.of(context).canvasColor,

                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              IconlyLight.send,
                              size: 28,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                      Consumer<BookmarkProvider>(
                          builder: (context, provider, child) {
                        var isInBookmark =
                            provider.isinBookmark(publishedAt!);
                        return GestureDetector(
                          onTap: () async {
                            if (isInBookmark) {
                              provider.deleteBookmark(key: provider.bookmarksModel!.bookMarkKey);
                              log(isInBookmark.toString());
                            } else {
                              await provider.addToBookmark(
                                newsModel: currentNews,
                              );
                              setState(() {
                                isInBookmark = true;
                              });
                              log(isInBookmark.toString());
                            }
                          },

                          child: Card(
                            color: Theme.of(context).canvasColor,
                            elevation: 10,
                            shape: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isInBookmark
                                    ? IconlyBold.bookmark
                                    : IconlyLight.bookmark,
                                size: 28,
                                color: isInBookmark ? Colors.green :Theme.of(context).cardColor,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextContent(
                  label: 'Description',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                TextContent(
                  label: currentNews.description,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(height: 25),
                const TextContent(
                  label: 'Contents',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                TextContent(
                  label: currentNews.content,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    Key? key,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      label,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
