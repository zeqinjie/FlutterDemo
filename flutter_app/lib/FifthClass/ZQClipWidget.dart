import 'package:flutter/material.dart';

class ZQClipWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ZQClipWidgetState();
}

class ZQClipWidgetState extends State {

  Widget avatar = Image.asset("assets/icons/taofang.png", width: 60.0);
  /*
  * ClipOval	子组件为正方形时剪裁为内贴圆形，为矩形时，剪裁为内贴椭圆
  * ClipRRect	将子组件剪裁为圆角矩形
  * ClipRect	剪裁子组件到实际占用的矩形大小（溢出部分剪裁）
  * */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getCustomClipperWidget();
  }

  Widget getClipWidget(){

    return Center(
      child: Column(
        children: <Widget>[
          avatar, //不剪裁
          ClipOval(child: avatar), //剪裁为圆形
          ClipRRect( //剪裁为圆角矩形
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,//宽度设为原来宽度一半，另一半会溢出
                child: avatar,
              ),
              Text("你好世界", style: TextStyle(color: Colors.green),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRect(//将溢出部分剪裁
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,//宽度设为原来宽度一半
                  child: avatar,
                ),
              ),
              Text("你好世界",style: TextStyle(color: Colors.green))
            ],
          ),
        ],
      ),
    );
  }

  /*
  * CustomClipper
  * 可以使用CustomClipper来自定义剪裁区域
  * */
  Widget getCustomClipperWidget(){
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.red
      ),
      child: ClipRect(
          clipper: ZQCustomClipperWidget(), //使用自定义的clipper
          child: avatar
      ),
    );
  }
}

/*
* 1.getClip()     是用于获取剪裁区域的接口，由于图片大小是60×60，我们返回剪裁区域为Rect.fromLTWH(10.0, 15.0, 40.0, 30.0)，即图片中部40×30像素的范围。
* 2.shouldReclip()  接口决定是否重新剪裁。如果在应用中，剪裁区域始终不会发生变化时应该返回false，这样就不会触发重新剪裁，避免不必要的性能开销。
  如果剪裁区域会发生变化（比如在对剪裁区域执行一个动画），那么变化后应该返回true来重新执行剪裁
* */
class ZQCustomClipperWidget extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}