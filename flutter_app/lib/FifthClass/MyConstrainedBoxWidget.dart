import 'package:flutter/material.dart';

class MyConstrainedBoxWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyConstrainedBoxWidgetState();
}

class MyConstrainedBoxWidgetState extends State {
  Widget redBox=DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  /* 尺寸限制类容器,
  * ConstrainedBox 用于对子组件添加额外的约
  * SizedBox 用于给子元素指定固定的宽高
  * UnconstrainedBox 不会对子组件产生任何限制，它允许其子组件按照其本身大小绘制
  * AspectRatio 它可以指定子组件的长宽比
  * LimitedBox 用于指定最大宽高
  * FractionallySizedBox 可以根据父容器宽高的百分比来设置子组件宽高
  * OverflowBox  对其子项施加不同约束的Widget，它可能允许子项溢出父级
  * FittedBox：按自己的大小调整其子Widget的大小和位置,缩放（Scale）和位置调整（Position）
  *
  * 补充:
  * ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的
  * */

  Widget build(BuildContext context) {
    // TODO: implement build
    return getFittedBox();
  }

  /*
  * 用于对子组件添加额外的约
  * 如果你想让子组件的最小高度是80像素，你可以使用const BoxConstraints(minHeight: 80.0)作为子组件的约束
  * 如使用这些构造函数 BoxConstraints.tight(Size size),BoxConstraints.expand()
  * */
  Widget getConstrainedBoxWidget(){
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,//宽度尽可能大
        minHeight: 50,//最小高度为50像素
      ),
      child: Container(
        height: 5, //虽然将Container的高度设置为5像素，但是最终却是50像素，这正是ConstrainedBox的最小高度限制生效了
        child: redBox,),
    );
  }

  /*
  * 多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的 所以值未width = 375 height = 100
  * */
  Widget getMutipleConstrainedBox(){
    return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 90.0, minHeight: 100.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 375.0, minHeight: 60.0),
          child: redBox,
        )
    );
  }

  /*
  * UnconstrainedBox不会对子组件产生任何限制，它允许其子组件按照其本身大小绘制
  * 注意： UnconstrainedBox对父组件限制的“去除”并非是真正的去除：例子中虽然红色区域大小是90×20，
  *       但上方仍然有80的空白空间。
  *       也就是说父限制的minHeight(100.0)仍然是生效的，只不过它不影响最终子元素redBox的大小，
  *       但仍然还是占有相应的空间，可以认为此时的父ConstrainedBox是作用于子UnconstrainedBox上，
  *       而redBox只受子ConstrainedBox限制。有办法彻底去除父ConstrainedBox的限制吗？答案是否定的！
  *
  * 所以如已经使用SizedBox或ConstrainedBox给子元素指定了宽高，但是仍然没有效果时，几乎可以断定：已经有父元素已经设置了限制！
  * 此时可以使用UnconstrainedBox去除父元素的影响
  * */
  Widget getUnconstrainedBox(){
    return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),  //父
        child: UnconstrainedBox( //“去除”父级限制,不过影响子widget位置
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),//子
            child: redBox,
          ),
        )
    );
  }

  /*
  * SizedBox用于给子元素指定固定的宽高
  * */
  Widget getSizedBoxWidget(){
    return SizedBox(
        width: 100,
        height: 100,
        child: Container(//Container 是取决父Widget的大小
          height: 10,
          child: redBox,
        )
    );
  }

  /*
  * aspectRatio：设置宽高比
  * */
  Widget getAspectRatioWidget(){
    return Container(
      height: 90,
      color: Colors.yellow,
      child:  AspectRatio(
          aspectRatio:3/1, //根据父元素长度设置父宽为30，来设置子为90：30  宽：高为 3：1
          child: Container(
            color: Colors.red,
            width: 100,
            height: 100,),
      ),
    );
  }

  /* ？？
  * LimitedBox  对最大宽高进行限制（前提是LimitedBox不受约束）
  * maxHeight 最大高度
  *
  * */
  Widget getLimitedBoxWidget(){
    return Row(
      children: <Widget>[
        Container(
          color: Colors.red,
          width: 100.0,
        ),
        LimitedBox(
          maxWidth: 80.0,
          maxHeight: 80.0, //无效
          child: Container(
            color: Colors.blue,
            width: 250.0,
          ),
        ),
      ],
    );

    //无效?
//    return Container(
//      width: 100.0,
//      height: 80.0,
//      color: Colors.blue,
//      child:LimitedBox(
//        maxWidth: 80,
//        child: Container(
//          color: Colors.red,
//        ),
//      ),
//    );
  }

  /* 百分比布局
  *  根据父容器宽高的百分比来设置子组件宽高
  *  widthFactor 宽系数
  *  heightFactor
  * */
  Widget getFractionallySizedBoxWidget(){
    return Container(
      width: 100.0,
      height: 100.0,
      color: Colors.blue,
      child: FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 1.5,
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }

  /*
  *  对其子项施加不同约束的Widget，它可能允许子项溢出父级
  *
  * */
  Widget getOverflowBoxWidget(){
    return Container(
      color: Colors.blue,
      width: 200,
      height: 200, //注意：父容器的宽高是200 减去pading后是180
      padding: EdgeInsets.all(20.0),
      child: OverflowBox(
        alignment: Alignment.topLeft,
        maxWidth: 200,
        maxHeight: 400,//注意 不能小于父容器的宽高度180
        child: Container( //允许超过父widget
          color: Colors.deepOrange,
          width: 200,
          height:600,
        ),
      ),
    );
  }

  /*
  *  fit：缩放的方式，默认的属性是BoxFit.Contain，child在FittedBox范围内，尽可能大，但是不会超出其尺寸，
  *      这里需要注意一点，contain是在保持这child宽高比的大前提下，尽可能的填满，一般情况下，宽度或高度达到最大值时，就会停止缩放。
  *  BoxFit的枚举值有如下
  *  none，没有任何填充模式
  *  contain 尽可能大，内容不会超过容器范围
  *  fill：不按宽高比例填充，内容不会超过容器范围
  *  contain：按照宽高比等比模式填充，内容不会超过容器范围
  *  cover：按照原始尺寸填充整个容器模式。内容可能回超过容器范围
  *  scaleDown：会根据情况缩小范围
  *
  */
  Widget getFittedBox() {
    return Container(
      width: 250,
      height: 250,
      color: Colors.blue,
      child: FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.topLeft,
        child: Container(
          color: Colors.deepOrange,
          child: Text('缩放布局'),
        ),
      ),
    );
  }
}