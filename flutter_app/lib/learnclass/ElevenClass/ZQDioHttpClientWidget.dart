import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ZQDioHttpClientWidget extends StatefulWidget {
  ZQDioHttpClientWidget({Key key}) : super(key: key);

  @override
  _ZQDioHttpClientWidgetState createState() {
    return _ZQDioHttpClientWidgetState();
  }
}
/*
* dio是一个强大的Dart Http请求库，支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时等。https://github.com/flutterchina/dio
* dio的使用方式随着其版本升级可能会发生变化，如果本节所述内容和dio官方有差异，请以dio官方文档为准
*
* 1.发起 GET 请求 :
  Response response;
  response=await dio.get("/test?id=12&name=wendu")
  print(response.data.toString());
  对于GET请求我们可以将query参数通过对象来传递，上面的代码等同于：
  response=await dio.get("/test",queryParameters:{"id":12,"name":"wendu"})
  print(response);
* 2.发起一个 POST 请求:
  response=await dio.post("/test",data:{"id":12,"name":"wendu"})
* 3.发起多个并发请求:
  response= await Future.wait([dio.post("/info"),dio.get("/token")]);
* 4.下载文件:
  response=await dio.download("https://www.google.com/",_savePath);
* 5.发送 FormData:
  FormData formData = new FormData.from({
   "name": "wendux",
   "age": 25,
  });
  response = await dio.post("/info", data: formData)
* 6.通过FormData上传多个文件:
  FormData formData = new FormData.from({
     "name": "wendux",
     "age": 25,
     "file1": new UploadFileInfo(new File("./upload.txt"), "upload1.txt"),
     "file2": new UploadFileInfo(new File("./upload.txt"), "upload2.txt"),
       // 支持文件数组上传
     "files": [
        new UploadFileInfo(new File("./example/upload.txt"), "upload.txt"),
        new UploadFileInfo(new File("./example/upload.txt"), "upload.txt")
      ]
  });
  response = await dio.post("/info", data: formData)
* 值得一提的是，dio内部仍然使用HttpClient发起的请求，所以代理、请求认证、证书校验等和HttpClient是相同的，我们可以在onHttpClientCreate回调中设置，例如：
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //设置代理
    client.findProxy = (uri) {
      return "PROXY 192.168.1.2:8888";
    };
    //校验证书
    httpClient.badCertificateCallback=(X509Certificate cert, String host, int port){
      if(cert.pem==PEM){
      return true; //证书一致，则允许发送数据
     }
     return false;
    };
  };
* */
class _ZQDioHttpClientWidgetState extends State<ZQDioHttpClientWidget> {
  Dio _dio = Dio();

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
    return getDioWidget();
  }

  /*
  * 在请求阶段弹出loading
  * 请求结束后，如果请求失败，则展示错误信息；如果成功，则将项目名称列表展示出来。
  * */
  Widget getDioWidget(){
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            //请求完成
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return ListView(
                children: response.data.map<Widget>((e) =>
                    ListTile(title: Text(e["full_name"]))
                ).toList(),
              );
            }
            //请求未完成时弹出loading
            return  CircularProgressIndicator();
          },
      ),
    );
  }

}