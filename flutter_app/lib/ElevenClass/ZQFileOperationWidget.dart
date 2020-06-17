import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ZQFileOperationWidget extends StatefulWidget {
  ZQFileOperationWidget({Key key}) : super(key: key);

  @override
  _ZQFileOperationWidgetState createState() {
    return _ZQFileOperationWidgetState();
  }
}

/*
* Android和iOS的应用存储目录不同，PathProvider 插件提供了一种平台透明的方式来访问设备文件系统上的常用位置。该类当前支持访问两个文件系统位置：
* 1.临时目录: 可以使用 getTemporaryDirectory() 来获取临时目录； 系统可随时清除的临时目录（缓存）。在iOS上，这对应于NSTemporaryDirectory() 返回的值。
*   在Android上，这是getCacheDir())返回的值。
* 2.文档目录: 可以使用getApplicationDocumentsDirectory()来获取应用程序的文档目录，该目录用于存储只有自己可以访问的文件。
*   只有当应用程序被卸载时，系统才会清除该目录。在iOS上，这对应于NSDocumentDirectory。在Android上，这是AppData目录。
* 3.外部存储目录：可以使用getExternalStorageDirectory()来获取外部存储目录，如SD卡；由于iOS不支持外部目录，所以在iOS下调用该方法会抛出UnsupportedError异常，
*   而在Android下结果是android SDK中getExternalStorageDirectory的返回值。
* */

class _ZQFileOperationWidgetState extends State<ZQFileOperationWidget> {
  int _counter = 0;

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
    return getWidget();
  }

  Widget getWidget() {
      return Stack(
          alignment: Alignment.center,//默认居中显示
          fit: StackFit.loose,       //未定位widget占满Stack整个空间,
          children: [
            Positioned(
                top: 10,
                child: Text("点击次数：$_counter")
            ),
            Positioned(
                bottom: 10,
                child: OutlineButton.icon(
                    onPressed: (){
                      _incrementCounter();
                      },
                    icon: Icon(Icons.add),
                    label: Text("add")
                )
            ),
          ]);
  }

  /*读取本地文件*/
  Future<File> _getLocalFile() async{
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  /*获取数据次数*/
  Future<int> _readCounter() async{
    try {
      File file = await _getLocalFile();
      // 读取点击次数（以字符串）
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  /*累加*/
  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // 将点击次数以字符串类型写到文件中
    await(await _getLocalFile()).writeAsString('$_counter');
  }



}