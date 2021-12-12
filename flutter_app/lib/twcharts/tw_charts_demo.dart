import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/tool/tw_app_color.dart';

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
      body: Center(
        child: Container(
          color: Colors.red,
          height: 300,
          width: 300,
          child: RepaintBoundary(
            child: CustomPaint(
              painter: TWChartsTrendChart([4,5,6,7,8,9],[10.0,15.0,20.0,30.0,40.0,25.0],194,160),
            ),
          ),
        ),
      ),
    );
  }
}

class TWChartsTrendChart extends CustomPainter {

  List<int> date = [4,5,6,7,8,9];
  List<double> point = [10.0,15.0,20.0,30.0,40.0,25.0];
  double width = 194;
  double height = 160;

  TWChartsTrendChart(this.date, this.point, this.width, this.height);


  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // Paint paint = Paint()..color = TWAppColor.tw126AFF;
    // paint
    //   ..strokeWidth = 2;
    // var startOffset = 100.0;


    Paint paint = Paint()..color = TWAppColor.tw126AFF;

    double dateSize = 20; // 月份文字大小
    double textT = height - dateSize;
    for(var i = 0; i < date.length; i++) {
      var textPainter = TextPainter(
        text: TextSpan(
            text: "${date[i]}月",
            style: TextStyle(color: Colors.black, fontSize: 12)),
        // textWidthBasis: TextWidthBasis.longestLine
      );
      double textL = ((i + 1) * 10 + dateSize * i).toDouble();
      canvas.drawRect(
          Rect.fromLTRB(textL, textT, textPainter.width,
              textPainter.height),
          paint);
      textPainter.layout();
      textPainter.paint(canvas, Offset(100, 100));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }


}

class TWChartsPainter extends CustomPainter {

  TWChartsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = TWAppColor.tw126AFF;
    canvas.translate(size.width/2, size.height/2);
    paint
      ..strokeWidth = 2;
    //坐标系
    canvas.drawPoints(PointMode.lines, [Offset(-size.width/2,0),Offset(size.width/2,0)], paint..color=Colors.black..strokeWidth=0/5);
    canvas.drawPoints(PointMode.lines, [Offset(0,-size.height/2),Offset(0,size.height/2,)], paint..color=Colors.black..strokeWidth=0.5);

    final dot=[
      Offset(10, 10),
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

