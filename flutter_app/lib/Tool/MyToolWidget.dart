

import 'dart:math';

import 'package:flutter/material.dart';

class MyToolWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("hello");
  }

  static Color getRandomColor() {
    return Color.fromARGB(
        255,
        Random.secure().nextInt(255),
        Random.secure().nextInt(255),
        Random.secure().nextInt(255));
  }

  /*
  * 0 是加载中 1 是加载完毕
  * */
  static Widget getLoadingWidget(int tag){
    if (tag == 0){
      return Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(strokeWidth: 2.0)
        ),
      );
    }
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Text("没有更多了", style: TextStyle(color: Colors.grey),)
    );

  }

}