import 'package:flutter/material.dart';

class ZQSwitchAndCheckBoxWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ZQSwitchAndCheckBoxWidgetState();
  }
}

class ZQSwitchAndCheckBoxWidgetState extends State<ZQSwitchAndCheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    bool _switchSelected=true; //维护单选开关状态
    bool _checkboxSelected=true;//维护复选框状态
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected,//当前状态
          onChanged:(value){
            //重新构建页面
            setState(() {
              _switchSelected=value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red, //选中时的颜色
          onChanged:(value){
            setState(() {
              _checkboxSelected=value;
            });
          } ,
        )
      ],
    );
  }
  
}