import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ZQDioHttpClientResumeWidget extends StatefulWidget {
  ZQDioHttpClientResumeWidget({Key key}) : super(key: key);

  @override
  _ZQDioHttpClientResumeWidgetState createState() {
    return _ZQDioHttpClientResumeWidgetState();
  }
}
/*
* Http分块下载
* 原理 Http协议定义了分块传输的响应header字段，但具体是否支持取决于Server的实现，我们可以指定请求头的"range"字段来验证服务器是否支持分块传输。
* 例如，我们可以利用curl命令来验证：http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg -v
* 如果服务器支持分块传输，则响应状态码为206，表示“部分内容”，并且同时响应头中包含“Content-Range”字段，如果不支持则不会包含
* */
class _ZQDioHttpClientResumeWidgetState extends State<ZQDioHttpClientResumeWidget> {
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

  int received = 0;
  int total = 10;

  Widget getWidget(){
    return
      Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${(received / total * 100).floor()}%"),
            OutlineButton(
                child: Text("click..."),
                onPressed: () async {
                  var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
                  var savePath = "./example/HBuilder.9.0.2.macosx_64.dmg";
                  await downloadWithChunks(url, savePath, onReceiveProgress: (received, total) {
                    if (total != -1) {
                      print("${(received / total * 100).floor()}%");
                      setState(() {
                        this.received = received;
                        this.total = total;
                      });
                    }
                  });
                })
          ],
        ),
      );
  }

  /// Downloading by spiting as file in chunks
  Future downloadWithChunks(url,savePath, {ProgressCallback onReceiveProgress,}) async{
    const firstChunkSize = 102;
    const maxChunk = 3;
    int total = 0;
    var dio = Dio();
    var progress = <int>[];

    createCallback(no) {
      return (int received, _) {
        progress[no] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    Future<Response> downloadChunk(url, start, end, no) async {
      progress.add(0);
      --end;
      return dio.download(
        url,
        savePath + "temp$no",
        onReceiveProgress: createCallback(no),
        options: Options(
          headers: {"range": "bytes=$start-$end"},
        ),
      );
    }

    Future mergeTempFiles(chunk) async {
      File f = File(savePath + "temp0");
      IOSink ioSink= f.openWrite(mode: FileMode.writeOnlyAppend);
      for (int i = 1; i < chunk; ++i) {
        File _f = File(savePath + "temp$i");
        await ioSink.addStream(_f.openRead());
        await _f.delete();
      }
      await ioSink.close();
      await f.rename(savePath);
    }

    Response response = await downloadChunk(url, 0, firstChunkSize, 0);
    if (response.statusCode == 206) {
      total = int.parse(
          response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);
      int reserved = total -
          int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
      int chunk = (reserved / firstChunkSize).ceil() + 1;
      if (chunk > 1) {
        int chunkSize = firstChunkSize;
        if (chunk > maxChunk + 1) {
          chunk = maxChunk + 1;
          chunkSize = (reserved / maxChunk).ceil();
        }
        var futures = <Future>[];
        for (int i = 0; i < maxChunk; ++i) {
          int start = firstChunkSize + i * chunkSize;
          futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
        }
        await Future.wait(futures);
      }
      await mergeTempFiles(chunk);
    }
  }

}