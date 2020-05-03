import 'package:flutter/material.dart';

class MyStackAndPositionedWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyStackAndPositionedWidgetState();
}

class MyStackAndPositionedWidgetState extends State<MyStackAndPositionedWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getStackWidget();
  }

  /*Flutter中使用Stack和Positioned这两个组件来配合实现绝对定位。Stack允许子组件堆叠，
    而Positioned用于根据Stack的四个角来确定子组件的位置。
  *
  *
  * */

  /* Stack
  *  alignment:特指没有在某一个轴上定位：left、right为横轴，top、bottom为纵轴，只要包含某个轴上的一个定位属性就算在该轴上有定位
  *  textDirection:alignment对齐的参考系
  *  fit：此参数用于确定没有定位的子组件如何去适应Stack的大小。StackFit.loose表示使用子组件的大小，StackFit.expand表示扩伸到Stack的大小。
  *  overflow：此属性决定如何显示超出Stack显示空间的子组件；值为Overflow.clip时，超出部分会被剪裁（隐藏），值为Overflow.visible 时则不会。
  *
  *  Positioned
  *  left、top 、right、 bottom分别代表离Stack左、上、右、底四边的距离
  *  width和height用于指定需要定位元素的宽度和高度
  *  注意：在水平方向时，你只能指定left、right、width三个属性中的两个。自动计算另外其一
  *       同理垂直方向，你指定top、bottom、height
  * */

  Widget getStackWidget(){
    //ConstrainedBox 约束箱，使用其保Stack占满屏幕
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,//默认居中显示
        fit: StackFit.loose,       //未定位widget占满Stack整个空间,
        children: [
          Positioned(
//            right: 18.0,
            child: Container(
              color: Colors.red,
              child: Text("Hello world",style: TextStyle(color: Colors.white)),
            ),
          ),
          Positioned(
            left: 18.0,
            child: Text("I am Jack"),
          ),
          Positioned(
            top: 18.0,
            child: Text("Your friend"),
          )
        ],
      ),
    );
  }


}