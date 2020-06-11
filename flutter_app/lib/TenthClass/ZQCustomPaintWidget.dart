import 'dart:math';

import 'package:flutter/material.dart';

class ZQCustomPaintWidget extends StatefulWidget {
  ZQCustomPaintWidget({Key key}) : super(key: key);

  @override
  _ZQCustomPaintWidgetState createState() {
    return _ZQCustomPaintWidgetState();
  }
}

/*
CustomPaint({
  Key key,
  this.painter,
  this.foregroundPainter,
  this.size = Size.zero,
  this.isComplex = false,
  this.willChange = false,
  Widget child, //子节点，可以为空
})
painter: 背景画笔，会显示在子节点后面;
foregroundPainter: 前景画笔，会显示在子节点前面
size：当child为null时，代表默认绘制区域大小，如果有child则忽略此参数，画布尺寸则为child尺寸。如果有child但是想指定画布为特定大小，可以使用SizeBox包裹CustomPaint实现。
isComplex：是否复杂的绘制，如果是，Flutter会应用一些缓存策略来减少重复渲染的开销。
willChange：和isComplex配合使用，当启用缓存时，该属性代表在下一帧中绘制是否会改变。

CustomPaint
* 1.Canvas：一个画布
* 2.Size：当前绘制区域大小。

Paint
* 1.画笔Paint

* */
class _ZQCustomPaintWidgetState extends State<ZQCustomPaintWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: CustomPaint(
        size: Size(300,300),
        painter: ZQPainter(),
      ),
    );
  }
}

class ZQPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // 十五等分
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint); //画布的范围 size paint 画笔

    //画棋盘网格
    paint..style = PaintingStyle.stroke // 线
      ..color = Colors.black
      ..strokeWidth = 1.0;

    for (int i = 0;i <= 15; ++i){
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    //设置画笔颜色
    paint..style = PaintingStyle.fill
         ..color = Colors.black;
    //画一个黑子
    canvas.drawCircle(
        Offset(size.width / 2 - eWidth / 2, size.height / 2 - eHeight / 2),
        min(eWidth / 2, eHeight / 2) -2,
        paint);

    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2 + eWidth / 2, size.height / 2 - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }

  /*
  * 性能
  * 1、尽可能的利用好shouldRepaint返回值；在UI树重新build时，控件在绘制前都会先调用该方法以确定是否有必要重绘；
  *    假如我们绘制的UI不依赖外部状态，那么就应该始终返回false，因为外部状态改变导致重新build时不会影响我们的UI外观；
  *    如果绘制依赖外部状态，那么我们就应该在shouldRepaint中判断依赖的状态是否改变，如果已改变则应返回true来重绘，反之则应返回false不需要重绘。
  * 2、绘制尽可能多的分层；在上面五子棋的示例中，我们将棋盘和棋子的绘制放在了一起，这样会有一个问题：由于棋盘始终是不变的，用户每次落子时变的只是棋子，
  *    但是如果按照上面的代码来实现，每次绘制棋子时都要重新绘制一次棋盘，这是没必要的。优化的方法就是将棋盘单独抽为一个组件，
  *    并设置其shouldRepaint回调值为false，然后将棋盘组件作为背景。然后将棋子的绘制放到另一个组件中，这样每次落子时只需要绘制棋子。
  * */
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
    return true;
  }

}
