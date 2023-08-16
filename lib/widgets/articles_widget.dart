import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Model/bookmarks_model.dart';
import 'package:news_app/Model/newsModel.dart';
import 'package:news_app/Screens/newsDetails.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Screens/news_details_webview.dart';
import '../const/utils.dart';

class ArticlesWidget extends StatelessWidget {
  const ArticlesWidget({Key? key,  this.bookmared=false }) : super(key: key);
 final bool bookmared;
  @override
  Widget build(BuildContext context) {
    dynamic newsProvider =bookmared==true? Provider.of<BookmarksModel>(context) :Provider.of<NewsModel>(context);
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).canvasColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, NewsDetailsScreen.routeName,arguments: newsProvider.publishAt);
          },
          child: Stack(
            children: [
              Container(
                height: 70,
                width: 70,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 50,
                  width: 50,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).canvasColor,
                //padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(tag: newsProvider.publishAt,
                        child: FancyShimmerImage(
                            height: size.height * 0.19,
                            width: size.height * 0.19,
                            boxFit: BoxFit.fill,
                            imageUrl:newsProvider.urlToImage,

                        errorWidget:Icon(IconlyBold.image ,size: 70,)
                        ),
                      ),
                    ), Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              newsProvider.title,
                              textAlign: TextAlign.justify,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: smallTextStyle,
                            ),
                          ),
                          const SizedBox(height:5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '🕒 ${newsProvider.readingTimeText}',
                              style: smallTextStyle,
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () { Navigator.push(context, PageTransition(child:NewsDetailsWebView
                                    (url:newsProvider.url ) ,ctx: context,
                                    type: PageTransitionType.rightToLeft ,
                                    //inheritTheme: true
                                  ));},
                                  icon: Icon(Icons.link_rounded,color: Colors.deepPurple.shade400,)
                                ),
                                Text(
                                  newsProvider.dateToshow,
                                  maxLines: 1,
                                  style: GoogleFonts.adamina(fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
