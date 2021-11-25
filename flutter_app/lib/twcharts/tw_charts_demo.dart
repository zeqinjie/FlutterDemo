import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// https://blog.csdn.net/weixin_45029658/article/details/120325909
class TWChartsDemo extends StatelessWidget {
  const TWChartsDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '折线图',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TWChartsApp(),
    );
  }
}

class TWChartsApp extends StatefulWidget {

  @override
  _TWChartsAppState createState() => _TWChartsAppState();
}

class _TWChartsAppState extends State<TWChartsApp> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: RepaintBoundary(
          child: CustomPaint(
            painter: Line1(),
          ),
        ),
      ),
    );
  }
}

class Line1 extends CustomPainter{
  Line1();
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.lightBlueAccent;
    canvas.translate(size.width/2, size.height/2);
    paint
      ..strokeWidth = 2;
    //坐标系
    canvas.drawPoints(PointMode.lines, [Offset(-size.width/2,0),Offset(size.width/2,0)], paint..color=Colors.black..strokeWidth=0/5);
    canvas.drawPoints(PointMode.lines, [Offset(0,-size.height/2),Offset(0,size.height/2,)], paint..color=Colors.black..strokeWidth=0.5);

    final dot=[
      Offset(0, 0),
      Offset(40, -40),
      Offset(80, -20),
      Offset(120, -100),
      Offset(140, -20),
      Offset(180, -40),
      Offset(190, 0),
    ];
    Path _path923 = Path();
    _path923..moveTo(0, 0)..lineTo(40, -40)..lineTo(80, -20)..lineTo(120, -100)..lineTo(140, -20)..lineTo(180, -40)..lineTo(190, 0)..close();
    // canvas.drawPath(_path923, paint..color=Colors.white);
    canvas.drawPoints(PointMode.polygon, dot, paint..strokeWidth=2..color= Color.fromRGBO(104, 232, 190, 1),
    );
    var rect1= Rect.fromLTRB(0, -200, 190, 0);
    var colors = [
      Color.fromRGBO(104, 232, 190, 1),
      Color.fromRGBO(104, 232, 190, 0.8),
      Color.fromRGBO(104, 232, 190, 0.6),
      Color.fromRGBO(104, 232, 190, 0.4),
      Color.fromRGBO(104, 232, 190, 0.3),
      Color.fromRGBO(104, 232, 190, 0.2),
      Color.fromRGBO(104, 232, 190, 0.1),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    paint.shader = ui.Gradient.linear(
      rect1.topCenter, rect1.bottomCenter,
      colors, pos, );
    canvas.clipPath(_path923);
    canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

}

