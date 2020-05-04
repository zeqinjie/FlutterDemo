import 'package:flutter/material.dart';

class MyFlexWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyFlexWidgetState();
}
/**
 * Expanded 撑开flex布局子组件空间
 */
class MyFlexWidgetState extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getColumnFlexWidget();
  }

  /*
  * 弹性布局允许子组件按照一定比例来分配父容器空间。弹性布局的概念在其它UI系统中也都存在，如H5中的弹性盒子布局，Flutter中的弹性布局主要通过Flex和Expanded来配合实现。
  * Row和Column都继承自Flex,Flex继承自MultiChildRenderObjectWidget，对应的RenderObject为RenderFlex，RenderFlex中实现了其布局算法。
  * flex:参数为弹性系数，如果为0或null，则child是没有弹性的，即不会被扩伸占用的空间。如果大于0，
         所有的Expanded按照其flex的比例来分割主轴的全部空闲空间。下面我们看一个例子
  *
  */
  Widget getColumnFlexWidget() {
    return Column(
      children: [
        Flex(direction: Axis.horizontal,
          children: [
            Expanded(flex: 1,child: Container(height: 30,color: Colors.green,)),
            Expanded(flex: 2,child: Container(height: 50,color: Colors.red,)),
          ],
        ),
        Padding(padding:EdgeInsets.only(top: 15,right: 15),
          child: SizedBox(height: 100,
            child: Flex(direction: Axis.vertical,
              children: [
                Expanded(flex: 1,child: Container(height: 30,color: Colors.yellow,)),
                Spacer(flex: 1,), //Spacer的功能是占用指定比例的空间，实际上它只是Expanded的一个包装类
                Expanded(flex: 2,child: Container(height: 50,color: Colors.blue,)),
              ],
            ),
          ),
        ),
      ],
    );
  }


}