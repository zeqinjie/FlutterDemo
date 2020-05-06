import 'package:flutter/material.dart';

/* 可滚动组件简介
*  常用的 ListView、GridView 滚动组件都直接或间接包含一个Scrollable组件
*  Scrollable({
    ...
    this.axisDirection = AxisDirection.down, //滚动方向
    this.controller, //此属性接受一个ScrollController对象。ScrollController的主要作用是控制滚动位置和监听滚动事件。默认情况下，Widget树中会有一个默认的PrimaryScrollController
    this.physics, //此属性接受一个ScrollPhysics类型的对象，它决定可滚动组件如何响应用户操作，比如用户滑动完抬起手指后，继续执行动画；或者滑动到边界时，如何显示
    @required this.viewportBuilder, //
  })
  *
  * //滚动条
  * Scrollbar(
      child: SingleChildScrollView(
      ...
    ),
  );
  * CupertinoScrollbar是iOS风格的滚动条，如果你使用的是Scrollbar，那么在iOS平台它会自动切换为CupertinoScrollbar
*
* */


class MySingleChildScrollViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MySingleChildScrollViewWidgetState();
  
}

class MySingleChildScrollViewWidgetState extends State<MySingleChildScrollViewWidget> {
  /*
  * SingleChildScrollView({
      this.scrollDirection = Axis.vertical, //滚动方向，默认是垂直方向
      this.reverse = false,//是否按照阅读方向相反的方向滑动
      this.padding,
      bool primary,//指是否使用widget树中默认的PrimaryScrollController
      this.physics,
      this.controller,
      this.child,
    })
  *
  * SingleChildScrollView不支持基于Sliver的延迟实例化模型，所以如果预计视口可能包含超出屏幕尺寸太多的内容时，
    那么使用SingleChildScrollView将会非常昂贵（性能差）,考虑支持Sliver延迟加载的可滚动组件，如ListView
  * */
  @override
  Widget build(BuildContext context) =>  getSingleChildScrollViewWidget();

  Widget getSingleChildScrollViewWidget(){
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(// 滚动条
        child:SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: str.split("").map((e) => Text("$e",style: TextStyle(fontSize: 30),)).toList()
            ),
          ),
        ),
    );
  }

}

