import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Model/newsModel.dart';
import 'package:provider/provider.dart';

import '../const/utils.dart';


class TopTrendingWidget extends StatelessWidget {
  const
  TopTrendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toptrending =Provider.of<NewsModel>(context,listen: false);
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
                  errorWidget:Icon(Icons.image,size: 90,),
                  imageUrl:toptrending.urlToImage,
                  height: size.height * 0.33,
                  width: double.infinity,
                ),
              ),
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                 ' ${toptrending.title}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              maxLines: 2,overflow: TextOverflow.ellipsis,  ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {},
                      icon: Icon(
                        Icons.link,
                        color: color,
                      )),
                  const Spacer(),
                  SelectableText(
                    toptrending.dateToshow,
                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
