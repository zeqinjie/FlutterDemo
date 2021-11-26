import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// create by: zhengzeqin
/// create time: 2021/11/26 3:08 下午
/// des: 

class TWWebviewPanoramicController {
  /// web开始加载
  void webLoadStarted(String url) async {

  }

  /// web完成加载
  void webLoadFinished(String url) async {

  }

  /// 导航拦截
  NavigationDecision webNavigationDelegate(NavigationRequest request) {
    return NavigationDecision.navigate;
  }

  void onBackClick() {

  }
}