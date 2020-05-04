
import 'package:flutter/material.dart';

class MyPaddingWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyPaddingWidgetState();
}

/* Padding 内边距
*  SliverPadding  列表缩进，应用于每个子元素
*  AnimatedPadding  缩进变化时的动画
* */
class MyPaddingWidgetState extends State {

  /* Padding填充容器 EdgeInsetsGeometry EdgeInsets类，它是EdgeInsetsGeometry的一个子类
  * EdgeInsets：参数
  * fromLTRB(double left, double top, double right, double bottom)：分别指定四个方向的填充。
  * all(double value) : 所有方向均使用相同数值的填充。
  * only({left, top, right ,bottom })：可以设置具体某个方向的填充(可以同时指定多个方向)。
  * symmetric({ vertical, horizontal })：用于设置对称方向的填充，vertical指top和bottom，horizontal指left和right。
  */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getPaddingWidget();
  }


  Widget getPaddingWidget(){
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Container(child: Text("hello word"),color: Colors.red,),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(child: Text("my name zhengzeqin"),color: Colors.green,),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(child: Text("your friend"),color: Colors.yellow,),
          ),
        ],
      ),
    );
  }
}