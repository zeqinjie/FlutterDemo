import 'package:flutter/material.dart';

class MyContainerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyContainerWidgetState();
}

class MyContainerWidgetState extends State {
  /*
  * 1.它本身不对应具体的RenderObject，它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器
  * 2.容器的大小可以通过width、height属性来指定，也可以通过constraints来指定；如果它们同时存在时，width、height优先。
    实际上Container内部会根据width、height来生成一个constraints。
  * 3.color和decoration是互斥的，如果同时设置它们则会报错！实际上，当指定color时，Container内会自动创建一个decoration
  *
  * Container({
      this.alignment,
      this.padding, //容器内补白，属于decoration的装饰范围
      Color color, // 背景色
      Decoration decoration, // 背景装饰
      Decoration foregroundDecoration, //前景装饰
      double width,//容器的宽度
      double height, //容器的高度
      BoxConstraints constraints, //容器大小的限制条件
      this.margin,//容器外补白，不属于decoration的装饰范围
      this.transform, //变换
      this.child,
  })
  * */

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getPaddingMarginContainerWidget();
  }

  Widget getContainerWidget(){
    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 120.0), //容器外填充
      constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0), //卡片大小
      decoration: BoxDecoration(//背景装饰
          gradient: RadialGradient( //背景径向渐变
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: .98
          ),
          boxShadow: [ //卡片阴影
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0
            )
          ]
      ),
      transform: Matrix4.rotationZ(.2), //卡片倾斜变换
      alignment: Alignment.center, //卡片内文字居中
      child: Text( //卡片文字
        "5.20", style: TextStyle(color: Colors.white, fontSize: 40.0),
      ),
    );
  }

  /*
  * margin:容器外补白
  * padding:容器内补白
  *
  * */
  Widget getPaddingMarginContainerWidget(){
    return Column(children: [
      Container(
        child:Text("hello word"),//容器外补白
        margin: EdgeInsets.all(10),
        color: Colors.blue,
      ),
      Container(
        child:Text("zheng ze qin"),//容器内补白
        padding: EdgeInsets.all(10),
        color: Colors.red,
      ),
    ],);

     //事实上，Container内margin和padding都是通过Padding 组件来实现的，上面的示例代码实际上等价于：
    return Column(children: [
      Padding(
        padding: EdgeInsets.all(10.0),
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text("Hello world!"),
        ),
      ),
      DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("zheng ze qin"),
        ),
      ),
    ]);
  }

}