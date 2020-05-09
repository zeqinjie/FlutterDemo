import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Tool/MyToolWidget.dart';

class MyGridViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyGridViewWidgetState();

}

//GridView可以构建一个二维网格列表
/*
* GridView({
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry padding,
    @required SliverGridDelegate gridDelegate, //控制子widget layout的委托
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    double cacheExtent,
    List<Widget> children = const <Widget>[],
  })

* */
class MyGridViewWidgetState extends State<MyGridViewWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getGirdViewCountWidgte();
  }

  List<IconData> icons = [Icons.ac_unit,
                          Icons.airport_shuttle,
                          Icons.all_inclusive,
                          Icons.beach_access,
                          Icons.cake,
                          Icons.free_breakfast];


/*
*  *
  *
  SliverGridDelegateWithFixedCrossAxisCount({
    @required double crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
  })
  * crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商。
  * mainAxisSpacing：主轴方向的间距。
  * crossAxisSpacing：横轴方向子元素的间距。
  * childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。
*
* */
  Widget getGirdViewWidgte(){
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //横轴三个子widget
            childAspectRatio: 1.0 //宽高比为1时，子widget
        ),
        children:icons.map((e) {
          return Container(child: Icon(e),color: MyToolWidget.getRandomColor(),);
        }).toList(),
    );
  }

  //GridView.count 构造函数
  Widget getGirdViewCountWidgte(){
    return GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 1.0/2.0,
        children:icons.map((e) {
          return Container(child: Icon(e),color: MyToolWidget.getRandomColor(),);
        }).toList(),
    );
  }
}

