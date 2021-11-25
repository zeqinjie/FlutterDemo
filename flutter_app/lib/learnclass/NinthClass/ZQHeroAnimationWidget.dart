import 'package:flutter/material.dart';

class ZQHeroAnimationWidget extends StatefulWidget {
  ZQHeroAnimationWidget({Key key}) : super(key: key);

  @override
  _ZQHeroAnimationWidgetState createState() {
    return _ZQHeroAnimationWidgetState();
  }
}

class _ZQHeroAnimationWidgetState extends State<ZQHeroAnimationWidget> {
  /*
  * Hero指的是可以在路由(页面)之间“飞行”的widget，简单来说Hero动画就是在路由切换时，有一个共享的widget可以在新旧路由间切换。
  * */
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

  /*
  * 实现Hero动画只需要用Hero组件将要共享的widget包装起来，并提供一个相同的tag即可，中间的过渡帧都是Flutter Framework自动完成的。
  * 必须要注意， 前后路由页的共享Hero的tag必须是相同的，Flutter Framework内部正是通过tag来确定新旧路由页widget的对应关系的
  * */
  Widget getWidget() {
    return Container(
      child:InkWell(
        child:Hero(
          tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
          child:ClipOval(
            child:Image.asset("assets/icons/taofang.png"),
          ),
        ),
        onTap: (){
          Navigator.push(context, PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
            return FadeTransition(
              opacity: animation,
              child: _ZQHeroAnimationRouteB(),
            );
          }));
        },
      ),
    );
  }

}

class _ZQHeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("原图"),
      ),
      body: Center(
        child: Hero(
          tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
          child: ClipOval(
            child:Image.asset("assets/icons/taofang.png"),
          ),
        ),
      ),
    ) ;
  }
}