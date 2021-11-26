import 'package:flutter/material.dart';
import 'tw_webview_panoramic_page.dart';

/// create by: zhengzeqin
/// create time: 2021/11/26 2:35 下午
/// des: 

class TWWebViewApp extends StatelessWidget {
  const TWWebViewApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VR",
      theme: ThemeData(
          primaryColor: Colors.red,
          primarySwatch: Colors.blue,
          splashColor: Colors.transparent
      ),
      home: TWWebViewPanoramicPage(),
    );
  }
}
