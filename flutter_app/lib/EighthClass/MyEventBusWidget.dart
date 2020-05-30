//订阅者回调签名
typedef void EventCallback(arg);

class MyEventBus{
  //私有构造函数
  MyEventBus._internal();

  //保存单例
  static MyEventBus _singleton =  MyEventBus._internal();

  //工厂构造函数
  factory MyEventBus()=> _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap =  Map<Object, List<EventCallback>>();

  //定义一个top-level（全局）变量，页面引入该文件后可以直接使用bus
  var bus =  MyEventBus();

  //注意：Dart中实现单例模式的标准做法就是使用static变量+工厂构造函数的方式，这样就可以保证new EventBus()始终返回都是同一个实例
  //事件总线通常用于组件之间状态共享，但关于组件之间状态共享也有一些专门的包如redux、以及前面介绍过的Provider

  //添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??=  List<EventCallback>();
    _emap[eventName].add(f);
  }

  //移除订阅者
  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用 ?? [arg] 函数EventCallback参数
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }

  void testBus(){
    bus.on("login", (arg) {
      print("login...");
    });
  }
}