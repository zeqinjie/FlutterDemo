import 'dart:ffi';
import 'package:flutter/material.dart';

import 'ZQComposeWidget.dart';
import 'ZQCustomPaintWidget.dart';
import 'ZQGradientCircularProgressWidget.dart';
import 'ZQTurnBoxWidget.dart';

//课程文章  https://book.flutterchina.club/chapter10/
class TenthClassApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TenthClassApp DEMO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '第十章'),
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
      body: ZQGradientCircularProgressWidget(),
    );
  }
}