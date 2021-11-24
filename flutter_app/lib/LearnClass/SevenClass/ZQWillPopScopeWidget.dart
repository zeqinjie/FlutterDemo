import 'package:flutter/material.dart';

class ZQWillPopScopeWidget extends StatefulWidget {
  ZQWillPopScopeWidget({Key key}) : super(key: key);

  /*
  *  const WillPopScope({
      ...
      @required WillPopCallback onWillPop,
      @required Widget child
    })
  * Flutter中可以通过WillPopScope来实现返回按钮拦截
  *  */
  @override
  _ZQWillPopScopeWidgetState createState() {
    return _ZQWillPopScopeWidgetState();
  }
}

class _ZQWillPopScopeWidgetState extends State<ZQWillPopScopeWidget> {
  DateTime _lastPressedAt; //上次点击时间
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
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: Center(
        child:getWillPopScopeWidget(),
      ),
    );
  }

  Widget getWillPopScopeWidget(){
    return WillPopScope(
        child: Container(
          alignment: Alignment.center,
          child: Text("1秒内连续按两次返回键退出"),
        ),
        onWillPop: () {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            return Future.value(false);
          }
          return Future.value(true);
        },
    );
  }
}