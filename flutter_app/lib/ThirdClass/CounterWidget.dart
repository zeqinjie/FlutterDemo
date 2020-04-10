import 'dart:ffi';
import 'package:flutter/material.dart';
//第三章 Widget 简介
class CounterWidget extends StatefulWidget{

  final int initValue;

  const CounterWidget({
    Key key,
    this.initValue:0,
  });

  @override
  State<StatefulWidget> createState() {
    return _CounterWidgetState();
  }
}

class _CounterWidgetState extends State<CounterWidget>{

  int _counter;

  //定义全局key
  static GlobalKey<ScaffoldState> _globalKey= GlobalKey();

  // State 的生命周期

  @override
  //当Widget第一次插入到Widget树时会被调用，对于每一个State对象，Flutter framework只会调用一次该回调
  void initState() {
    super.initState();
    //初始化状态
    _counter=widget.initValue;
    print("initState");
  }

  @override
  //当State对象的依赖发生变化时会被调用
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  //它主要是用于构建Widget子树的
  //调用initState()后，didUpdateWidget()之后，setState()之后，didChangeDependencies()之后 都会调用
  //在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后调用
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(key: _globalKey,body: Center(child: FlatButton(textColor: Colors.yellow,child: Text('$_counter'),onPressed: (){
//      setState(() {
//        ++_counter;
//      });
    //查找父级最近的Scaffold对应的ScaffoldState对象 已过期方法
//      ScaffoldState _state = context.ancestorStateOfType(TypeMatcher<ScaffoldState>());

      // 直接通过of静态方法来获取ScaffoldState
      //默认的约定：如果StatefulWidget的状态是希望暴露出的，应当在StatefulWidget中提供一个of静态方法来获取其State对象
//      ScaffoldState _state = Scaffold.of(context);

      //通过GlobalKey来获取State对象
      ScaffoldState _state = _globalKey.currentState;

      _state.showSnackBar(
        SnackBar(
          content: Text("我是SnackBar"),
        ),
      );
    },),),);
  }

  @override
  //在widget重新构建时,通过Widget.canUpdate检测是否需要更新（key和runtimeType同时相等时会调用），否则就重新创建新的Element
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  //当State对象从树中被移除时，会调用此回调
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  //当State对象从树中被永久移除时调用,释放资源
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  //此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

}