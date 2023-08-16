import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/const/global_methods.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../const/utils.dart';


class NewsDetailsWebView extends StatefulWidget {
  const NewsDetailsWebView({Key? key, required this.url}) : super(key: key);
final String url;
  @override
  State<NewsDetailsWebView> createState() => _NewsDetailsWebViewState();
}

class _NewsDetailsWebViewState extends State<NewsDetailsWebView> {
  late WebViewController _webViewController;
  double _progress = 0.0;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return WillPopScope(
      onWillPop: () async{
        if(await _webViewController.canGoBack()){
          _webViewController.goBack();
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: color),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,

            centerTitle: true,
            title: Text(
             widget.url,
              style: TextStyle(color: color),
            ),
            actions: [
              IconButton(
                onPressed: () async{
                   await showModalbottomSheet();
                },
                icon: const Icon(
                  Icons.more_horiz,
                ),
              ),
            ]),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress == 1.0 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
Expanded(
  child:   WebView( initialUrl:widget.url,
  onProgress: (progress) {
  
  setState(() {
  
    _progress =progress/ 100;
  
  });
  
  },
  
    onWebViewCreated: (controller) {setState(() {
  
        _webViewController=controller;
  
    });
  
    },
  
  ),
)
          ],
        ),
      ),
    );
  }

 Future<void>  showModalbottomSheet() async {
    await showModalBottomSheet(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      context: context,
      builder:
        (context) {
          return Container(
            decoration: BoxDecoration( color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child:  Column(mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 5, width: 39,
                  color: Colors.grey.shade300,),
                ),
                SizedBox(height: 10,),
                Text('More options',style: GoogleFonts.actor( fontSize:15, fontWeight: FontWeight.w700),),
                SizedBox(height: 10,),
                Divider(thickness: 2,),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share',style: GoogleFonts.actor( fontSize:15,
                      color: Colors.grey.shade700,fontWeight: FontWeight.w500),),
                  onTap: () async{
                  await  Share.share('check out ${widget.url}', subject: '');                  },
                ),  ListTile(
                  leading: Icon(Icons.link),
                  onTap: () async {
                    if (!await launchUrl(Uri.parse(widget.url))) {
                      GlobalMethods.errorDialog(
                          'Cannot open in browawe', context);
                    }


                  },
          title: Text('Open in browser',style: GoogleFonts.actor( fontSize:15,
          color: Colors.grey.shade700,fontWeight: FontWeight.w500
          )
          ,
          )),  ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Refresh',style: GoogleFonts.actor( fontSize:15,
                      color: Colors.grey.shade700,fontWeight: FontWeight.w500),),
                  onTap: () async{
                    try{
                      await _webViewController.reload();
                    }catch(e){
                      print(e.toString()) ;
                    }finally{
                      Navigator.pop(context);
                    }


                  },
                )
              ],
            ),
          );
        },
    );
 }
}
