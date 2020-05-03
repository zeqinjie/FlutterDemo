import 'package:flutter/material.dart';
class MyAlignWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAlignWidgetState();
}

class MyAlignWidgetState extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getCenterWidget();
  }

  /*  Align 组件可以调整子组件的位置，并且可以根据子组件的宽高来确定自身的的宽高
  *   alignment : 需要一个AlignmentGeometry类型的值，表示子组件在父组件中的起始位置。
  *               AlignmentGeometry 是一个抽象类，它有两个常用的子类：Alignment和 FractionalOffset
  *   widthFactor和heightFactor是用于确定Align 组件本身宽高的属性；它们是两个缩放因子，会分别乘以子元素的宽、高，最终的结果就是Align 组件的宽高。
  *   如果值为null，则组件的宽高将会占用尽可能多的空间
  *
  *   Alignment(this.x, this.y)  Alignment继承自AlignmentGeometry
  *   Alignment Widget会以矩形的中心点作为坐标原点，即Alignment(0.0, 0.0) 。而x轴的 -1 ~ 1即是左到右，y轴的 -1~1 即是顶到底，
      所以Alignment(1.0, -1.0) 即为 Alignment.topRight  实际偏移 = ((Alignment.x + 1)*childWidth/2, (Alignment.y+1)*childHeight/2)
  *   FractionalOffset 继承 Alignment，坐标原点为左侧顶点  实际偏移 = (FractionalOffse.x * childWidth, FractionalOffse.y * childHeight)
  * */
  Widget getAlginWidget(){
    return Container(
//      height: 120.0,
//      width: 120.0,
      color: Colors.blue[50],
      child: Align(
        widthFactor: 2, //缩放系数，通过其计算父widget宽高
        heightFactor: 2,
        alignment: Alignment(0.0, 0.0), //Alignment.topRight,  Alignment(1.0, -1.0) , FractionalOffset(1, 0) 三者相同位置
        child:Container(
          width: 60,
          height: 60,
          color: Colors.red,
        ),
      ),
    );
  }

  /*Align和Stack对比
  * 定位参考系统不同；Stack/Positioned定位的的参考系可以是父容器矩形的四个顶点；
    而Align则需要先通过alignment 参数来确定坐标原点，不同的alignment会对应不同原点，最终的偏移是需要通过alignment的转换公式来计算出。
  * Stack可以有多个子元素，并且子元素可以堆叠，而Align只能有一个子元素，不存在堆叠。
  * */


  /*
  *  Center 组件继承Align
  *  如Align 一样widthFactor或heightFactor为null时组件的宽高将会占用尽可能多的空间
  * */
  Widget getCenterWidget(){
//    return Center(
//      child: Container(
//        child: Text("hello word"),color: Colors.red,),
//    );

    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
      child: Center(
//        widthFactor: 1,
//        heightFactor: 1, //没有定义这时候默认是会尽可能占用多空间
        child: Text("xxx"),
      ),
    );
  }
}