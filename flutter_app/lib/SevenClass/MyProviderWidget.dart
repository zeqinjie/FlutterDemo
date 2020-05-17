import 'dart:collection';
import 'package:flutter/material.dart';
// https://book.flutterchina.club/chapter7/provider.html  60%
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
  MyChangeNotifierProviderWidget({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T of<T>(BuildContext context, {bool listen = true}) {
//    final type = _typeOf<MyProviderInheritedWidget<T>>();
//    final provider =  context.dependOnInheritedWidgetOfExactType<MyProviderInheritedWidget<T>>();
//    return provider.data;

    //性能部分优化，避免不必要的build
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<MyProviderInheritedWidget<T>>()
        : context.getElementForInheritedWidgetOfExactType<MyProviderInheritedWidget<T>>()?.widget
    as MyProviderInheritedWidget<T>;
    return provider.data;
  }

  @override
  _MyChangeNotifierProviderWidgetState<T> createState() => _MyChangeNotifierProviderWidgetState<T>();

}

class _MyChangeNotifierProviderWidgetState<T extends ChangeNotifier> extends State<MyChangeNotifierProviderWidget<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(MyChangeNotifierProviderWidget<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
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

  @override
  Widget build(BuildContext context) {
    return MyProviderInheritedWidget<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

///////////
/*
* 我们可以发现使用Provider，将会带来如下收益：
* 我们的业务代码更关注数据了，只要更新Model，则UI会自动更新，而不用在状态改变后再去手动调用setState()来显式更新页面。
* 数据改变的消息传递被屏蔽了，我们无需手动去处理状态改变事件的发布和订阅了，这一切都被封装在Provider中了。这真的很棒，帮我们省掉了大量的工作！
* 在大型复杂应用中，尤其是需要全局共享的状态非常多时，使用Provider将会大大简化我们的代码逻辑，降低出错的概率，提高开发效率。
*
* */

class MyItem {
  MyItem(this.price, this.count);
  double price; //商品单价
  int count; // 商品份数
}

class MyCartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<MyItem> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<MyItem> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(MyItem item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

class MyProviderWidget extends StatefulWidget {
  @override
  _MyProviderWidgetState createState() => _MyProviderWidgetState();
}

class _MyProviderWidgetState extends State<MyProviderWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyChangeNotifierProviderWidget<MyCartModel>(
        data: MyCartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              MyConsumerBuilder<MyCartModel>(
                builder: (BuildContext context, cart) => Text("总价: ${cart.totalPrice}"),
              ),
//              Builder(builder: (context){
//                var cart = MyChangeNotifierProviderWidget.of<MyCartModel>(context);
//                return Text("总价: ${cart.totalPrice}");
//              }),
              Builder(builder: (context){
                print("RaisedButton build"); //在后面优化部分会用到
                return RaisedButton(
                  child: Text("添加商品"),
                  onPressed: () {
                    //给购物车中添加商品，添加后总价会更新,// listen 设为false，不建立依赖关系
                    MyChangeNotifierProviderWidget.of<MyCartModel>(context,listen: false).add(MyItem(20.0, 1));
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

// 这是一个便捷类，会获得当前context和指定数据类型的Provider
class MyConsumerBuilder<T> extends StatelessWidget {
  MyConsumerBuilder({
    Key key,
    @required this.builder,
    this.child,
  })  : assert(builder != null),
        super(key: key);

  final Widget child;

  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      MyChangeNotifierProviderWidget.of<T>(context), //自动获取Model
    );
  }
}