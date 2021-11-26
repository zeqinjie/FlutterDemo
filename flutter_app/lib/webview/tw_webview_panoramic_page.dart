import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp/learnclass/SecondClass/ZQNewRoute.dart';
import 'package:flutterapp/tool/screen_info.dart';
import 'package:flutterapp/webview/tw_webview_panoramic_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// create by: zhengzeqin
/// create time: 2021/11/26 2:49 下午
/// des: 

class TWWebViewPanoramicPage extends StatefulWidget {
  const TWWebViewPanoramicPage({Key key}) : super(key: key);

  @override
  State<TWWebViewPanoramicPage> createState() => _TWWebViewPanoramicPageState();
}

class _TWWebViewPanoramicPageState extends State<TWWebViewPanoramicPage> {

  TWWebviewPanoramicController controller = TWWebviewPanoramicController();

  // https://3d.591.com.tw/720/?hid=125706&device=ios&mobile_id=25F3057515B843CE853F174A37260C13&EMBED=ios&version=5.3.6.150&regionid=8
  // https://3d.591.com.tw/720/?hid=125706&device=ios&mobile_id=25F3057515B843CE853F174A37260C13&EMBED=ios&version=5.3.6.150&regionid=8
  // https://m.591.com.tw/v2/housing/video?url=https://youtu.be/bN68NXxqxxQ&EMBED=ios&version=5.3.8&houseType=housing&width=390.0&height=218.40000000000003&bgColor=000000&type=1
  Widget get webView {
    return WebView(
      initialUrl:  "https://m.591.com.tw/v2/housing/video?url=https://youtu.be/bN68NXxqxxQ&EMBED=ios&version=5.3.8&houseType=housing&width=390.0&height=218.40000000000003&bgColor=000000&type=1",
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {

      },
      navigationDelegate: (NavigationRequest request) async {
        return  controller.webNavigationDelegate(request);
      },
      onPageStarted: (url) =>  controller.webLoadStarted(url),
      onPageFinished: (url) =>  controller.webLoadFinished(url),
      gestureNavigationEnabled: true,
    );
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Widget build(BuildContext context) {
    return content;
  }

  Widget get content {
    return Stack(children: [
      webView
    ]);
  }

  Widget get back {
    return Positioned(
      top: ScreenManager().topSafeHeight,
      left: 0,
      child: GestureDetector(
        onTap: () =>  controller.onBackClick(),
        child: Container(
          width: ScreenManager().navHeight,
          height: ScreenManager().navHeight,
          padding: EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(10))),
            child: Icon(Icons.close, size: 20,),
          ),
        ),
      ),
    );
  }



}
