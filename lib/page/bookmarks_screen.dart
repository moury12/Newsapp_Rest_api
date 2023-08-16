import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Controllers/bookmarkProvider.dart';
import 'package:news_app/Model/bookmarks_model.dart';
import 'package:news_app/const/vars.dart';
import 'package:news_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../const/utils.dart';
import '../widgets/articles_widget.dart';
import '../widgets/empty_screen.dart';


class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'Bookmarks',
            style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
        ),

         body: Column(children: [
           FutureBuilder<List<BookmarksModel>>(
             future: Provider.of<BookmarkProvider>(context,listen: false).getAllBookmarks(),
             builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return LoadingWidget(newsType: NewsType.allNews);
    }
    else if (snapshot.hasError) {
     return EmptyNewsWidget(
        text: 'An Error has occured',
     );
    }
    else if (snapshot.data == null) {
       return EmptyNewsWidget(
            text: 'You didn\'t add anything yet to your bookmarks',
        );
      }
return Expanded(
  child:   ListView.builder(
  
              itemCount: snapshot.data!.length,
  
              itemBuilder: (ctx, index) {
  
                return  ChangeNotifierProvider.value(value: snapshot.data![index],
  
                    child: ArticlesWidget(bookmared: true,));
  
              }),
);
           },)
         ],)

        //
        );
  }
}
