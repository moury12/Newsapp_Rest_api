import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

class GlobalMethods{
  static String fromattedDateText(String publishedAt){
    final parsedData =DateTime.parse(publishedAt);
    String formattedDate =DateFormat("yyyy-MM-dd hh:mm:ss").format(parsedData);
    DateTime publishedDate= DateFormat("yyyy-mm-dd hh:mm:ss").parse(formattedDate);
    return "${publishedDate.day}/${publishedDate.month}/${publishedDate.year} ON ${publishedDate.hour}:${publishedDate.minute}:${publishedDate.second}";
  }
static Future<void> errorDialog(String msg,BuildContext context) async{
  await showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Text(msg),
      title: Row(children: [
        Icon(IconlyBold.danger,color: Colors.red,),
        SizedBox(width: 5,),
        Text('An error occured'),
      ],),
      actions: [TextButton(onPressed: () {
        Navigator.pop(context);
      }, child: Text('Ok'))],
    );
  },);
}
}