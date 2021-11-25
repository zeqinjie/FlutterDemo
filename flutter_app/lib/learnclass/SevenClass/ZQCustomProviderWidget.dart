import 'dart:collection';
import 'package:flutter/material.dart';
// https://book.flutterchina.club/chapter7/provider.html  60%
// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
class ZQProviderInheritedWidget<T> extends InheritedWidget {
  ZQProviderInheritedWidget({@required this.data, Widget child}) : super(child: child);


  //共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(ZQProviderInheritedWidget<T> old) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

class ZQChangeNotifierProviderWidget<T extends ChangeNotifier>  extends StatefulWidget {
  ZQChangeNotifierProviderWidget({
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
        ? context.dependOnInheritedWidgetOfExactType<ZQProviderInheritedWidget<T>>()
        : context.getElementForInheritedWidgetOfExactType<ZQProviderInheritedWidget<T>>()?.widget
    as ZQProviderInheritedWidget<T>;
    return provider.data;
  }

  @override
  _ZQChangeNotifierProviderWidgetState<T> createState() => _ZQChangeNotifierProviderWidgetState<T>();

}

class _ZQChangeNotifierProviderWidgetState<T extends ChangeNotifier> extends State<ZQChangeNotifierProviderWidget<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ZQChangeNotifierProviderWidget<T> oldWidget) {
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
    return ZQProviderInheritedWidget<T>(
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

class ZQItem {
  ZQItem(this.price, this.count);
  double price; //商品单价
  int count; // 商品份数
}

class ZQCartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<ZQItem> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<ZQItem> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(ZQItem item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

class ZQCustomProviderWidget extends StatefulWidget {
  @override
  _ZQCustomProviderWidgetState createState() => _ZQCustomProviderWidgetState();
}

class _ZQCustomProviderWidgetState extends State<ZQCustomProviderWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZQChangeNotifierProviderWidget<ZQCartModel>(
        data: ZQCartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              ZQConsumerBuilder<ZQCartModel>(
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
                    ZQChangeNotifierProviderWidget.of<ZQCartModel>(context,listen: false).add(ZQItem(20.0, 1));
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
class ZQConsumerBuilder<T> extends StatelessWidget {
  ZQConsumerBuilder({
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
      ZQChangeNotifierProviderWidget.of<T>(context), //自动获取Model
    );
  }
}