import 'package:flutter/material.dart';
//https://book.flutterchina.club/chapter3/progress.html
class MyProgressIndicatorWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyProgressIndicatorWidgetState();
}

class MyProgressIndicatorWidgetState extends State<MyProgressIndicatorWidget> with SingleTickerProviderStateMixin {

  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getAnimationProgressIndicatorColumnWidget();
  }

  /* LinearProgressIndicator是一个线性、条状的进度条，定义如下：
  *  value：value表示当前的进度，取值范围为[0,1]；如果value为null时则指示器会执行一个循环动画（模糊进度）；当value不为null时，指示器为一个具体进度的进度条。
  *  backgroundColor：指示器的背景色。
  *  valueColor: 指示器的进度条颜色；值得注意的是，该值类型是Animation<Color>，这允许我们对进度条的颜色也可以指定动画。
      如果我们不需要对进度条颜色执行动画，换言之，我们想对进度条应用一种固定的颜色，此时我们可以通过AlwaysStoppedAnimation来指定
  * */
  Widget getLinearProgressIndicatorColumnWidget() {
      return Column(children: [
        // 模糊进度条(会执行一个动画)
        LinearProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),//进度条显示50%
        LinearProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          value: .5,
        )
      ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,);
  }

  /*CircularProgressIndicator是一个圆形进度条，
  * strokeWidth 表示圆形进度条的粗细
  * */
  Widget getCircularProgressIndicatorColumnWidget(){
    return Column(children: [
      CircularProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(Colors.yellow),
      ),
      CircularProgressIndicator(
        semanticsLabel:"hellow",
        semanticsValue:"zzzz",
        value: 0.5,
        valueColor: AlwaysStoppedAnimation(Colors.red),),
    ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,);
  }

  /* 自定义尺寸 粗细取决父视图，可以采用父容器 ConstrainedBox，SizedBox 来限制大小
  *
  * */
  Widget getCustomProgressIndicatorColumnWidget(){
    return Column(children: [
      // 线性进度条高度指定为3
      SizedBox(
        height: 3,
        width: 100,
        child: LinearProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          value: .5,
        ),
      ),
      Container(height: 100,width: 400,
        child:  CircularProgressIndicator(
        semanticsLabel:"hellow",
        semanticsValue:"zzzz",
        value: 0.5,
        valueColor: AlwaysStoppedAnimation(Colors.red),),
      ),
    ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,);
  }

  //进度色动画
  Widget getAnimationProgressIndicatorColumnWidget(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(16),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: ColorTween(begin: Colors.grey, end: Colors.blue).animate(_animationController), // 从灰色变成蓝色
                value: _animationController.value,
              ),
          )
        ],
      ),
    );
  }

  //定制进度指示器风格样式，可以通过CustomPainter Widget 来自定义绘制逻辑，
  //* 实际上LinearProgressIndicator和CircularProgressIndicator也正是通过CustomPainter来实现外观绘制的
}


