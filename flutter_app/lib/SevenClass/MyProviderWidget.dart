import 'dart:collection';
import 'package:flutter/material.dart';

// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
class MyProviderInheritedWidget<T> extends InheritedWidget {
  MyProviderInheritedWidget({@required this.data, Widget child}) : super(child: child);
  //共享状态使用泛型
  final T data;
  @override
  bool updateShouldNotify(MyProviderInheritedWidget<T> old) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

class MyChangeNotifierProviderWidget<T extends ChangeNotifier>  extends StatefulWidget {
  MyChangeNotifierProviderWidget({Key key,this.child,this.data}) : super(key: key);

  final Widget child;
  final T data;

  @override
  _MyChangeNotifierProviderWidgetState createState() {
    return _MyChangeNotifierProviderWidgetState();
  }

  static T of<T>(BuildContext context){
    final provider =  context.dependOnInheritedWidgetOfExactType<MyProviderInheritedWidget<T>>();
    return provider.data;
  }

}

class _MyChangeNotifierProviderWidgetState<T extends ChangeNotifier> extends State<MyChangeNotifierProviderWidget<T>> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyProviderInheritedWidget(
      data: widget.data,
      child: widget.child,
    );
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  //只要在父widget中调用setState，子widget的didUpdateWidget就一定会被调用，不管父widget传递给子widget构造方法的参数有没有改变。
  //initState -> build  , didUpdateWidget -> build
  @override
  void didUpdateWidget(MyChangeNotifierProviderWidget<T> oldWidget) {
    // TODO: implement didUpdateWidget
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }
}


class Item {
  Item(this.price, this.count);
  double price; //商品单价
  int count; // 商品份数
}

class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

class MyProviderWidget extends StatefulWidget {
  MyProviderWidget({Key key}) : super(key: key);

  @override
  _MyProviderWidgetState createState() {
    return _MyProviderWidgetState();
  }
}

class _MyProviderWidgetState extends State<MyProviderWidget> {
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
    return Center(
      child: MyChangeNotifierProviderWidget<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Builder(builder: (context){
                var cart = MyChangeNotifierProviderWidget.of<CartModel>(context);
                return Text("总价: ${cart.totalPrice}");
              }),
              Builder(builder: (context){
                print("RaisedButton build"); //在后面优化部分会用到
                return RaisedButton(
                  child: Text("添加商品"),
                  onPressed: () {
                    //给购物车中添加商品，添加后总价会更新
                    MyChangeNotifierProviderWidget.of<CartModel>(context).add(Item(20.0, 1));
                  },
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}






