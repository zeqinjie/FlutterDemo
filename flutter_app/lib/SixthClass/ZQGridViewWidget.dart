import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/Tool/MyToolWidget.dart';

class ZQGridViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ZQGridViewWidgetState();

}

//GridView可以构建一个二维网格列表
/*
* GridView({
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry padding,
    @required SliverGridDelegate gridDelegate, //控制子widget layout的委托
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    double cacheExtent,
    List<Widget> children = const <Widget>[],
  })

* */
class ZQGridViewWidgetState extends State<ZQGridViewWidget> {

  List<IconData> iconArr = [Icons.donut_large];
  List<IconData> icons = [Icons.ac_unit,
    Icons.airport_shuttle,
    Icons.all_inclusive,
    Icons.beach_access,
    Icons.cake,
    Icons.done,
    Icons.satellite,
    Icons.cached,
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_alarms,
    Icons.done,
    Icons.done,
    Icons.free_breakfast];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getHeaderGridView();
  }

  @override
  void initState() {
    super.initState();
    // 初始化数据
    retrieveData();
  }

  void retrieveData(){
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        iconArr.insertAll(iconArr.length - 1, icons);
      });
    });
  }
/*
*  *
  *
  * Flutter中提供了两个SliverGridDelegate的子类
  *
  * //该子类实现了一个横轴为固定数量子元素的layout算法 ,固定了最大宽度为父Widget的宽度，然后等分，
  *   不过需要设置数量横着crossAxisCount显示个数，然后平均值
  * SliverGridDelegateWithFixedCrossAxisCount
  *
  * //该子类实现了一个横轴子元素为固定最大长度的layout算法,固定了最大宽度为父Widget的宽度，然后等分，平均值会根据屏幕宽取舍调整
  * SliverGridDelegateWithMaxCrossAxisExtent
  *
  SliverGridDelegateWithFixedCrossAxisCount({
    @required double crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
  })
  * crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商。
  * mainAxisSpacing：主轴方向的间距。
  * crossAxisSpacing：横轴方向子元素的间距。
  * childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。
*
* */
  Widget getGirdViewFixedCrossAxisWidgte(){
    return GridView(
        scrollDirection:Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //横轴三个子widget
            childAspectRatio: 1.0 //宽高比为1时，子widget
        ),
        children:icons.map((e) {
          return Container(child: Icon(e),color: MyToolWidget.getRandomColor(),);
        }).toList(),
    );
  }

  /*GridView.count 构造函数
  * 本质也是使用SliverGridDelegateWithFixedCrossAxisCount
  */
  Widget getGirdViewCountFixedCrossAxisWidgte(){
    return GridView.count(
      scrollDirection:Axis.vertical, //默认垂直方向
      crossAxisCount: 3,
      childAspectRatio: 1.0/2.0, //宽：高 如果scrollDirection 为水平方向则是高：宽
        children:icons.map((e) {
          return Container(child: Icon(e),color: MyToolWidget.getRandomColor(),);
        }).toList(),
    );
  }

  /*
  * SliverGridDelegateWithMaxCrossAxisExtent
  *
  * SliverGridDelegateWithMaxCrossAxisExtent({
      double maxCrossAxisExtent, //为子元素在横轴上的最大长度，之所以是“最大”长度，是因为横轴方向每个子元素的长度仍然是等分的
      double mainAxisSpacing = 0.0,
      double crossAxisSpacing = 0.0,
      double childAspectRatio = 1.0,
    })
  *
  *  */

  Widget getGridViewMaxCrossAxisWidget(){
    return GridView(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100.0,
          crossAxisSpacing:10,
          childAspectRatio: 2.0 //宽高比为2
      ),
      children: icons.map((e) {
        return Container(child: Icon(e),color: MyToolWidget.getRandomColor(),);
      }).toList(),
    );
  }

  /*上面我们介绍的GridView都需要一个widget数组作为其子元素，这些方式都会提前将所有子widget都构建好，
    所以只适用于子widget数量比较少时，
    当子widget比较多时，我们可以通过GridView.builder来动态创建子widget。GridView.builder 必须指定的参数有两个：
  */
  Widget getGridViewBuilderWidget(){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            childAspectRatio: 1.0 //显示区域宽高相等
        ),
        itemCount: iconArr.length,
        itemBuilder: (context,index){
          //如果显示到最后一个
          if (iconArr[index] == Icons.donut_large) {
            //总数小于100时继续获取数据
            if (iconArr.length < 100) {
              retrieveData();
              return MyToolWidget.getLoadingWidget(0);
            }else{
              //已经加载了100条数据，不再获取数据。
              return MyToolWidget.getLoadingWidget(1);
            }
          }
          return Container(child: Icon(iconArr[index]),color: MyToolWidget.getRandomColor());
        },
    );
  }

  //添加header 对于滚动的GridView 需要添加Expanded 拉伸扩展，否则报错
  Widget getHeaderGridView(){
    return Column(
      children: [
        //添加头部
        ListTile(title:Text("商品列表")),
        //需要固定ListView 高度，否则报错，使用Expanded 尽可能的拉伸view
        Expanded(
          child: getGridViewBuilderWidget(),
        )
      ],
    );
  }




}

