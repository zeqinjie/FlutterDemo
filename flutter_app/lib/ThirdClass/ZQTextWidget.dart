//import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//https://book.flutterchina.club/chapter3/text.html
class ZQTextWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ZQTextWidgetState();
  }
}

class ZQTextWidgetState extends State{

  TapGestureRecognizer _tapRecognizer;

  void onTap() {
    var alert = AlertDialog(title: Text("hello word..."));
    showDialog(context: context,builder: (context)=> alert);
  }


  @override
  void initState() {
    _tapRecognizer = TapGestureRecognizer();
    _tapRecognizer.onTap = onTap;

  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getTextColumn();
  }

  /*Private Method*/
  Widget getTextColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: getTextList(),
    );
  }

  //文本组件数组
  List<Widget> getTextList() {
    // 声明自定义文本样式 首先在yaml文件注册
    const textStyle = const TextStyle(
      fontFamily: 'BalooTamma',
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
    );

    return[
      //textAlign：文本的对齐方式
      Text("Hello world! I'm Jack.",textAlign: TextAlign.right,style: textStyle,),
      //maxLines、overflow：指定文本显示的最大行数，默认情况下，文本是自动折行的，如果指定此参数，
      //则文本最多不会超过指定的行。如果有多余的文本，可以通过overflow来指定截断方式，默认是直接截断
      Text("Hello world! I'm Jack. "*4,maxLines: 1,overflow: TextOverflow.clip,),
      //textScaleFactor：代表文本相对于当前字体大小的缩放因子
      Text("Hello world",textScaleFactor: 1.5,),
      //TextStyle用于指定文本显示的样式如颜色、字体、粗细、背景等
      //fontSize：该属性和Text的textScaleFactor都用于控制字体大小。但是有两个主要区别：
      //          - fontSize可以精确指定字体大小，而textScaleFactor只能通过缩放比例来控制。
      //          - textScaleFactor主要是用于系统字体大小设置改变时对Flutter应用字体进行全局调整，而fontSize通常用于单个文本，字体大小不会跟随系统字体大小变化。
      Text("hello world",style: TextStyle(
          color: Colors.blue,
          fontSize:12,
          background:new Paint()..color=Colors.yellow,
          decoration:TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed ),),
      //Text的所有文本内容只能按同一种样式，如果我们需要对一个Text内容的不同部分按照不同的样式显示，这时就可以使用TextSpan，它代表文本的一个“片段”
      Text.rich(
          TextSpan(children: [
            TextSpan(text: "home"),
            TextSpan(text: "https://flutterchina.club",style: TextStyle(color: Colors.red),recognizer: _tapRecognizer),])),
          ];
  }

  //DefaultTextStyle 用于设置父widget默认文本样式
  Widget getDefaultTextStyle() {
    return DefaultTextStyle(
      //1.设置文本默认样式
      style: TextStyle(
        color:Colors.red,
        fontSize: 20.0,
      ),
      textAlign: TextAlign.start,
      child: Column(
        mainAxisSize:MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("hello world"),
          Text("I am Jack"),
          Text("I am Jack",
            style: TextStyle(
                inherit: false, //2.不继承默认样式
                color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }



/*
  Widget getSingleChildScrollView() {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar( // 显示进度条
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            //动态创建一个List<Widget>
            children: str.split("")
            //每一个字母都用一个Text显示,字体为原来的两倍
                .map((c) => Text(c, textScaleFactor: 6.0,))
                .toList(),
          ),
        ),
      ),
    );
  }

  StatelessWidget getCustomScroll() {
    return CustomScrollView(shrinkWrap: true,// 内容
      scrollDirection:Axis.vertical,
      slivers: <Widget>[
        SliverPadding(
          padding:
          const EdgeInsets.all(20.0),
          sliver:  SliverList(
            delegate:  SliverChildListDelegate(<Widget>[
              const Text('A',style: TextStyle(backgroundColor: Colors.yellow),),
              const Text('B'),
              const Text('C'),
              const Text('D'),],
            ),
          ),
        ),
      ],
    );
  }
*/
}