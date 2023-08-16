import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Controllers/News_provider.dart';
import 'package:news_app/Controllers/dark_theme_provider.dart';
import 'package:news_app/page/search_screen.dart';
import 'package:news_app/const/utils.dart';
import 'package:news_app/const/vars.dart';
import 'package:news_app/widgets/drawer_Widget.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:news_app/widgets/loading_widget.dart';
import 'package:news_app/widgets/tabs_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Model/newsModel.dart';
import '../widgets/articles_widget.dart';
import '../widgets/top_tending.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  var newsType =NewsType.allNews;
  int currentindex=0;

  String sortBy = SortByEnum.PublishedAt.name;
  @override
  Widget build(BuildContext context) {
    final newsProvider= Provider.of<NewsProvider>(context,listen: false);
    Size size = Utils(context).getScreenSize;
    final themeStatus =Provider.of<DarkThemeProvider>(context);
    final Color color =Utils(context).getColor;
    return SafeArea(
      child: Scaffold(resizeToAvoidBottomInset: false,

          appBar: AppBar(
        foregroundColor: themeStatus.getDarktheme ? Colors.white: Colors.black54,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
title: Text('News App',style: GoogleFonts.lobster()),centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, PageTransition(child:SearchScreen() ,ctx: context,
               type: PageTransitionType.rightToLeft ,
                //inheritTheme: true
            ));
          }, icon: Icon(IconlyLight.search))
        ],
      ),
        drawer: DrawerWidget(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabsWidget(text: "All News", color: newsType==NewsType.allNews?Theme.of(context).canvasColor:Colors.transparent,
              function:(){ if(newsType==NewsType.allNews){
                return;
              }setState(() {
                newsType=NewsType.allNews;
              }); },padding:newsType==NewsType.allNews?18:10 ,
            fontStyle:newsType==NewsType.allNews?GoogleFonts.bakbakOne(color:Theme.of(context).cardColor): GoogleFonts.actor()),
              SizedBox(width: 20,),
              TabsWidget(text: "Top Trending", color: newsType==NewsType.topTrending?Theme.of(context).canvasColor:Colors.transparent,
                  function:(){ if(newsType==NewsType.topTrending){
                    return;
                  }setState(() {
                    newsType=NewsType.topTrending;
                  }); },padding:newsType==NewsType.topTrending?18:10 ,
                  fontStyle:newsType==NewsType.topTrending?GoogleFonts.bakbakOne(color:Theme.of(context).cardColor): GoogleFonts.actor())
            ],
          ),
        ),

        newsType==NewsType.topTrending?Container():
       SizedBox(height: kBottomNavigationBarHeight,
         child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            scrolButtons(
                'Prev', GoogleFonts.bakbakOne(), (){if(currentindex==0){
              return;
            }setState(() {
              currentindex -=1;
            });
    },'smske'
    ),
              Flexible(flex: 2,
                child: ListView.builder( scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(onTap: () {
setState(() {
  currentindex=index;
});
                      },
                        child: Center(
                          child: Container(decoration:
                          BoxDecoration(color:currentindex==index?Colors.deepPurple.shade100: Theme.of(context).canvasColor,borderRadius: BorderRadius.circular(25)),
                              child:
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text("${index+1}",style: GoogleFonts.bakbakOne(color:Theme.of(context).cardColor),),
                          )),
                        ),
                      ),
                    );
                  },
                ),
              ),
              scrolButtons('Next', GoogleFonts.bakbakOne(), (){if(currentindex==4){
                return;
              }setState(() {
                currentindex
                +=1;
              });}, 'ssdwe')
            ],
          ),
       ),
        newsType==NewsType.topTrending?Container(): Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(decoration:
            BoxDecoration( color: Theme.of(context).canvasColor,borderRadius: BorderRadius.circular(15)),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0).copyWith(left: 8),
                child: DropdownButton(icon: Icon(IconlyLight.arrowDownCircle,color:Theme.of(context).cardColor,),
                    dropdownColor: Colors.white,style:GoogleFonts.actor(color: Theme.of(context).cardColor,fontWeight: FontWeight.w600) ,
                    underline: SizedBox(),
                    items: dropdownItems,value: sortBy,
                    onChanged: (String? value){
setState(() {
  sortBy=value!;
});
                }
                ),
              ),
            ),
          ),
        ),
      FutureBuilder<List<NewsModel>>(
          future: newsType == NewsType.allNews?newsProvider.fetchAllNews(page: currentindex+1,sortBy: sortBy):newsProvider.fetchAlltopTrending(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return newsType == NewsType.allNews
                  ? LoadingWidget(newsType: newsType)
                  : Expanded(
                child: LoadingWidget(newsType: newsType),
              );
            } else if (snapshot.hasError) {
              return Expanded(
                child: EmptyNewsWidget(
                  text: "An error occured ${snapshot.error}",
                ),
              );
            } else if (snapshot.data == null) {
              return const Expanded(
                child: EmptyNewsWidget(
                  text: "No news found",
                ),
              );
            }
            return newsType == NewsType.allNews
                ? Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, index) {
                    return ChangeNotifierProvider.value(
                      value: snapshot.data![index],
                      child: ArticlesWidget(

                      ),
                    );
                  }),
            )
                : SizedBox(
              height: size.height * 0.6,
              child: Swiper(
                autoplayDelay: 8000,
                autoplay: true,
                itemWidth: size.width * 0.9,
                layout: SwiperLayout.STACK,
                viewportFraction: 0.9,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(value: snapshot.data![index],
                      child: TopTrendingWidget());
                },
              ),
            );
          })),
      //  LoadingWidget(newsType: newsType),      ],),),
    ])));
  }
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menu =[
      DropdownMenuItem(value:SortByEnum.PublishedAt.name ,
      child: Text(SortByEnum.PublishedAt.name,style: GoogleFonts.actor(fontSize: 12) ,),),
      DropdownMenuItem(value:SortByEnum.Relevancy.name ,
      child: Text(SortByEnum.Relevancy.name,style: GoogleFonts.actor(fontSize: 12) ,),),
      DropdownMenuItem(value:SortByEnum.Popularity.name ,
      child: Text(SortByEnum.Popularity.name,style: GoogleFonts.actor(fontSize: 12) ,),)
    ];
    return menu;
  }
  Widget scrolButtons(String text, TextStyle style, Function function,String herotag ){
    return   Padding(
      padding: const EdgeInsets.all(5.0),
      child: FloatingActionButton.extended(heroTag:herotag,
        onPressed: (){function();},
        label: Text(text,style:style ),
        backgroundColor: Colors.deepPurple.shade100,
      ),
    );
  }
}
