import 'package:flutter/material.dart';
import 'package:news_app/Controllers/News_provider.dart';
import 'package:news_app/Controllers/bookmarkProvider.dart';
import 'package:news_app/Controllers/dark_theme_provider.dart';
import 'package:news_app/page/home_screen.dart';
import 'package:news_app/const/theme_data.dart';
import 'package:provider/provider.dart';

import 'page/newsDetails.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
DarkThemeProvider themeProvider =DarkThemeProvider();

void getCurrentAppTheme() async{
  themeProvider.setDarkTheme = await themeProvider.darkThemePrefs.getDarkTheme() ?? false;
}
@override
  void initState() {
getCurrentAppTheme();
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool _isDark =true;
    return MultiProvider(
      providers:[  ChangeNotifierProvider<DarkThemeProvider>(
        create: (_) => themeProvider,
      ),ChangeNotifierProvider<NewsProvider>(
        create: (_) =>NewsProvider() ,
      ),
        ChangeNotifierProvider<BookmarkProvider>(
        create: (_) =>BookmarkProvider() ,
      ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context,provider,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NewsApp',
            theme: Styles.themeData(provider.getDarktheme,context),
            home: HomeScreen(),
            routes: {
              NewsDetailsScreen.routeName: (ctx) =>  NewsDetailsScreen(),

            },
          );
        }
      ),
    );
  }
}
