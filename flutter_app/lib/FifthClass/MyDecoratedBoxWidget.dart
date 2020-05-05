import 'package:flutter/material.dart';

class MyDecoratedBoxWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyDecoratedBoxWidgetState();
}

class MyDecoratedBoxWidgetState extends State<MyDecoratedBoxWidget> {

  /*DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等。
  * decoration：代表将要绘制的装饰，它的类型为Decoration。Decoration是一个抽象类，
    它定义了一个接口 createBoxPainter()，子类的主要职责是需要通过实现它来创建一个画笔，该画笔用于绘制装饰
  * position：此属性决定在哪里绘制Decoration，它接收DecorationPosition的枚举类型，该枚举类有两个值
              background:在子组件之后绘制，即背景装饰。
              foreground：在子组件之上绘制，即前景。
  *
  * BoxDecoration 它是一个Decoration的子类
  * BoxDecoration({
      Color color, //颜色
      DecorationImage image,//图片
      BoxBorder border, //边框
      BorderRadiusGeometry borderRadius, //圆角
      List<BoxShadow> boxShadow, //阴影,可以指定多个
      Gradient gradient, //渐变
      BlendMode backgroundBlendMode, //背景混合模式
      BoxShape shape = BoxShape.rectangle, //形状
  })
  *
  * */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getDecoratedBoxWidget();
  }

  Widget getDecoratedBoxWidget(){
    return DecoratedBox(
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.difference,
        border: Border.all(color: Colors.yellow),
        borderRadius: BorderRadius.circular(3.0),//3像素圆角
        boxShadow: [ //阴影
          BoxShadow(
              color:Colors.orange,
              offset: Offset(2.0,2.0),
              blurRadius: 4.0
          )
        ],
        //RadialGradient SweepGradient 渐变
        gradient: LinearGradient(colors: [ //背景渐变
          Colors.red,Colors.blue
        ]),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text("hello word"),
      ),
    );
  }

}