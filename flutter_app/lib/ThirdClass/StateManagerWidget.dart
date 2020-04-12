import 'package:flutter/material.dart';

class TapboxA extends StatefulWidget{

  TapboxA({Key key}):super(key:key);

  @override
//  _TapboxAState createState() => new _TapboxAState();
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TapboxAState();
  }
}

//自己管理自己的状态 _active
class TapboxAState extends State<TapboxA> {

  bool active = false;

  void handleTap() {
    setState(() {
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        child: Center(
          child: Text(active ? 'Active' : 'Inactive',style: TextStyle(fontSize: 30,color: active ? Colors.green : Colors.orange),),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(color:active ? Colors.red : Colors.blue ),
      ),
    );
  }
}

// 父widget 管理 子widget 状态，状态管理是父widget 所以其是StatefullWidget 子是StatelessWidget
//------------------------- TapboxB ----------------------------------
class ParentTapboxBWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ParentTapboxBState();
  }
}

class ParentTapboxBState extends State <ParentTapboxBWidget>{

  bool active = false;

  void handleTapboxChanged(bool newValue) {
    setState(() { //需要调用这个方法才能更新widget
      active = newValue;
    });
  }

  //需将状态_active 传递给TapboxBWidget中去
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: TapboxBWidget(onChanged: handleTapboxChanged,active: active,)
      ,color: Colors.yellow,);
  }
  
}

//父Widgett
class TapboxBWidget extends StatelessWidget {

  TapboxBWidget({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  //需初始化
  final bool active;
  //暴露一个方法
  final ValueChanged<bool> onChanged;

  void handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        child: Center(
          child: Text(active ? 'Active' : 'Inactive',style: TextStyle(fontSize: 30,color: active ? Colors.green : Colors.orange),),
        ),
        width: 300,
        height: 200,
        decoration: BoxDecoration(color:active ? Colors.red : Colors.blue ),
      ),
    );
  }
  
}


// 混合状态管理
// ParentTapboxCWidget 重新返回 ParentTapboxCState 实例，自身有个active状态
// 子Widget TapboxCWidget暴露active及事件响应函数handleTapboxChanged 属性控制子widget的状态active
// 同时子Widget 的 TapboxCState 实例对象，自己管理自己的highlight
//------------------------- TapboxC ----------------------------------
class  ParentTapboxCWidget extends StatefulWidget{
  @override
  ParentTapboxCState createState() =>  ParentTapboxCState();
}

class ParentTapboxCState extends State<ParentTapboxCWidget> {
  bool active = false;

  void handleTapboxChanged(bool newValue) {
    setState(() {
      active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: TapboxCWidget(onChanged: handleTapboxChanged,active: active,)
      ,color: Colors.yellow,);
  }
}

class TapboxCWidget extends StatefulWidget{

  TapboxCWidget({Key key,this.active,@required this.onChanged}) : super(key:key);
  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TapboxCState();
  }
}

class TapboxCState extends State <TapboxCWidget>{
  bool highlight = false;

  //处理按下事件
  void handleTapDown(TapDownDetails details) {
    setState(() {
      highlight = true;
    });
  }

  //处理抬起事件
  void handleTapUp(TapUpDetails details) {
    setState(() {
      highlight = false;
    });
  }

  //点击取消
  void handleTapCancel() {
    setState(() {
      highlight = false;
    });
  }

  void handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTapDown: handleTapDown,
      onTapUp: handleTapUp,
      onTap: handleTap,
      onTapCancel: handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
          widget.active ? 'Active' : 'Inactive',
          style: TextStyle(
              fontSize: 34,
              color: widget.active ? Colors.red:Colors.blue),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color:widget.active ? Colors.blue : Colors.red ,
            border: highlight ? Border.all(
                color: Colors.green,width: 10) : null
        ),
      ),
    );
  }

}