import 'package:flutter/material.dart';

class ZQTransitionAnimationWidget extends StatefulWidget {
  ZQTransitionAnimationWidget({Key key}) : super(key: key);

  @override
  _ZQTransitionAnimationWidgetState createState() {
    return _ZQTransitionAnimationWidgetState();
  }
}

class _ZQTransitionAnimationWidgetState extends State<ZQTransitionAnimationWidget> {

  /*
  * 动画过渡组件“，而动画过渡组件最明显的一个特征就是它会在内部自管理AnimationController
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
//    return getDecoratedBoxBWidget();
    return ZQTransitionAnimatedWidgets();
  }


  Color _decorationColor = Colors.blue;
  var duration = Duration(seconds: 1);

  /*
  * 过渡动画
  */
  Widget getDecoratedBoxWidget(){
    return ZQAnimatedDecoratedBox(
        decoration: BoxDecoration(color: _decorationColor),
        duration: duration,
        child: FlatButton.icon(
            onPressed: (){
              setState(() {
                _decorationColor = Colors.red;
              });
            },
            icon: Icon(Icons.done),
            label: Text("done",style: TextStyle(color: Colors.white),)),
    );
  }


  /*
  * 1.使用动画过渡组件时如果需要执行反向动画的场景，应尽量使用状态互换的方法，
  * 而不应该通过获取ImplicitlyAnimatedWidgetState中controller的方式。
  * 2.如果我们自定义的动画过渡组件用不到reverseDuration ，那么最好就不要暴露此参数，
  * 比如我们上面自定义的AnimatedDecoratedBox定义中就可以去除reverseDuration 可选参数
  * */
  Widget getDecoratedBoxBWidget(){
    return ZQAnimatedDecoratedBoxB(
      duration: Duration( milliseconds: 400),
      decoration: BoxDecoration(color: _decorationColor),
      child: Builder(builder: (context) {
        return FlatButton(
          onPressed: () {
            if (_decorationColor == Colors.red) {
              ImplicitlyAnimatedWidgetState _state =
              context.findAncestorStateOfType<ImplicitlyAnimatedWidgetState>();
              // 通过controller来启动反向动画
              _state.controller.reverse().then((e) {
                // 经验证必须调用setState来触发rebuild，否则状态同步会有问题
                setState(() {
                  _decorationColor = Colors.blue;
                });
              });
            } else {
              setState(() {
                _decorationColor = Colors.red;
              });
            }
          },
          child: Text(
            "AnimatedDecoratedBox toggle",
            style: TextStyle(color: Colors.white),
          ),
        );
      }),
    );
  }
}

class ZQAnimatedDecoratedBox extends StatefulWidget {
  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  ZQAnimatedDecoratedBox({
    Key key,
    @required this.decoration,
    this.child,
    @required this.duration,
    this.curve,
    this.reverseDuration}) : super(key: key);

  @override
  _ZQAnimatedDecoratedBoxState createState() {
    return _ZQAnimatedDecoratedBoxState();
  }
}

/*
* 稍加思考后，我们就可以发现，AnimationController的管理以及Tween更新部分的代码都是可以抽象出来的，
* 如果我们这些通用逻辑封装成基类，那么要实现动画过渡组件只需要继承这些基类，然后定制自身不同的代码
* */
class _ZQAnimatedDecoratedBoxState extends State<ZQAnimatedDecoratedBox> with SingleTickerProviderStateMixin {
  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  DecorationTween _tween;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child){
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(ZQAnimatedDecoratedBox oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve)
      _updateCurve();
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    if(widget.decoration!= (_tween.end ?? _tween.begin)){
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  void initAnimation(){
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    if (widget.curve != null)
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    else
      _animation = _controller;
  }
}

/*改造
* 为了方便开发者来实现动画过渡组件的封装，Flutter提供了一个ImplicitlyAnimatedWidget抽象类，
* 它继承自StatefulWidget，同时提供了一个对应的ImplicitlyAnimatedWidgetState类
* 只需要分别继承ImplicitlyAnimatedWidget和ImplicitlyAnimatedWidgetState类即可
* */

class ZQAnimatedDecoratedBoxB extends ImplicitlyAnimatedWidget {

  /*
  * 其中curve、duration、onEnd三个属性在ImplicitlyAnimatedWidget中已定义
  * */
  ZQAnimatedDecoratedBoxB({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear, //动画曲线
    @required Duration duration, // 正向动画执行时长
//    Duration reverseDuration,// 反向动画执行时长
  }) : super(
    key: key,
    curve: curve,
    duration: duration,
  );

  final BoxDecoration decoration;
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    // TODO: implement createState
    return _ZQAnimatedDecoratedBoxBState();
  }

}

class _ZQAnimatedDecoratedBoxBState
    extends AnimatedWidgetBaseState<ZQAnimatedDecoratedBoxB> {
  DecorationTween _decoration; //定义一个Tween
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DecoratedBox(
      decoration: _decoration.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    // TODO: implement forEachTween
    // 在需要更新Tween时，基类会调用此方法
    _decoration = visitor(_decoration, widget.decoration, (value) => DecorationTween(begin: value));
  }
}

/*
* 组件名	功能
* 1.AnimatedPadding	在padding发生变化时会执行过渡动画到新状态
* 2.AnimatedPositioned	配合Stack一起使用，当定位状态发生变化时会执行过渡动画到新的状态。
* 3.AnimatedOpacity	在透明度opacity发生变化时执行过渡动画到新状态
* 4.AnimatedAlign	当alignment发生变化时会执行过渡动画到新的状态。
* 5.AnimatedContainer	当Container属性发生变化时会执行过渡动画到新的状态。
* 6.AnimatedDefaultTextStyle	当字体样式发生变化时，子组件中继承了该样式的文本组件会动态过渡到新样式。
* */

class ZQTransitionAnimatedWidgets extends StatefulWidget {
  @override
  _ZQTransitionAnimatedWidgetsState createState() => _ZQTransitionAnimatedWidgetsState();
}

class _ZQTransitionAnimatedWidgetsState extends State<ZQTransitionAnimatedWidgets> {
  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(color: Colors.black);
  Color _decorationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 5);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                _padding = 20;
              });
            },
            child: AnimatedPadding(
              duration: duration,
              padding: EdgeInsets.all(_padding),
              child: Text("AnimatedPadding"),
            ),
          ),
          SizedBox(
            height: 50,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: duration,
                  left: _left,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _left = 100;
                      });
                    },
                    child: Text("AnimatedPositioned"),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: AnimatedAlign(
              duration: duration,
              alignment: _align,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _align = Alignment.center;
                  });
                },
                child: Text("AnimatedAlign"),
              ),
            ),
          ),
          AnimatedContainer(
            duration: duration,
            height: _height,
            color: _color,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _height = 150;
                  _color = Colors.blue;
                });
              },
              child: Text(
                "AnimatedContainer",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          AnimatedDefaultTextStyle(
            child: GestureDetector(
              child: Text("hello world"),
              onTap: () {
                setState(() {
                  _style = TextStyle(
                    color: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.blue,
                  );
                });
              },
            ),
            style: _style,
            duration: duration,
          ),
          ZQAnimatedDecoratedBox(
            duration: duration,
            decoration: BoxDecoration(color: _decorationColor),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _decorationColor = Colors.red;
                });
              },
              child: Text(
                "AnimatedDecoratedBox",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ].map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: e,
          );
        }).toList(),
      ),
    );
  }
}


