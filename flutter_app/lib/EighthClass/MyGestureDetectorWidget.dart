import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Tool/MyToolWidget.dart';

class MyGestureDetectorWidget extends StatefulWidget {
  MyGestureDetectorWidget({Key key}) : super(key: key);

  @override
  _MyGestureDetectorWidgetState createState() {
    return _MyGestureDetectorWidgetState();
  }
}

class _MyGestureDetectorWidgetState extends State<MyGestureDetectorWidget> with SingleTickerProviderStateMixin {

  /*
  * GestureDetector是一个用于手势识别的功能性组件，我们通过它可以来识别各种手势。GestureDetector实际上是指针事件的语义化封装
  * */

  String _operation = "No Gesture detected!"; //保存事件名

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getGestureConflictWidget2();
  }

  /*
  * 注意： 当同时监听onTap和onDoubleTap事件时，当用户触发tap事件时，会有200毫秒左右的延时，
  * 这是因为当用户点击完之后很可能会再次点击以触发双击事件，所以GestureDetector会等一段时间来确定是否为双击事件。
  * 如果用户只监听了onTap（没有监听onDoubleTap）事件时，则没有延时。
  * */
  Widget getGestureDetectorWidget(){
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200.0,
          height: 100.0,
          child: Text(_operation,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText("Tap"),//点击
        onDoubleTap: () => updateText("DoubleTap"), //双击
        onLongPress: () => updateText("LongPress"), //长按
      ),
    );
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }

  double _top = 0.0; //距顶部的偏移
  double _left = 0.0;//距左边的偏移
  /*
  * 拖拽
  * DragDownDetails.globalPosition：当用户按下时，此属性为用户按下的位置相对于屏幕（而非父组件）原点(左上角)的偏移。
  * DragUpdateDetails.delta：当用户在屏幕上滑动时，会触发多次Update事件，delta指一次Update事件的滑动的偏移量。
  * DragEndDetails.velocity：该属性代表用户抬起手指时的滑动速度(包含x、y两个轴的），示例中并没有处理手指抬起时的速度，
    常见的效果是根据用户抬起手指时的速度做一个减速动画。
  * */

  Widget getDrapWidget(){
    return Stack(
      children: [
        Positioned(
            left: _left,
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(
                child:Text("a")
                ,),
              //手指按下时会触发此回调
              onPanDown: (e){
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${e.globalPosition}");
              },
              onPanEnd: (DragEndDetails e){
                //打印滑动结束时在x、y轴上的速度
                print(e.velocity);
              },
//              //手指滑动时会触发此回调
//              onPanUpdate: (DragUpdateDetails e) {
//                //用户手指滑动时，更新偏移，重新构建
//                setState(() {
//                  _left += e.delta.dx;
//                  _top += e.delta.dy;
//                });
//              },

              //垂直方向拖动事件 ,onHorizontalDragUpdate 水平
              onVerticalDragUpdate: (DragUpdateDetails e){
                setState(() {
                  _top += e.delta.dy;
                });
              },
            )
        ),
      ],
    );
  }

  /*
  * 缩放
  *
  * */
  double _width = 200.0; //通过修改图片宽度来达到缩放效果
  Widget getScaleWidget() {
    return Center(
      child: GestureDetector(
        //指定宽度，高度自适应
        child: Image.asset("assets/icons/taofang.png", width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
          print("${details.scale}");
          setState(() {
            //缩放倍数在0.8到10倍之间
//            _width=200*details.scale.clamp(.8, 10.0);
          _width = 200 * MyToolWidget.getDoubleRandom();
          });
        },
      ),
    );
  }

  /*
  * GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，
  * 而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势，GestureDetector直接可以接收一个子widget。
  * GestureRecognizer是一个抽象类，一种手势的识别器对应一个GestureRecognizer的子类，
  * Flutter实现了丰富的手势识别器，我们可以直接使用。
  *
  * */

  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关

  /*
  * 假设我们要给一段富文本（RichText）的不同部分分别添加点击事件处理器，但是TextSpan并不是一个widget，这时我们不能用GestureDetector，
  * 但TextSpan有一个recognizer属性，它可以接收一个GestureRecognizer。
  * */
  Widget getTextSpanWidget(){
    return Center(
      child: Text.rich(
          TextSpan(
              children: [
                TextSpan(text: "你好世界"),
                TextSpan(
                  text: "点我变色",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: _toggle ? Colors.blue : Colors.red
                  ),
                  recognizer: _tapGestureRecognizer..onTap = (){
                    setState(() {
                      _toggle = !_toggle;
                    });
                  },
                ),
                TextSpan(text: "你好世界"),
              ]
          )
      ),
    );
  }

  /*
  * 手势竞争与冲突
  * Flutter中的手势识别引入了一个Arena的概念，Arena直译为“竞技场”的意思，每一个手势识别器（GestureRecognizer）都是一个“竞争者”（GestureArenaMember），
    当发生滑动事件时，他们都要在“竞技场”去竞争本次事件的处理权，而最终只有一个“竞争者”会胜出(win)。
  * */
  Widget getBothDirectionWidget(){
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }

  /*
  * 手势冲突
  * 手势冲突只是手势级别的，而手势是对原始指针的语义化的识别，所以在遇到复杂的冲突场景时，
    都可以通过Listener直接识别原始指针事件来解决冲突。
  * */
  Widget getGestureConflictWidget(){
    return Stack(
      children: <Widget>[
        Positioned(
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")), //要拖动和点击的widget
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details){
              print("onHorizontalDragEnd");
            },
            onTapDown: (details){
              print("down");
            },
            onTapUp: (details){
              print("up");
            },
          ),
        )
      ],
    );
  }

  /*
  * 这时我们如果在外部再用onTapDown、onTapUp来监听的话是不行的。这时我们应该怎么做？其实很简单，通过Listener监听原始指针事件就行
  * */
  Widget getGestureConflictWidget2(){
    return Stack(
      children: <Widget>[
        Positioned(
          top:80.0,
          left: _left,
          child: Listener(
            onPointerDown: (details) {
              print("down");
            },
            onPointerUp: (details) {
              //会触发
              print("up");
            },
            child: GestureDetector(
              child: CircleAvatar(child: Text("B")),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print("onHorizontalDragEnd");
              },
            ),
          ),
        )
      ],
    );
  }
}