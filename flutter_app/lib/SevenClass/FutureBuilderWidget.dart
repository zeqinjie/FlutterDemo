import 'package:flutter/material.dart';

class FutureBuilderWidget extends StatefulWidget {
  FutureBuilderWidget({Key key}) : super(key: key);

  @override
  _FutureBuilderWidgetState createState() {
    return _FutureBuilderWidgetState();
  }
}

class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {

  /*
  * FutureBuilder({
      this.future,
      this.initialData,
      @required this.builder,
    })
  * future：FutureBuilder依赖的Future，通常是一个异步耗时任务。
  * initialData：初始数据，用户设置默认数据。
  * builder：Widget构建器；该构建器会在Future执行的不同阶段被多次调用，构建器签名如下：
    Function (BuildContext context, AsyncSnapshot snapshot)
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
    return getStreamBuilder();
  }

  //2秒后返回一个字符串
  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  Widget getFutureDataWidget(){
    return Center(
      child: FutureBuilder<String>(
        future: mockNetworkData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Text("Error: ${snapshot.error}");
            } else {
              // 请求成功，显示数据
              return Text("Contents: ${snapshot.data}");
            }
          } else {
            // 请求未结束，显示loading
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  /*ConnectionState的状态码
  * enum ConnectionState {
     none,/// 当前没有异步任务，比如[FutureBuilder]的[future]为null时
     waiting,/// 异步任务处于等待状态
     active,/// Stream处于激活状态（流上已经有数据传递了），对于FutureBuilder没有该状态。
     done,/// 异步任务已经终止.
    }
  * */

  //创建一个计时器的示例：每隔1秒，计数加1
  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  //凡是UI会依赖多个异步数据而发生变化的场景都可以使用StreamBuilder。
  Widget getStreamBuilder(){
    return StreamBuilder<int>(
      stream: counter(), //
      //initialData: ,// a Stream<int> or null
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('没有Stream');
          case ConnectionState.waiting:
            return Text('等待数据...');
          case ConnectionState.active:
            return Text('active: ${snapshot.data}');
          case ConnectionState.done:
            return Text('Stream已关闭');
        }
        return null; // unreachable
      },
    );
  }

}