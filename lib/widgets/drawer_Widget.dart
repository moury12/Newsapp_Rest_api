import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Controllers/dark_theme_provider.dart';
import 'package:news_app/pages/bookmarks_screen.dart';
import 'package:news_app/pages/home_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../pages/search_screen.dart';
class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeStatus =Provider.of<DarkThemeProvider>(context);

    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(decoration: BoxDecoration(color: Theme.of(context).canvasColor),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: ClipRRect(borderRadius: BorderRadius.circular(90),

                        child: Container(color: Colors.white,
                            child: Image.asset('assets/logo.png',height:70,width:70,)))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('News App',style: GoogleFonts.lobster()),
                )
              ],
            ),

            ),  ListTile(leading: Icon(IconlyLight.home),title: Text('Home',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
            ),onTap: () {
             Navigator.pushReplacement(context,  PageTransition(child:HomeScreen() ,ctx: context,
               type: PageTransitionType.rightToLeft ,
               //inheritTheme: true
             ));
            },
            ),ListTile(onTap: () {
              Navigator.push(context, PageTransition(child:BookmarkScreen() ,ctx: context,
                type: PageTransitionType.rightToLeft ,
                //inheritTheme: true
              )
              );
            },
              leading: Icon(IconlyLight.bookmark),title: Text('Bookmarks',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
            ),
            SwitchListTile(
              activeColor: Colors.deepPurple.shade100,
              title: Text('Theme',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                secondary: Icon(themeStatus.getDarktheme?Icons.dark_mode:Icons.light_mode),
                value: themeStatus.getDarktheme, onChanged: (bool value) {
                  setState(() {
                    themeStatus.setDarkTheme=value;
                  });
                },),

          ],
        ),
      ),
    );
  }
}
