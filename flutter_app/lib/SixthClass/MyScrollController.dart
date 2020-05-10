import 'package:flutter/material.dart';

class MyScrollControllerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyScrollControllerWidgetState();
}

class MyScrollControllerWidgetState extends State<MyScrollControllerWidget>{

  ScrollController controller =  ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  /*
  * ScrollController({
      double initialScrollOffset = 0.0, //初始滚动位置
      this.keepScrollOffset = true,//是否保存滚动位置
      ...
    })
    *
    * jumpTo(double offset)、animateTo(double offset,...)：
    * 这两个方法用于跳转到指定的位置，它们不同之处在于，后者在跳转时会执行一个动画，而前者不会。
  * */

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    controller.addListener(() {
      print(controller.offset); //打印滚动位置
      if (controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getNotificationListenerWidget();
  }

  Widget getListViewWidget() {
    return Column(
      children: [
        Expanded(child:
          ListView.builder(
            controller: controller,
            itemCount: 50,
            itemBuilder: (context,index){
              return ListTile(title: Text(index.toString()),);
            }
          ),
        ),
        FloatingActionButton(
          onPressed: (){
            toTop();
          },
          child: Text("Top"),
          backgroundColor: Colors.blue,
        ),
        Container(color: Colors.white, height: 20)
      ],
    );
  }

  void toTop(){
    if(showToTopBtn){
      controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.ease);
    }
  }

  /* 1.滚动位置恢复
  *  PageStorage是一个用于保存页面(路由)相关数据的组件
  *  每次滚动结束，可滚动组件都会将滚动位置offset存储到PageStorage中，当可滚动组件重新创建时再恢复。
  *  如果ScrollController.keepScrollOffset为false，则滚动位置将不会被存储，
  *  可滚动组件重新创建时会使用ScrollController.initialScrollOffset；ScrollController.keepScrollOffset为true时，
  *  可滚动组件在第一次创建时，会滚动到initialScrollOffset处，因为这时还没有存储过滚动位置
  */
  /* 2.ScrollPosition 用来保存可滚动组件的滚动位置的
  *  原因：一个Controller 可以被多个Scroll使用，通过ScrollPosition 读取不同滚动位置
  *  controller.positions.elementAt(0).pixels
  *  controller.positions.elementAt(1).pixels
  * */
  /* 3.ScrollController控制原理
  *  ScrollPosition createScrollPosition(
       ScrollPhysics physics,
       ScrollContext context,
       ScrollPosition oldPosition
     );
     void attach(ScrollPosition position) ;
     void detach(ScrollPosition position) ;
  *
  *  1)ScrollController和可滚动组件关联时，可滚动组件首先会调createScrollPosition()方法创建一个ScrollPosition来存储滚动位置信息
  *  2)调用attach()方法，将创建的ScrollPosition添加到ScrollController的positions属性中
  *  3)可滚动组件销毁时，会调用ScrollController的detach()方法,将其ScrollPosition对象从ScrollController的positions属性中移除
  *
  *  关联创建 -> 注册 -> 销毁
  *  子组件与父组件 父组件通过NotificationListener 组件监听
  *  滚动组件会发送ScrollNotification类型通知，ScrollBar通过监听滚动通知实现
  *  注意：通过ScrollNotification 通知与通过ScrollController 监听不同
  *       1.通过NotificationListener可以在从可滚动组件到widget树根之间任意位置都能监听。而ScrollController只能和具体的可滚动组件关联后才可以。
  *       2.收到滚动事件后获得的信息不同；NotificationListener在收到滚动事件时，通知中会携带当前滚动位置和ViewPort的一些信息，而ScrollController只能获取当前滚动位置。
  * */


  /*
  * 在接收到滚动事件时，参数类型为ScrollNotification，它包括一个metrics属性，它的类型是ScrollMetrics，该属性包含当前ViewPort及滚动位置等信息：
  * pixels：当前滚动位置。
  * maxScrollExtent：最大可滚动长度。
  * extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
  * extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
  * extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
  * atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）。
  * */
  String progress = "0%";

  Widget getNotificationListenerWidget(){
    return Scrollbar( //进度条
      // 监听滚动通知
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double _progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          //重新构建
          setState(() {
            progress = "${(_progress * 100).toInt()}%";
          });
          print("BottomEdge: ${notification.metrics.extentAfter == 0}");
          //return true; //放开此行注释后，进度条将失效
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                }
            ),
            CircleAvatar(  //显示进度百分比
              radius: 30.0,
              child: Text(progress),
              backgroundColor: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}