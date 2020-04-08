import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args = ModalRoute.of(context).settings.arguments;
    //
    debugPaintSizeEnabled = false;
    debugPaintBaselinesEnabled = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Text("this is new route",style: TextStyle(color: Colors.blue) ),
                                                    Text("hello come in",textAlign: TextAlign.left,),
                                                    ImageWidget()],),
      ),
    );
  }
}

//使用english_words包来生成随机字符串
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

//创建图片widget
class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return DecoratedBox(decoration:  BoxDecoration(image: DecorationImage(image: new AssetImage('assets/icons/taofang.png'),)));
    final name = "zzzz";
    debugPrint("ss$name");
    return Image.asset('assets/icons/taofang.png');
  }
}