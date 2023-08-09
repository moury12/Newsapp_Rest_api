import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/const/theme_data.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget({Key? key, required this.text, required this.color, required this.function, required this.fontStyle, required this.padding}) : super(key: key);
final String text;
final Color color;
final Function function;
final TextStyle fontStyle;
final double padding;
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(onTap: () {function();},
      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
          child: Padding(
            padding:  EdgeInsets.all(padding),
            child: Text(text,style:fontStyle,
           ),
          )),
    );
  }
}
