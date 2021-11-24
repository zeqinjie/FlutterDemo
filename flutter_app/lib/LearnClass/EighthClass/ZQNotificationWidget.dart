import 'package:flutter/material.dart';

class ZQNotificationWidget extends StatefulWidget {
  ZQNotificationWidget({Key key}) : super(key: key);

  /*
  * 通知（Notification）是Flutter中一个重要的机制，在widget树中，每一个节点都可以分发通知，通知会沿着当前节点向上传递，
  * 所有父节点都可以通过NotificationListener来监听通知。
  * Flutter中将这种由子向父的传递通知的机制称为通知冒泡（Notification Bubbling）
  * */
  @override
  _ZQNotificationWidgetState createState() {
    return _ZQNotificationWidgetState();
  }
}

class _ZQNotificationWidgetState extends State<ZQNotificationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getMyNotificationWidget();
  }

  /*
  * NotificationListener 监听滚动
  * 滚动通知如ScrollStartNotification、ScrollUpdateNotification等都是继承自ScrollNotification类
  * 发出ScrollNotification之外，还有一些其它的通知，如SizeChangedLayoutNotification、KeepAliveNotification 、LayoutChangedNotification等
  * */
  Widget getListViewWidget(){
    return NotificationListener(
      onNotification: (notification){
        switch (notification.runtimeType){
          case ScrollStartNotification: print("开始滚动"); break;
          case ScrollUpdateNotification: print("正在滚动"); break;
          case ScrollEndNotification: print("滚动停止"); break;
          case OverscrollNotification: print("滚动到边界"); break;
        }
      },
      child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(title: Text("$index",textAlign: TextAlign.center,),);
          }
      ),
    );
  }

  String _msg="";

  /*
  * 注意：代码中注释的部分是不能正常工作的，因为这个context是根Context，而NotificationListener是监听的子树，
  * 所以我们通过Builder来构建RaisedButton，来获得按钮位置的context。
  *
  * Context上也提供了遍历Element树的方法。我们可以通过Element.widget得到element节点对应的widget；
  * 我们已经反复讲过Widget和Element的对应关系，读者通过这些源码来加深理解。
  * */

  Widget getMyNotificationWidget(){
    return NotificationListener<ZQNotification>(
      onNotification: (notification){
        setState(() {
          _msg+=notification.msg+"  ";
        });
        return true; //返回false  阻止冒泡
      },
      child: Center(
        child: Column(
          children: [
            //          RaisedButton(
//           onPressed: () => MyNotification("Hi").dispatch(context),
//           child: Text("Send Notification"),
//          ),
            Builder(builder: (context){
              return RaisedButton(
                //按钮点击时分发通知
                onPressed: () => ZQNotification("Hi").dispatch(context),
                child: Text("Send Notification"),
              );
            }),
            Text(_msg),
          ],
        ),
      ),
    );
  }
}

/*自定义通知*/
class ZQNotification extends Notification {
  ZQNotification(this.msg);
  final String msg;
}
