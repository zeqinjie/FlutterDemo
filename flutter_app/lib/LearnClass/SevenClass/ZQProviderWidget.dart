import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZQProviderWidget extends StatefulWidget {
  ZQProviderWidget({Key key}) : super(key: key);

  @override
  _ZQProviderWidgetState createState() {
    return _ZQProviderWidgetState();
  }
}

class _ZQProviderWidgetState extends State<ZQProviderWidget> {
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
    return getWidget();
  }

  Widget getWidget(){
    return ChangeNotifierProvider.value(
        value: _CounterModel(),//需要共享的数据资源
        child: MaterialApp(
        home: _FirstPage(),
      )
    );
  }
}

//第一个页面，负责读数据
class _FirstPage extends StatelessWidget {
  _FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _counterModel = Provider.of<_CounterModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("第一页"),
      ),
      body: Center(child: Text('Counter: ${_counterModel.counter}'),),
      floatingActionButton: FloatingActionButton(
        child: Text("push"),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => _SecondPage()));
        },
      ),
    );
  }
}

//第二个页面，负责读写数据
class _SecondPage extends StatelessWidget {
  _SecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return getConsumerWidget(context);
  }

  Widget getWidget(BuildContext context){
    // 滥用 Provider.of 方法也有副作用，那就是当数据更新时，页面中其他的子 Widget 也会跟着一起刷新
    //使用 Consumer 来改造 SecondPage改造 避免滥刷新
    final _counterModel = Provider.of<_CounterModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("第二页"),
        ),
        body: Center(child: Text('Counter: ${_counterModel.counter}'),), //展示资源中的数据
        floatingActionButton:FloatingActionButton(
          onPressed: _counterModel.increment,
          child: _TestIcon(),
        )
    );
  }

//  final Widget Function(BuildContext context, T value, Widget child) builder;
  /*
  * 使用 Consumer 来改造 SecondPage改造 避免滥刷新
  * Provider 可以精确地控制 UI 刷新粒度，而这一切是基于 Consumer 实现的。Consumer 使用了 Builder 模式创建 UI，收到更新通知就会通过 builder 重新构建 Widget
  * */
  Widget getConsumerWidget(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("第二页"),
      ),
      body: Consumer<_CounterModel>(builder: (context,_CounterModel _counterModel,Widget child){
        return Center(child: Text('Counter: ${_counterModel.counter}'),);
      }),
      floatingActionButton: Consumer(
        builder: (context, _CounterModel _counterModel,Widget child) => FloatingActionButton(
          onPressed: (){
            _counterModel.increment();
          },
          child: child,//复用_TextIcon
        ),
        child: _TestIcon(), //设置不需要更新的widget
      ),
    );
  }


}


//用于打印build方法执行情况的自定义控件
class _TestIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("TestIcon build");
    return Icon(Icons.add);//返回Icon实例
  }
}

//定义需要共享的数据模型，通过混入ChangeNotifier管理听众
class _CounterModel with ChangeNotifier{
  int _count = 0;
  //读方法
  int get counter => _count;
  //写方法
  void increment(){
    _count++;
    notifyListeners();
  }
}