import 'package:flutter/material.dart';
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Text("this is new route",style: TextStyle(color: Colors.blue) ),
                                                    Text("hello come in",textAlign: TextAlign.left,)],),
      ),
    );
  }
}