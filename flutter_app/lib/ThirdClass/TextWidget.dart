//import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class TextWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextWidgetState();
  }
}

class TextWidgetState extends State{

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
    return[Text("hello word",textAlign: TextAlign.right),
      Text("Hello world! I'm Jack. "*4,maxLines: 1,overflow: TextOverflow.clip,),
      Text("Hello world",textScaleFactor: 1.5,),
      Text("hello world",style: TextStyle(
          color: Colors.blue,
          fontSize:12,
          background:new Paint()..color=Colors.yellow,
          decoration:TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed ),),
      Text.rich(
          TextSpan(children: [
            TextSpan(text: "home"),
            TextSpan(text: "https://flutterchina.club",style: TextStyle(color: Colors.red),recognizer: _tapRecognizer),])),];
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