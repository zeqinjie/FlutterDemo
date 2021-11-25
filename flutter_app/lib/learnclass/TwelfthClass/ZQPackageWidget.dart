import 'package:flutter/material.dart';

class ZQPackageWidget extends StatefulWidget {
  ZQPackageWidget({Key key}) : super(key: key);

  @override
  _ZQPackageWidgetState createState() {
    return _ZQPackageWidgetState();
  }
}
/*
* 一个最小的Package包括：
* 一个pubspec.yaml文件：声明了Package的名称、版本、作者等的元数据文件。
* 一个 lib 文件夹：包括包中公开的(public)代码，最少应有一个<package-name>.dart文件
*
* 1.Dart包：其中一些可能包含Flutter的特定功能，因此对Flutter框架具有依赖性，这种包仅用于Flutter，例如fluro包。https://pub.dev/packages/fluro
* 2.插件包：一种专用的Dart包，其中包含用Dart代码编写的API，以及针对Android（使用Java或Kotlin）和针对iOS（使用OC或Swift）平台的特定实现，
  也就是说插件包括原生代码，一个具体的例子是battery插件包。https://pub.dev/packages/battery
* */
class _ZQPackageWidgetState extends State<ZQPackageWidget> {
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
    return null;
  }
}