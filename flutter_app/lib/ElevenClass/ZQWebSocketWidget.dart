import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class ZQWebSocketWidget extends StatefulWidget {
  ZQWebSocketWidget({Key key}) : super(key: key);

  @override
  _ZQWebSocketWidgetState createState() {
    return _ZQWebSocketWidgetState();
  }
}

class _ZQWebSocketWidgetState extends State<ZQWebSocketWidget> {

  TextEditingController _controller =  TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
//    super.initState(); // 为啥注释掉
    //创建websocket连接
    channel =  IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  Text("WebSocket(内容回显)"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                //网络不通会走到这
                if (snapshot.hasError) {
                  _text = "网络不通...";
                } else if (snapshot.hasData) {
                  _text = "echo: "+snapshot.data;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(_text),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }
}