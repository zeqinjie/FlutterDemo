import 'package:flutter/material.dart';

class ZQStaggerAnimationWidget extends StatefulWidget {
  ZQStaggerAnimationWidget({Key key}) : super(key: key);

  @override
  _ZQStaggerAnimationWidgetState createState() {
    return _ZQStaggerAnimationWidgetState();
  }
}
//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ZQStaggerAnimationWidgetState extends State<ZQStaggerAnimationWidget> with TickerProviderStateMixin {
  /*
  * 交织动画
  * 要创建交织动画，需要使用多个动画对象（Animation）。
  * 一个AnimationController控制所有的动画对象。
  * 给每一个动画对象指定时间间隔（Interval）
  * */

  AnimationController _controller;


  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getWidget();
  }

  void initAnimation(){
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this
    );
    _controller.addStatusListener((status) {

    });
  }

  /// 执行动画
  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  Widget getWidget(){
    return GestureDetector(
      behavior: HitTestBehavior.opaque, //点击事件默认是不会命中透明组件的
      onTap: (){
        _playAnimation();
      },
      child: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(color: Colors.orange,border: Border.all(color: Colors.green)),
          child: ZQStaggerAnimation(
              controller: _controller
          ),
        ),
      ),
    );
  }
}

/*
* 我们将执行动画的Widget分离出来：
* 开始时高度从0增长到300像素，同时颜色由绿色渐变为红色；这个过程占据整个动画时间的60%。
* 高度增长到300后，开始沿X轴向右平移100像素；这个过程占用整个动画时间的40%。
* */
class ZQStaggerAnimation extends StatelessWidget {
  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

//  static const zqcurve = Interval(0.0,0.6,curve: Curves.ease);

  /// 获取时间间隔
  Curve getCurveInterval(double begin,double end){
    return  Interval(begin,end,curve: Curves.ease);
  }

  /// 获取Animation对象实例
  CurvedAnimation getCurvedAnimation(double begin,double end){
    return CurvedAnimation(
      parent: controller,
      curve: getCurveInterval(begin,end),
    );
  }

  //构造函数，必须初始化参数和swift一样
  ZQStaggerAnimation({Key key, this.controller}) : super(key: key){
    height = Tween<double>(
      begin: .0,
      end: 300,
    ).animate(getCurvedAnimation(0.0,0.6));//间隔，前60%的动画时间
     color = ColorTween(
       begin: Colors.green,
       end: Colors.red,
     ).animate(getCurvedAnimation(0.0,0.6));//间隔，前60%的动画时间
    padding = Tween<EdgeInsets>(
      begin:EdgeInsets.only(left: .0),
      end:EdgeInsets.only(left: 100.0),
    ).animate(getCurvedAnimation(0.6, 1.0)); //间隔，后40%的动画时间

  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding:padding.value ,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
