import 'dart:ffi';
import 'package:flutter/material.dart';

import 'MyGestureDetectorWidget.dart';
import 'MyPointerEventWidget.dart';
//课程文章  https://book.flutterchina.club/chapter8/
class EighthClassApp extends StatelessWidget {
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
      body: Center(child: MyGestureDetectorWidget(),),
      floatingActionButton: FloatingActionButton(child: Text("push"),onPressed: (){

      },),
    );
  }

}