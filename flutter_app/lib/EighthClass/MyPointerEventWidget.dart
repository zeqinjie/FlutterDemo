import 'package:flutter/material.dart';

class MyPointerEventWidget extends StatefulWidget {
  MyPointerEventWidget({Key key}) : super(key: key);
  /*通过命中测试的组件才能触发事件*/

  /*
  * Listener({
    Key key,
    this.onPointerDown, //手指按下回调
    this.onPointerMove, //手指移动回调
    this.onPointerUp,//手指抬起回调
    this.onPointerCancel,//触摸事件取消回调
    this.behavior = HitTestBehavior.deferToChild, //在命中测试期间如何表现
    Widget child
  })
  *
  * */

  @override
  _MyPointerEventWidgetState createState() {
    return _MyPointerEventWidgetState();
  }
}

class _MyPointerEventWidgetState extends State<MyPointerEventWidget> {

  //定义一个状态，保存当前指针位置
  PointerEvent _event;

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
    return getListenerWidget();
  }

  /*
  * PointerEvent 属性
  * position：它是鼠标相对于当对于全局坐标的偏移。
  * delta：两次指针移动事件（PointerMoveEvent）的距离。
  * pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
  * orientation：指针移动方向，是一个角度值。
  * */

  Widget getListenerWidget() {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300.0,
        height: 150.0,
        child: Text(
          _event?.toString()??"",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          _event=event;
          print('手指按下回调：${event.pressure}');
        });
      },
      onPointerMove: (PointerMoveEvent event) {
        setState(() {
          _event=event;
          print('手指移动回调：${event.toString()??""}');
        });
      },
      onPointerUp: (PointerUpEvent event) {
        setState(() {
          _event=event;
          print('手指抬起回调：${event.pressure}');
        });
      },
    );
  }

  Widget getListenerWidget2() {
    return Listener(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(300.0, 150.0)),
          child: Center(child: Text("Box A",textAlign: TextAlign.center,)),
        ),
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) => print("down A")
    );
  }
}