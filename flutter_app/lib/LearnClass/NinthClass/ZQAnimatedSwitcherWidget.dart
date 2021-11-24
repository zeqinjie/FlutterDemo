import 'package:flutter/material.dart';

class ZQAnimatedSwitcherWidget extends StatefulWidget {
  ZQAnimatedSwitcherWidget({Key key}) : super(key: key);

  @override
  _ZQAnimatedSwitcherWidgetState createState() {
    return _ZQAnimatedSwitcherWidgetState();
  }
}

/*
* 我们经常会遇到切换UI元素的场景，比如Tab切换、路由切换。为了增强用户体验，通常在切换时都会指定一个动画，以使切换过程显得平滑。
* Flutter SDK组件库中已经提供了一些常用的切换组件，如PageView、TabView等，
* 但是，这些组件并不能覆盖全部的需求场景，为此，Flutter SDK中提供了一个AnimatedSwitcher组件，它定义了一种通用的UI切换抽象
* */
class _ZQAnimatedSwitcherWidgetState extends State<ZQAnimatedSwitcherWidget> {
  /*
  * const AnimatedSwitcher({
  Key key,
  this.child,
  @required this.duration, // 新child显示动画时长
  this.reverseDuration,// 旧child隐藏的动画时长
  this.switchInCurve = Curves.linear, // 新child显示的动画曲线
  this.switchOutCurve = Curves.linear,// 旧child隐藏的动画曲线
  this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder, // 动画构建器
  this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder, //布局构建器
})
  * */
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
    return getRaiseButtonWidget();
  }

  int _count = 0;

  Widget getRaiseButtonWidget(){
    return Center(
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: Duration(microseconds: 200),
            /// 构建动画
            transitionBuilder: (Widget child, Animation<double> animation){
              //执行缩放动画
//              return ScaleTransition(child: child, scale: animation);
              var tween=Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
//              return ZQSlideTransition(
//                child: child,
//                position: tween.animate(animation),
//              );

              return ZQSlideTransitionX(
                child: child,
                position: animation,
                direction: AxisDirection.up,
              );
            },
            child: Text(
              '$_count',
              key: ValueKey<int>(_count),//显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          RaisedButton(
            child: Text("+1"),
            onPressed: (){
              setState(() { //更新build
                _count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ZQSlideTransition extends AnimatedWidget {
  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  ZQSlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })
      : assert(position != null),
        super(key: key, listenable: position) ;

  @override
  Widget build(BuildContext context) {
    Offset offset=position.value;
    //动画反向执行时，调整x偏移，实现“从左边滑出隐藏”
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

/// 待理解、？？？
class ZQSlideTransitionX extends AnimatedWidget {
  ZQSlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })
      : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }


  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}