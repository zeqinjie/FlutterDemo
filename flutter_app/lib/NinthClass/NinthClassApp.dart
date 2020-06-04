import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutterapp/FourthClass/MyAlignWidget.dart';
import 'package:flutterapp/NinthClass/MyAnimationWidget.dart';

//课程文章  https://book.flutterchina.club/chapter9/
class NinthClassApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NinthClassApp DEMO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '第九章'),
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
      body: Container(
        child:MyAnimationWidget(),
      ),
    );
  }
}