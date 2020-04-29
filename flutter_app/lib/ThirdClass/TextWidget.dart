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
  @override
  Widget build(BuildContext context) {

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

    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("hello word",textAlign: TextAlign.right,),
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
              TextSpan(text: "https://flutterchina.club",style: TextStyle(color: Colors.red),recognizer: _tapRecognizer),])),
      ],
    );
  }




}