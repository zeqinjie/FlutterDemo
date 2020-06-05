import 'package:flutter/material.dart';

class ZQAnimationWidget extends StatefulWidget {
  ZQAnimationWidget({Key key}) : super(key: key);

  @override
  _ZQAnimationWidgetState createState() {
    return _ZQAnimationWidgetState();
  }
}


//enum MyAnimationType{
//
//}

class _ZQAnimationWidgetState extends State<ZQAnimationWidget> with TickerProviderStateMixin {

  /*
  *  Flutter 动画简介
  *  Flutter中动画抽象 ，主要涉及Animation、Curve、Controller、Tween这四个角色
  *  1.Animation 是一个抽象类，它本身和UI渲染没有任何关系，而它主要的功能是保存动画的插值和状态
  *     - Animation来监听动画每一帧以及执行状态的变化，Animation有如下两个方法
  *       - addListener()  它可以用于给Animation添加帧监听器，在每一帧都会被调用。帧监听器中最常见的行为是改变状态后调用setState()来触发UI重建
  *       - addStatusListener() Animation添加“动画状态改变”监听器；动画开始、结束、正向或反向（见AnimationStatus定义）时会调用状态改变的监听器
  *  2.Curve , Flutter中通过Curve（曲线）来描述动画过程，我们把匀速动画称为线性的(Curves.linear)，而非匀速动画称为非线性的
  *  3.AnimationController 用于控制动画，它包含动画的启动forward()、停止stop() 、反向播放 reverse()等方法
  *  4.Ticker 创建一个AnimationController时，需要传递一个vsync参数，它接收一个TickerProvider类型的对象，它的主要职责是创建Ticker
  *  5.Tween  AnimationController对象值的范围是[0.0，1.0]。如果我们需要构建UI的动画值在不同的范围或不同的数据类型，则可以使用Tween来添加映射以生成不同的范围或数据类型的值
  *
  * */


  Animation<double> animation;
  AnimationController controller;


  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getMyGrowTransitionWidget();
  }

  //初始化动画
  void initAnimation() {
    //需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // 级联符号(..) 允许您对同一对象执行一系列操作,通常会省去创建临时变量的步骤，并允许您编写更多的级联代码。
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(()=>{});
      });

    //动画状态监听
    /*
    * dismissed	动画在起始点停止
    * forward	动画正在正向执行
    * reverse	动画正在反向执行
    * completed	动画在终点停止
    * */
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画
    controller.forward();

  }

  Widget getAnimationWidget(){
    return Center(
      child: Image.asset("assets/icons/taofang.png",
          width: animation.value,
          height: animation.value
      ),
    );
  }

  /// 方式一 使用AnimatedWidget简化
  Widget getMyAnimatedImageWidget(){
    return ZQAnimatedImage(animation: animation,);
  }

  //方式二 使用AnimatedBuilder重构
  /*
  * 不用显式的去添加帧监听器，然后再调用setState() 了，这个好处和AnimatedWidget是一样的。
  * 动画构建的范围缩小了，如果没有builder，setState()将会在父组件上下文中调用，这将会导致父组件的build方法重新调用；而有了builder之后，只会导致动画widget自身的build重新调用，避免不必要的rebuild。
  * 通过AnimatedBuilder可以封装常见的过渡效果来复用动画。下面我们通过封装一个GrowTransition来说明，它可以对子widget实现放大动画
  *
  * */
  Widget getMyAnimatedBuildWidget(){
    return AnimatedBuilder(animation: animation,
        child: Image.asset("assets/icons/taofang.png",),
        builder: (BuildContext context, Widget child){
            return  Center(
              child: Container(
                height: animation.value,
                width: animation.value,
                /// 传入为Image 避免重新new
                child: child,
              ),
            );
    });
  }

  // 方式二 封装分离组件，复用动画
  Widget getMyGrowTransitionWidget(){
    return ZQGrowTransition(
      child: Image.asset("assets/icons/taofang.png"),
      animation: animation,
    );
  }
}

//方式一 使用AnimatedWidget简化
class ZQAnimatedImage extends AnimatedWidget {
  ZQAnimatedImage({Key key, Animation<double> animation}): super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset("assets/icons/taofang.png",
          width: animation.value,
          height: animation.value
      ),
    );
  }
}

// 方式二 封装分离组件，复用动画
class ZQGrowTransition extends StatelessWidget {
  ZQGrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return  Center(
      child:  AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return  Container(
                height: animation.value,
                width: animation.value,
                child: child
            );
          },
          child: child
      ),
    );
  }
}



