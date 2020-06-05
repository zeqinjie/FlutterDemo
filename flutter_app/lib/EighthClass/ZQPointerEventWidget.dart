import 'package:flutter/material.dart';

class ZQPointerEventWidget extends StatefulWidget {
  ZQPointerEventWidget({Key key}) : super(key: key);
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
  _ZQPointerEventWidgetState createState() {
    return _ZQPointerEventWidgetState();
  }
}

class _ZQPointerEventWidgetState extends State<ZQPointerEventWidget> {

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
    return getIgnorePointerWidget();
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

  /*
  * behavior:HitTestBehavior
  * deferToChild :子组件会一个接一个的进行命中测试，如果子组件中有测试通过的，则当前组件通过，这就意味着，如果指针事件作用于子组件上时，其父级组件也肯定可以收到该事件
  * opaque:在命中测试时，将当前组件当成不透明处理(即使本身是透明的)，最终的效果相当于当前Widget的整个区域都是点击区域,
  * translucent:当点击组件透明区域时，可以对自身边界内及底部可视区域都进行命中测试，这意味着点击顶部组件透明区域时，顶部组件和底部组件都可以接收到事件
  * */
  Widget getListenerBehaviorOpaqueWidget() {
    return Listener(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(300.0, 150.0)),
          child: Center(child: Text(
            _event?.toString()??"hellow",
            style: TextStyle(color: Colors.yellow),
            textAlign: TextAlign.center,
          )),
        ),
//        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          _event=event;
          print('手指按下回调：${event.pressure}');
        },
    );
  }

  Widget getListenerBehaviorTranslucentWidget(){
    return Stack(
      children: <Widget>[
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300.0, 200.0)),
            child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.blue)),
          ),
          onPointerDown: (event) => print("down0"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200.0, 100.0)),
            child: Center(child: Text("左上角200*100范围内非文本区域点击")),
          ),
          onPointerDown: (event) => print("down1"),
          behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
        )
      ],
    );
  }

  /*
  * 假如我们不想让某个子树响应PointerEvent的话，我们可以使用IgnorePointer和AbsorbPointer，
  * 这两个组件都能阻止子树接收指针事件，不同之处在于AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与
  * */
  Widget getIgnorePointerWidget() {
    return Listener(
      child: AbsorbPointer( //AbsorbPointer 只响应up, 如果换成IgnorePointer 都不响应
        child: Listener(
          child: Container(
            color: Colors.red,
            width: 200.0,
            height: 100.0,
          ),
          onPointerDown: (event)=>print("in"),
        ),
      ),
      onPointerDown: (event)=>print("up"),
    );
  }

}