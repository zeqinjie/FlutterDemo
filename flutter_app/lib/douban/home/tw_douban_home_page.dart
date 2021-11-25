import 'package:flutter/material.dart';
import 'package:flutterapp/douban/home/tw_douban_home_page_content.dart';

///@Description     xxxx
///@author          zhengzeqin
///@create          2021-11-25 22:23 

class TWDoubanHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: TWDoubanHomePageContent(),
    );
  }
}



