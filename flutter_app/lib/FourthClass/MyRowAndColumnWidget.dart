
import 'package:flutter/material.dart';

class MyRowAndColumnWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyRowAndColumnWidgetState();
}

class MyRowAndColumnWidgetState extends State{
  /* Flutter中通过Row和Column来实现线性布局,都继承自Flex
  *  MainAxisAlignment：主轴方向上的对齐方式，会对child的位置起作用
     对于Row 主轴是水平方向，交叉轴是垂直方向，对于Column则相反
     * center：将children放置在主轴的中心；
     * end：将children放置在主轴的末尾；
     * spaceAround：将主轴方向上的空白区域均分，使得children之间的空白区域相等，但是首尾child的空白区域为1/2；
     * spaceBetween：将主轴方向上的空白区域均分，使得children之间的空白区域相等，首尾child都靠近首尾，没有间隙；
     * spaceEvenly：将主轴方向上的空白区域均分，使得children之间的空白区域相等，包括首尾child；
     * start：将children放置在主轴的起点；
     *
  *  CrossAxisAlignment：叉轴方向的对齐方式，与MainAxisAlignment略有不同。
     * baseline：在交叉轴方向，使得children的baseline对齐；
     * center：children在交叉轴上居中展示；
     * end：children在交叉轴上末尾展示；
     * start：children在交叉轴上起点处展示；
     * stretch：让children填满交叉轴方向；
     *
  *  mainAxisSize：表示Row在主轴(水平)方向占用的空间，默认是max，表示尽可能多的占用水平方向的空间，此时无论子widgets实际占用多少水平空间，Row的宽度始终等于水平方向的最大宽度；
     而min表示尽可能少的占用水平空间，当子组件没有占满水平剩余空间，则Row的实际宽度等于所有子组件占用的的水平空间；
     当未min时候，MainAxisAlignment的对齐失去意义
  *  textDirection: 这个属性估计是给外国人习惯使用，ltr:文本从左向右布局 rtl:文本从右向左布局
  *  verticalDirection: down：从top到bottom进行布局； up：从bottom到top进行布局。
  *
  *  注意：Row 的话会默认占满整个水平方向，Column的话会占满这个垂直方向。除非设置mainAxisSize.mix
  *       Row和Column都只会在主轴方向占用尽可能大的空间，而纵轴的长度则取决于他们最大子元素的长度。
  * */

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getColumnWordWidget();
  }

  Widget getRowWidget(){
    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      crossAxisAlignment: CrossAxisAlignment.start,
//      verticalDirection: VerticalDirection.up,
//      textDirection:TextDirection.rtl,
      children: <Widget>[
        //使用两个Expanded flex = 1 按比例分剩余的宽度
//        Expanded(flex: 1,child: Container(color: Colors.black38, height: 160)),
        Container(color: Colors.yellow, width: 60, height: 80,),
        Container(color: Colors.red, width: 100, height: 180,),
        Container(color: Colors.black, width: 60, height: 80,),
        Container(color: Colors.green, width: 60, height: 80,),
//        Expanded(flex: 1,child: Container(color: Colors.black38, height: 60)),
      ],
    );
  }


  Widget getColumnWidget() {
    return Column(
//      mainAxisAlignment: MainAxisAlignment.start,
//      crossAxisAlignment: CrossAxisAlignment.center,
//      verticalDirection: VerticalDirection.up,
      children: <Widget>[
//        Row(children: [
//          Container(color: Colors.yellow, width: 60, height: 80,),
//          Container(color: Colors.red, width: 100, height: 180,),
//          Container(color: Colors.black, width: 60, height: 80,),
//          Container(color: Colors.green, width: 60, height: 80,),
//        ],),
        Container(color: Colors.yellow, width: 60, height: 80,),
        Container(color: Colors.red, width: 100, height: 180,),
        Container(color: Colors.black, width: 60, height: 80,),
        Container(color: Colors.green, width: 60, height: 80,),
      ],
    );
  }

  /*
  *当Column 中存在子widget Row,那么宽度会被Row占满全部，
  */
  Widget getColumnWordWidget() {
    return Column(
      //测试Row对齐方式，排除Column默认居中对齐的干扰
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" hello world "),
            Text(" I am Jack "),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" hello world "),
            Text(" I am Jack "),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(" hello world "),
            Text(" I am Jack "),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Text(" hello world ", style: TextStyle(fontSize: 30.0),),
            Text(" I am Jack "),
          ],
        ),
      ],
    );
  }

  //因为Column只会在主轴垂直方向占满空间，所以水平方向，只会按最大显示
  Widget getCenterColumnWidget() {
    return Column(
      //这里垂直是指里面控件的水平方向排列对齐是居中对齐
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("hi"),
        Text("world"),
      ],
    );
  }

  //使用ConstrainedBox的设置minWidth设为double.infinity，可以使宽度占用尽可能多的空间。
  Widget getCenterBoxColumnWidgte() {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("hi"),
          Text("world"),
        ],
      ),
    );
  }

  //如果Row里面嵌套Row，或者Column里面再嵌套Column，
  //那么只有最外面的Row或Column会占用尽可能大的空间，里面Row或Column所占用的空间为实际大小，下面以Column为例说明
  //如果要让里面的Column占满外部Column，可以使用Expanded 组件
  Widget getMutileColumnWidget(){
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
          children: <Widget>[
//            Expanded(child:
                Container(
                  color: Colors.red,
                  child: Column(//无效，内层Colum高度为实际高度,除非嵌套Expanded弹性布局
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("hello world "),
                      Text("I am Jack "),
                    ],
                  ),
                ),
//            ),
          ],
        ),
      ),
    );
  }


}