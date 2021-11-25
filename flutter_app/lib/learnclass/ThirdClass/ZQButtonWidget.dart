import 'package:flutter/material.dart';
//https://book.flutterchina.club/chapter3/buttons.html
class ZQButtonWidget extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getBtnsColumn();
  }


  //private

  Widget getBtnsColumn(){
    return Column(children: [
      getRaisedButton(),
      getFlatButton(),
      getOutlineButton(),
      getIconButton(),
      getIconButtons(),
      getCustomButton(),
    ],mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,);
  }

  //RaisedButton 即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
  Widget getRaisedButton() {
    return RaisedButton(
      child: Text("getRaisedButton"),
      onPressed: ()=>print("getRaisedButton"),
    );
  }

  //FlatButton即扁平按钮，默认背景透明并不带阴影。按下后，会有背景色，如图3-11所示：
  Widget getFlatButton() {
    return FlatButton(
      child: Text("getFlatButton"),
      onPressed: ()=>print("getFlatButton"),
    );
  }

  //OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)，
  Widget getOutlineButton() {
    return OutlineButton(
      child: Text("getOutlineButton"),
      onPressed: ()=>print("getOutlineButton"),
    );
  }

  //IconButton是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景
  Widget getIconButton() {
    return IconButton(
      icon: Icon(Icons.thumb_up),
      onPressed: ()=>print("getIconButton"),
    );
  }

  void _onPressed() {
    print("getIconButtons");
  }

  //RaisedButton、FlatButton、OutlineButton都有一个icon 构造函数
  Widget getIconButtons() {
    return Row(children: [RaisedButton.icon(
      icon: Icon(Icons.send),
      label: Text("发送"),
      onPressed: _onPressed,
    ),
      OutlineButton.icon(
        icon: Icon(Icons.add),
        label: Text("添加"),
        onPressed: _onPressed,
      ),
      FlatButton.icon(
        icon: Icon(Icons.info),
        label: Text("详情"),
        onPressed: _onPressed,
      ),],mainAxisAlignment: MainAxisAlignment.center,);
  }

  // 自定义按钮外观
  //按钮外观可以通过其属性来定义，不同按钮属性大同小异，我们以FlatButton为例
  // 为啥在Column父widget中设置长度没有效果?
  Widget getCustomButton() {
    return Container(child: FlatButton(
      color: Colors.blue,
      highlightColor: Colors.blue[700],
      colorBrightness: Brightness.dark,
      splashColor: Colors.grey,
      child: Text("Submit"),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        print("getCustomButton");
      },
    ),width: 200,height: 100,padding: EdgeInsets.all(16.0));
  }

 }

