import 'dart:ffi';

import 'package:flutter/material.dart';
import 'ZQCounterWidget.dart';
import 'ZQButtonWidget.dart';
import 'ZQCupertinoWidget.dart';
import 'ZQPirctureAndIconWidget.dart';
import 'ZQProgressIndicatorWidget.dart';
import 'ZQSwitchAndCheckBoxWidget.dart';
import 'ZQTextFieldAndFormWidget.dart';
import 'ZQStateManagerWidget.dart';

//课程文章  https://book.flutterchina.club/chapter3/
class ThirdClassApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThirdClass DEMO',
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
      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            FlatButton(
//              child: Text("click this..."),
//              color: Colors.yellow,
//              onPressed: ()  async{
//                showAlertView();
//              },
//            ),
//          ],
//        ),
        child:ZQProgressIndicatorWidget(),
      ),
    );
  }

  //弹窗widget
  void showAlertView(){
    var alert = AlertDialog(title: Text("hello word..."));
//    showDialog(context: context,builder: (context)=> alert);
    showDialog(context: context,builder: (context) {
      return alert;
    });
    print("点击...");
  }
}