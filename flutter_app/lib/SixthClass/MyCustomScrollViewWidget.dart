import 'package:flutter/material.dart';

class MyCustomScrollWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCustomScrollWidgetState();
}

class MyCustomScrollWidgetState extends State<MyCustomScrollWidget>{
  /*
  * CustomScrollView的功能就相当于“胶水”。主要是组合多个scrollview 达到 滑动效果是统一
  * 为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等
  * */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getCustomScrollView();
  }

  /*
  * 头部SliverAppBar：SliverAppBar对应AppBar，两者不同之处在于SliverAppBar可以集成到CustomScrollView。SliverAppBar可以结合FlexibleSpaceBar实现Material Design中头部伸缩的模型，具体效果，读者可以运行该示例查看。
    中间的SliverGrid：它用SliverPadding包裹以给SliverGrid添加补白。SliverGrid是一个两列，宽高比为4的网格，它有20个子组件。
    底部SliverFixedExtentList：它是一个所有子元素高度都为50像素的列表
  * */
  Widget getCustomScrollView(){
    return CustomScrollView(
      slivers: [
        getSliverAppBar(),
        getSliverPadding(),
        getSliverFixedExtentList(),
      ],
    );
  }

  Widget getSliverAppBar(){
    //AppBar，包含一个导航栏
    return SliverAppBar(
        pinned: true,
//        backgroundColor: Colors.yellow,
        expandedHeight: 250.0,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('zhengzeqin'),
          background: Image.asset(
            "assets/icons/taofang.png", fit: BoxFit.fill,),
        ),
    );
  }

  //Grid
  Widget getSliverPadding() {
    return SliverPadding(
      padding: EdgeInsets.all(8.0),
      sliver: SliverGrid( //Grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //Grid按两列显示
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            //创建子widget
            return Container(
              alignment: Alignment.center,
              color: Colors.cyan[100 * (index % 9)],
              child: Text('grid item $index'),
            );
          },
          childCount: 20,
        ),
      ),
    );
  }

  Widget getSliverFixedExtentList(){
    return SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            //创建列表项
            return  Container(
              alignment: Alignment.center,
              color: Colors.lightBlue[100 * (index % 9)],
              child: Text('list item $index'),
            );
          },
          childCount: 50 //50个列表项
      ),
    );
  }

}