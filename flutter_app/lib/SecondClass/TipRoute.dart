import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipRoute extends StatelessWidget{
  // 使用final修饰的变量必须进行初始化，一旦被赋值之后，不能够再次被赋值,否则编译会报错。
  final String text;
  TipRoute({
    Key key, //Key是Widget、Element和SemanticsNode的标识符
    @required this.text, //@required 用来规定某个数据在初始化的时候是必须要提供的，否则会报错。
  }) : super(key:key);

  // build 函数相当于 react.js 中的 render 函数
  // 必须 return 一个 UI 结构，用来构建当前控件对应的UI界面
  // 在 StatelessWidget 控件中，build 函数是必须的
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("提示")),
                      body: Padding(padding: EdgeInsets.all(18),
                                      child: Center(),));

  }


}