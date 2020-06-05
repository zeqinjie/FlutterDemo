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
          pageZQFadeRoute();
        }, icon: Icon(Icons.map), label: Text("click...")),
      ),
    );
  }

  //方式一 简单的作法是可以直接使用CupertinoPageRoute
  void pageCupertinoPageRoute() {
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
  void pageZQFadeRoute() {
    Navigator.push(context, ZQFadeRoute(builder: (context) {
      return MyRoutePage(text:"text");
    }));
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

//直接继承PageRoute类来实现自定义路由
class ZQFadeRoute extends PageRoute {

  ZQFadeRoute({@required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;
  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //假如我们只想在打开新路由时应用动画，而在返回时不使用动画，那么我们在构建过渡动画时就必须判断当前路由isActive属性是否为true
    //当前路由被激活，是打开新路由
    if(isActive) {
      return FadeTransition(
        opacity: animation,
        child: builder(context),
      );
    }else{
      //是返回，则不应用过渡动画
      return Padding(padding: EdgeInsets.zero);
    }
  }


}