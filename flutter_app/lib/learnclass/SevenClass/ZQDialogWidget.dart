import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//https://book.flutterchina.club/chapter7/dailog.html  80% 状态管理
class ZQDialogWidget extends StatefulWidget {
  ZQDialogWidget({Key key}) : super(key: key);

  @override
  _ZQDialogWidgetState createState() {
    return _ZQDialogWidgetState();
  }
}

class _ZQDialogWidgetState extends State<ZQDialogWidget> {
  /*
  * AlertDialog,SimpleDialog,Dialog
  * */

  /*
  * const AlertDialog({
      Key key,
      this.title, //对话框标题组件
      this.titlePadding, // 标题填充
      this.titleTextStyle, //标题文本样式
      this.content, // 对话框内容组件
      this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0), //内容的填充
      this.contentTextStyle,// 内容文本样式
      this.actions, // 对话框操作按钮组
      this.backgroundColor, // 对话框背景色
      this.elevation,// 对话框的阴影
      this.semanticLabel, //对话框语义化标签(用于读屏软件)
      this.shape, // 对话框外形
    })
  *
  * */
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
    return OutlineButton(
      child: Text("click"),
      onPressed: () async{
//        bool delete = await showDeleteConfirmDialog();
//        if (delete == null) {
//          print("取消删除");
//        } else {
//          print("已确认删除");
//        }
//        changeLanguage();
//        showListDialog();
//        showConstrainedBox();
//        showMyModalBottomSheet();
//        showMyBottomSheet();
//        showLoadingDialog();
        showMyDatePicker();
      },
    );
  }

  /*
  * Future<T> showDialog<T>({
      @required BuildContext context,
      bool barrierDismissible = true, //点击对话框barrier(遮罩)时是否关闭它
      WidgetBuilder builder, // 对话框UI的builder
    })
  *
  * */

  bool withTree = false; // 复选框选中状态

  //如果AlertDialog的内容过长，内容将会溢出，这在很多时候可能不是我们期望的，所以如果对话框内容过长时，可以用SingleChildScrollView将内容包裹起来
  Future<bool> showDeleteConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  //SimpleDialog
  Future<void> changeLanguage() async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('美国英语'),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }

  /*AlertDialog和SimpleDialog都使用了Dialog类,
    * AlertDialog(
        content: ListView(
        children: ...//省略
       ),
      );
    */

  Future<void> showListDialog() async {
    int index = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        var child = Column(
          children: <Widget>[
            ListTile(title: Text("请选择")),
            Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  },
                )),
          ],
        );
        //使用AlertDialog会报错
        //return AlertDialog(content: child);
        return Dialog(child: child);
      },
    );
    if (index != null) {
      print("点击了：$index");
    }
  }

  Future<void> showConstrainedBox() async{
    await showDialog(context: context,builder: (build){
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 280,minHeight: 100),
          child: Material(
            child: Text("CHINA"),
            type: MaterialType.card,
          ),
        ),
      );
    });
  }

  // 弹出底部菜单列表模态对话框
  Future<int> showMyModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      },
    );
  }

  // 返回的是一个controller
  PersistentBottomSheetController<int> showMyBottomSheet() {
    return showBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: (){
                // do something
                print("$index");
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  Future<DateTime> showMyDatePicker() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add( //未来30天可选
        Duration(days: 30),
      ),
    );
  }

  Future<DateTime> showMyDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      },
    );
  }
}

//状态管理 ？？