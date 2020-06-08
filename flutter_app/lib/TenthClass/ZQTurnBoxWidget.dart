import 'package:flutter/material.dart';
class ZQTurnBoxWidget extends StatefulWidget {
  ZQTurnBoxWidget({Key key}) : super(key: key);

  /*
  * 之前已经介绍过RotatedBox，它可以旋转子组件，但是它有两个缺点：一是只能将其子节点以90度的倍数旋转；二是当旋转的角度发生变化时，旋转角度更新过程没有动画
  * */
  @override
  _ZQTurnBoxWidgetState createState() {
    return _ZQTurnBoxWidgetState();
  }
}

class _ZQTurnBoxWidgetState extends State<ZQTurnBoxWidget> {
  double _turns = .0;

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
    return getTurnBoxWidget();
  }

  Widget getTurnBoxWidget(){
    return Center(
      child: Column(
        children: <Widget>[
          ZQTurnBox(
            turns: _turns,
            speed: 500,
            child: Icon(Icons.refresh, size: 50,),
          ),
          ZQTurnBox(
            turns: _turns,
            speed: 1000,
            child: Icon(Icons.refresh, size: 150.0,),
          ),
          RaisedButton(
            child: Text("顺时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
          ),
          RaisedButton(
            child: Text("逆时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
          ),
          ZQRichText(text: "hello",linkStyle: TextStyle(color: Colors.yellow,fontSize: 30),),
        ],
      ),
    );
  }

}


class ZQTurnBox extends StatefulWidget {

  // final修饰的初始化后是不可变
  final double turns;
  final int speed;
  final Widget child;

  //const 修饰的构造函数，必须是final的成员属性
  const ZQTurnBox({Key key,
    this.turns = .0,  //旋转的“圈”数,一圈为360度，如0.25圈即90度
    this.speed = 200, //过渡动画执行的总时长
    this.child}) : super(key: key);

  @override
  _ZQTurnBoxState createState() {
    return _ZQTurnBoxState();
  }
}

class _ZQTurnBoxState extends State<ZQTurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    creatAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getRotationTransitionWidget();
  }

  @override
  void didUpdateWidget(ZQTurnBox oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    //在didUpdateWidget中，我们判断要旋转的角度是否发生了变化，如果变了，则执行一个过渡动画。
    if(oldWidget.turns != widget.turns){//旋转角度发生变化时执行过渡动画
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed??200),
        curve: Curves.easeOut,
      );
    }
  }

  //我们是通过组合RotationTransition和child来实现的旋转效果。
  Widget getRotationTransitionWidget(){
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  //初始化animation
  void creatAnimation(){
    _controller = AnimationController(
        vsync: this,
        lowerBound: -double.infinity,
        upperBound: double.infinity
    );
    _controller.value = widget.turns;
  }
}


class ZQRichText extends StatefulWidget {
  final String text;
  final TextStyle linkStyle;

  ZQRichText({Key key, this.text, this.linkStyle}) : super(key: key);

  @override
  _ZQRichTextState createState() {
    return _ZQRichTextState();
  }

}

class _ZQRichTextState extends State<ZQRichText> {
  TextSpan _textSpan;

  /*
  * 1.解析文本字符串，构建出TextSpan是一个耗时操作，为了不在每次build的时候都解析一次，
  * 所以我们在initState中对解析的结果进行了缓存,然后再build中直接使用解析的结果_textSpan
  * 2.这看起来很不错，但是上面的代码有一个严重的问题，就是父组件传入的text发生变化时（组件树结构不变），那么ZQRichText显示的内容不会更新，
  * 原因就是initState只会在State创建时被调用，所以在text发生变化时，parseText没有重新执行，导致_textSpan任然是旧的解析值。
  * 3.要解决这个问题也很简单，我们只需添加一个didUpdateWidget回调，然后再里面重新调用parseText即
  * */
  @override
  void initState() {
    _textSpan = parseText(widget.text);
    super.initState();
  }

  /*
  * 注意：当我们在State中会缓存某些依赖Widget参数的数据时，一定要注意在组件更新时是否需要同步状态
  * */
  @override
  void didUpdateWidget(ZQRichText oldWidget) {
    if (widget.text != oldWidget.text) {// 发生变化时候，初始化新的
      _textSpan = parseText(widget.text);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _textSpan,
    );
  }

  TextSpan parseText(String text) {
    // 耗时操作：解析文本字符串，构建出TextSpan。
    // 省略具体实现。
    print("text ====> ${text}");
    return TextSpan(text: "xxxxxx\(text)",style: widget.linkStyle);
  }


}
