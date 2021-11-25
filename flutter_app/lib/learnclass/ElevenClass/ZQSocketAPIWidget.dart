import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
class ZQSocketAPIWidget extends StatefulWidget {
  ZQSocketAPIWidget({Key key}) : super(key: key);

  @override
  _ZQSocketAPIWidgetState createState() {
    return _ZQSocketAPIWidgetState();
  }
}
/*
* Http协议和WebSocket协议都属于应用层协议，除了它们，应用层协议还有很多如：SMTP、FTP等，这些应用层协议的实现都是通过Socket API来实现的。
* 其实，操作系统中提供的原生网络请求API是标准的，在C语言的Socket库中，它主要提供了端到端建立链接和发送数据的基础API，
* 而高级编程语言中的Socket库其实都是对操作系统的socket API的一个封装
* */
class _ZQSocketAPIWidgetState extends State<ZQSocketAPIWidget> {

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
    return Text("");
  }

  _request() async{
    //建立连接
    var socket=await Socket.connect("baidu.com", 80);
    //根据http协议，发送请求头
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln("Connection:close");
    socket.writeln();
    await socket.flush(); //发送
    //读取返回内容
//    var responseBody = await socket.transform(utf8.decoder).join();

    await socket.close();
  }
}