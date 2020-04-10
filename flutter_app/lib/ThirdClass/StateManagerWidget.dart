import 'package:flutter/material.dart';

class TapboxA extends StatefulWidget{

  TapboxA({Key key}):super(key:key);

  @override
//  _TapboxAState createState() => new _TapboxAState();
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TapboxAState();
  }
}

//自己管理自己的状态 _active
class _TapboxAState extends State<TapboxA> {

  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(_active ? 'Active' : 'Inactive',style: TextStyle(fontSize: 30,color: _active ? Colors.green : Colors.orange),),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(color:_active ? Colors.red : Colors.blue ),
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

  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() { //需要调用这个方法才能更新widget
      _active = newValue;
    });
  }

  //需将状态_active 传递给TapboxBWidget中去
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: TapboxBWidget(onChanged: _handleTapboxChanged,active: _active,)
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

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: _handleTap,
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
//------------------------- TapboxC ----------------------------------
class  ParentTapboxCWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class ParentTapboxCState extends State<ParentTapboxCWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class TapboxC extends StatelessWidget{

  TapboxC({Key key,this.active,@required this.onChanged}) : super(key:key);
  final bool active;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }



}