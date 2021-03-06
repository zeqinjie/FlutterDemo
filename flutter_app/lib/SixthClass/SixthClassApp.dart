import 'dart:ffi';
import 'package:flutter/material.dart';
import 'ZQCustomScrollViewWidget.dart';
import 'ZQGridViewWidget.dart';
import 'ZQListViewWidget.dart';
import 'ZQScrollController.dart';
import 'ZQSingleChildScrollViewWidget.dart';

//课程文章  https://book.flutterchina.club/chapter6/
class SixthClassApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SevenClassApp DEMO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),// 注意设置MyHomePage 路由注册首页方式需注释掉，否则会重复注册报错
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ZQScrollControllerWidget(),
    );
  }

}