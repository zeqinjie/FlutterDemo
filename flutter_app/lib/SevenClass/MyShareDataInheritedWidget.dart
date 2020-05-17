import 'package:flutter/material.dart';

class MyShareDataInheritedWidget extends InheritedWidget {
  /*
  * InheritedWidget它能有效地将数据在当前Widget树中向它的子widget树传递。
    它的子Widget树可以通过 BuildContext.inheritedFromWidgetOfExactType()方法获得最近的指定类型的Inherited widget，进而获取它的共享数据
  * */

  final int data; //需要在子树中共享的数据，保存点击次数

//  ShareDataWidget({
//    @required this.data,Widget child,Key key
//  }):super(key: key, child: child);

  /**
   * 获取最近的给定类型的Widget，该widget必须是InheritedWidget的子类，
   * 并向该widget注册传入的context，当该widget改变时，
   * 这个context会重新构建以便从该widget获得新的值。
   * 这就是child向InheritedWidget注册的方法。
   */
  MyShareDataInheritedWidget({
    @required this.data,Widget child
  }):super(child: child);


  //定义一个便捷方法，方便子树中的widget获取共享数据
  static MyShareDataInheritedWidget of(BuildContext context) {
//    return context.dependOnInheritedWidgetOfExactType<MyShareDataInheritedWidget>();
  //不希望在ShareDataWidget发生变化时调用__TestWidgetState的didChangeDependencies()方法应该怎么办？调整为如下返回
    return context.getElementForInheritedWidgetOfExactType<MyShareDataInheritedWidget>().widget;
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(MyShareDataInheritedWidget old) {
    /*
    如果返回true，则子树中依赖(build函数中有调用)本widget
    的子widget的`state.didChangeDependencies`会被调用
     */
    return old.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => new __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(MyShareDataInheritedWidget
        .of(context)
        .data
        .toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}

class MyShareDataWidget extends StatefulWidget {
  @override
  _MyShareDataWidgetState createState() => new _MyShareDataWidgetState();
}

class _MyShareDataWidgetState extends State<MyShareDataWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: MyShareDataInheritedWidget( //使用ShareDataWidget
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: _TestWidget(),//子widget中依赖ShareDataWidget
            ),
            RaisedButton(
              child: Text("Increment..."),
              //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
//              onPressed: () => setState((){
//                ++count;
//              }),
              onPressed: () => setState(() => ++count),
            )
          ],
        ),
      ),
    );
  }
}