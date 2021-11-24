import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ZQHttpClientWidget extends StatefulWidget {
  ZQHttpClientWidget({Key key}) : super(key: key);

  @override
  _ZQHttpClientWidgetState createState() {
    return _ZQHttpClientWidgetState();
  }
}

/*
* Dart IO库中提供了用于发起Http请求的一些类，我们可以直接使用HttpClient来发起请求。使用HttpClient发起请求分为五步：
* 1.创建一个HttpClient：HttpClient httpClient = new HttpClient();
* 2.打开Http连接，设置请求头：HttpClientRequest request = await httpClient.getUrl(uri);
  这一步可以使用任意Http Method，如httpClient.post(...)、httpClient.delete(...)等。如果包含Query参数，可以在构建uri时添加
  Uri uri=Uri(scheme: "https", host: "flutterchina.club", queryParameters: {
    "xx":"xx",
    "yy":"dd"
  });
  通过HttpClientRequest可以设置请求header，如：request.headers.add("user-agent", "test");
  如果是post或put等可以携带请求体方法，可以通过HttpClientRequest对象发送request body，如：
  String payload="...";
  request.add(utf8.encode(payload));
  //request.addStream(_inputStream); //可以直接添加输入流
* 3.等待连接服务器：HttpClientResponse response = await request.close();
* 4.读取响应内容：String responseBody = await response.transform(utf8.decoder).join();
* 5.请求结束，关闭HttpClient：httpClient.close();
* */
class _ZQHttpClientWidgetState extends State<ZQHttpClientWidget> {

  bool _loading = false;
  String _text = "";

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
    return getScrollView();
  }

  Widget getScrollView(){
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            RaisedButton(
              onPressed: (){
                getHttpData();
              },
              child: Text("获取百度首页"),
            ),
            Container(
              width: MediaQuery.of(context).size.width-50.0,
              child: Text(_text.replaceAll(RegExp(r"\s"), "")),
            )
          ],
        ),
      ),
    );
  }

  /*获取百度数据*/
  Future<String> getHttpData() async{
    setState(() {
      _loading = true;
      _text = "正在请求...";
    });
    try{
      //创建一个HttpClient
      HttpClient httpClient = HttpClient();
      //打开Http连接
      HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
      //使用iPhone的UA
      request.headers.add("user-agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
      //等待连接服务器（会将请求信息发送给服务器）
      HttpClientResponse response = await request.close();
      //读取响应内容
      _text = await response.transform(utf8.decoder).join();
      //输出响应头
      print(response.headers);
      //关闭client后，通过该client发起的所有请求都会中止。
      httpClient.close();
    }catch (e) {
      _text = "请求失败：$e";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}