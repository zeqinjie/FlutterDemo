import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Tool/ZQToolWidget.dart';

class ZQListViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ZQListViewWidgetState();

}

class ZQListViewWidgetState extends State<ZQListViewWidget> {

  static const loadingTag = "##loading##"; //表尾标记
  var words = <String>[loadingTag];

  /*
  *ListView({
    ...
    //可滚动widget公共参数
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    EdgeInsetsGeometry padding,
    //ListView各个构造函数的共同参数
    //itemExtent：该参数如果不为null，则会强制children的“长度”为itemExtent的值,这里的“长度”是指滚动方向上子组件的长度
    double itemExtent,
    //shrinkWrap：该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。默认情况下，
    * ListView的会在滚动方向尽可能多的占用空间。当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true
    bool shrinkWrap = false,
    //addAutomaticKeepAlives：该属性表示是否将列表项（子组件）包裹在AutomaticKeepAlive 组件中；
    * 典型地，在一个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，在该列表项滑出视口时它也不会被GC（垃圾回收），
    * 它会使用KeepAliveNotification来保存其状态。如果列表项自己维护其KeepAlive状态，那么此参数必须置为false
    bool addAutomaticKeepAlives = true,
    //addRepaintBoundaries：该属性表示是否将列表项（子组件）包裹在RepaintBoundary组件中
    * 当可滚动组件滚动时，将列表项包裹在RepaintBoundary中可以避免列表项重绘，
    * 但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，不添加RepaintBoundary反而会更高效。
    * 和addAutomaticKeepAlive一样，如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
    bool addRepaintBoundaries = true,
    double cacheExtent,
    //子widget列表
    List<Widget> children = const <Widget>[],
})
  *
  * */

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getInfiniteListView(context);
  }

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  //Private Method
  Widget getListViewWidget(){
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        const Text('I\'m dedicating every day to you'),
        const Text('Domestic life was never quite my style'),
        const Text('When you smile, you knock me out, I fall apart'),
        const Text('And I thought I was so smart'),
      ],
    );
  }

  /*
  * ListView.builder 构造函数
  * 适合列表项比较多（或者无限）的情况，因为只有当子组件真正显示的时候才会被创建，也就说通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的
  * ListView.builder({
      // ListView公共参数已省略
      ...
      @required IndexedWidgetBuilder itemBuilder,//它是列表项的构建器，类型为IndexedWidgetBuilder，返回值为一个widget。当列表滚动到具体的index位置时，会调用该构建器构建列表项。
      int itemCount,//列表项的数量，如果为null，则为无限列表
     ...
    })
  * */
  Widget getListViewBuilderWidget(){
    return ListView.builder(
        itemCount: 100,  //个数
        itemExtent: 50.0, //强制高度为50.0
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Icon(Icons.dashboard),
            trailing: Icon(Icons.save),
            title: Text("title $index"),
            subtitle: Text("subtitle $index"),
        ); //Text("$index")
      }
    );
  }

  /*ListView.separated 构造函数
  * ListView.separated可以在生成的列表项之间添加一个分割组件，它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器
  * */
  Widget getListViewSeparatedWidget(){
    //下划线widget预定义以供复用。
    Widget divider1=Divider(color: Colors.blue,);
    Widget divider2=Divider(color: Colors.green);
    return ListView.separated(
        itemCount: 100,  //个数
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Icon(Icons.dashboard),
            trailing: Icon(Icons.save),
            title: Text("title $index"),
            subtitle: Text("subtitle $index"),
          ); //Text("$index")
      },
      separatorBuilder:(BuildContext context, int index){
          return index%2==0?divider1:divider2;
      },
    );
  }

  // 无限加载
  Widget getInfiniteListView(BuildContext context){
    Widget divider1=Divider(color: Colors.blue,);
    //我们需要给ListView指定边界，我们通过SizedBox指定一个列表高度看看是否生效：
    return Column(
      children: [
        //添加头部
        ListTile(title:Text("商品列表")),
        //需要固定ListView 高度，否则报错，使用Expanded 尽可能的拉伸view
        Expanded(
          child: ListView.separated(
            itemBuilder: (context,index){
              return getItemBuilder(context, index);
            },
            separatorBuilder: (context,index){
              return divider1;
            },
            itemCount: words.length,
          ),
        )
      ],
    );
  }

  //获取Item项
  Widget getItemBuilder(BuildContext context, int index){
    //如果到了表尾
    if (words[index] == loadingTag) {
      //不足100条，继续获取数据
      if (words.length - 1 < 100) {
        //获取数据
        retrieveData();
        //加载时显示loading
        return ZQToolWidget.getLoadingWidget(0);
      } else {
        //已经加载了100条数据，不再获取数据。
        return ZQToolWidget.getLoadingWidget(1);
      }
    }
    return ListTile(
      leading: Icon(Icons.dashboard),
      trailing: Icon(Icons.save),
      title: Text(words[index]),
    );
  }

  //加载更多数据
  void retrieveData(){
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        //重新构建列表
        words.insertAll(words.length - 1,
            //每次生成20个单词
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList()
        );
      });
    });
  }

}