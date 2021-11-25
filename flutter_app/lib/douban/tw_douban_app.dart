import 'package:flutter/material.dart';
import 'package:flutterapp/douban/main/tw_douban_main_page.dart';

///@Description     xxxx
///@author          zhengzeqin
///@create          2021-11-25 22:19 


class TWDoubanApp extends StatelessWidget {
  const TWDoubanApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "douban",
      theme: ThemeData(
        primaryColor: Colors.red,
        primarySwatch: Colors.green,
        splashColor: Colors.transparent
      ),
      home: TWDoubanMainPage(),
    );
  }
}
