import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
///@Description     xxxx
///@author          zhengzeqin
///@create          2021-11-27 11:56 


class TWDoubanHttpConfig {
  static const String baseURL = "https://api.douban.com/v2";
  static const int timeout = 5000;
}

class TWDoubanHttpRequest {
  static final BaseOptions baseOptions = BaseOptions(
      baseUrl: TWDoubanHttpConfig.baseURL, connectTimeout: TWDoubanHttpConfig.timeout);
  static final Dio dio = Dio(baseOptions);

  static Future<T> request<T>(String url, {
    String method = "get",
    Map<String, dynamic> params,
    Interceptor inter}) async {
    // 1.创建单独配置
    final options = Options(method: method);

    // 全局拦截器
    // 创建默认的全局拦截器
    Interceptor dInter = InterceptorsWrapper(
        onRequest: (options) {
          print("请求拦截");
          return options;
        },
        onResponse: (response) {
          print("响应拦截");
          return response;
        },
        onError: (err) {
          print("错误拦截");
          return err;
        }
    );
    List<Interceptor> inters = [dInter];

    // 请求单独拦截器
    if (inter != null) {
      inters.add(inter);
    }

    // 统一添加到拦截器中
    dio.interceptors.addAll(inters);

    print("url ===== ${url}");
    // 2.发送网络请求
    try {
      Response response = await dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch(e) {
      return Future.error(e);
    }
  }

}