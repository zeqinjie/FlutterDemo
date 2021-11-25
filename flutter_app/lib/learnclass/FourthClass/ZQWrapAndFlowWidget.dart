import 'package:flutter/material.dart';

class ZQWrapAndFlowWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ZQWrapAndFlowWidgetState();
}

class ZQWrapAndFlowWidgetState extends State<ZQWrapAndFlowWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getFlowWidget();
  }

  Widget getRowWidget(){
    // Row和Colum时，如果子widget超出屏幕范围，则会报溢出错误 如下
    var r = Row(
      children: <Widget>[
        Text("xxx"*100)
      ],
    );
    return r;
  }

  /*
  * spacing：主轴方向子widget的间距
  * runSpacing：纵轴方向的间距
  * runAlignment：纵轴方向的对齐方式
  * */
  Widget getWrapWidget(){
    return Wrap(
      spacing: 8.0, //主轴(水平)方向间距
      runSpacing: 4.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center, //沿主轴方向居中
      children: [
        //Chip  标签组件
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue,child: Text("A"),),
          label: Text("Hamilton"),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue,child: Text("B"),),
          label: Text("Lafayette"),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue,child: Text("C"),),
          label: Text("Mulligan"),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue,child: Text("D"),),
          label: Text("Laurens"),
        ),
      ],
    );
  }

  /*
  * Flow，因为其过于复杂，需要自己实现子widget的位置转换,优先考虑使用Wrap,因为比较复杂需要计算位置
  * 优点：
  * 性能好，在Flow定位过后，如果子组件的尺寸或者位置发生了变化，在FlowDelegate中的paintChildren()方法中调用context.paintChild 进行重绘，
  * 而context.paintChild在重绘时使用了转换矩阵，并没有实际调整组件位置
  * 灵活：
  * */

  Widget getFlowWidget(){
    return Flow(
      delegate: ZQFlowDelegate(margin: EdgeInsets.all(10.0)),
      children: <Widget>[
        new Container(width: 80.0, height:80.0, color: Colors.red,),
        new Container(width: 80.0, height:80.0, color: Colors.green,),
        new Container(width: 80.0, height:80.0, color: Colors.blue,),
        new Container(width: 80.0, height:80.0,  color: Colors.yellow,),
        new Container(width: 80.0, height:80.0, color: Colors.brown,),
        new Container(width: 80.0, height:80.0,  color: Colors.purple,),
      ],
    );
  }
}

class ZQFlowDelegate extends FlowDelegate{

  EdgeInsets margin = EdgeInsets.zero;
  ZQFlowDelegate({this.margin});

  //可以看到我们主要的任务就是实现paintChildren，它的主要任务是确定每个子widget位置。
  // 由于Flow不能自适应子widget的大小，我们通过在getSize返回一个固定大小来指定Flow的大小。
  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i<context.childCount;i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      }else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
//    return super.getSize(constraints);
    return Size(double.infinity, 200);
  }


  @override
  //这里使用covariant协变关键字 表示MyFlowDelegate对象中的shouldRepaint方法只接收MyFlowDelegate对象
  bool shouldRepaint(ZQFlowDelegate oldDelegate){
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }

}

