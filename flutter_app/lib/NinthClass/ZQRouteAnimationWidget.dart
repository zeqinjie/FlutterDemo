import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZQRouteAnimationWidget extends StatefulWidget {
  ZQRouteAnimationWidget({Key key}) : super(key: key);

  @override
  _ZQRouteAnimationWidgetState createState() {
    return _ZQRouteAnimationWidgetState();
  }
}

class _ZQRouteAnimationWidgetState extends State<ZQRouteAnimationWidget> {

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
          pageRouteBuilder();
        }, icon: Icon(Icons.map), label: Text("click...")),
      ),
    );
  }

  //方式一 简单的作法是可以直接使用CupertinoPageRoute
  void cupertinoPageRoute() {
    Navigator.push(context, CupertinoPageRoute(
      builder: (context)=>MyRoutePage(text: "hello word",),
    ));
  }

  /*
  * 方式二 使用PageRouteBuilder自定义
  * 渐隐渐入动画来实现路由过渡
  * MaterialPageRoute、CupertinoPageRoute，还是PageRouteBuilder，它们都继承自PageRoute类，
  * */
  void pageRouteBuilder() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return FadeTransition(
            //使用渐隐渐入过渡,
            opacity: animation,
            child: MyRoutePage(text: "hello word",), //路由B
          );
        },
      ),
    );
  }

  /*
  * 方式三 自定义一个路由类FadeRoute
  * */

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
    return Scaffold(appBar: AppBar(title: Text("第九章")),
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

class ZQFadeRoute extends PageRoute {
  @override
  // TODO: implement barrierColor
  Color get barrierColor => throw UnimplementedError();

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => throw UnimplementedError();

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    throw UnimplementedError();
  }

  @override
  // TODO: implement maintainState
  bool get maintainState => throw UnimplementedError();

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => throw UnimplementedError();
  
}