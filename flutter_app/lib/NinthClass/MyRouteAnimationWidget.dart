import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRouteAnimationWidget extends StatefulWidget {
  MyRouteAnimationWidget({Key key}) : super(key: key);

  @override
  _MyRouteAnimationWidgetState createState() {
    return _MyRouteAnimationWidgetState();
  }
}

class _MyRouteAnimationWidgetState extends State<MyRouteAnimationWidget> {

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
    return getCenterWidget();
  }

  /// 获取center
  Widget getCenterWidget(){
    return Center(
      child: Container(
        child: OutlineButton.icon(onPressed: (){

        }, icon: Icon(Icons.map), label: Text("click...")),
      ),
    );
  }

  //方式一 简单的作法是可以直接使用CupertinoPageRoute
  void cupertinoPageRoute() {
    Navigator.push(context, CupertinoPageRoute(
      builder: (context)=>MyRoutePage(),
    ));
  }
}

//路由传值
class MyRoutePage extends StatelessWidget{
  // 使用final修饰的变量必须进行初始化，一旦被赋值之后，不能够再次被赋值,否则编译会报错。
  final String text;
  MyRoutePage({
    Key key, //Key是Widget、Element和SemanticsNode的标识符
    @required this.text, //@required 用来规定某个数据在初始化的时候是必须要提供的，否则会报错。
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("提示")),
        body: Padding(padding: EdgeInsets.all(18),
            child:
            Center(child:
            Column(children: <Widget>[Text(text),
              RaisedButton(color: Colors.yellow,
                  child: Text("返回"),
                  onPressed: (){
                    //返回值
                    Navigator.pop(context, "我是返回值zzzzz");
                  })
            ])
            )
        )
    );
  }
}
