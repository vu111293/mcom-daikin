import 'dart:async';
import 'dart:io';

import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnalyticScreen extends StatefulWidget {
  @override
  AnalyticScreenState createState() => AnalyticScreenState();
}

class AnalyticScreenState extends State<AnalyticScreen> with SingleTickerProviderStateMixin {
  ApplicationBloc _appBloc;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
  }

  Widget _basicWv() {
    return WebView(
      initialUrl: 'http://admin:admin123@mhome-showroom.ddns.net:20031/Streaming/channels/2/preview',
      javascriptMode: JavascriptMode.unrestricted,
      debuggingEnabled: true,
      userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36',
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
        webViewController.evaluateJavascript('javascript:document.getElementsByTagName(\'img\')[0].style.width=\'100%\';');
      },
      onPageFinished: (s) {
        print(s);
      },
    );
  }

  InAppWebViewController webView;
  Widget _buildWv() {
    return InAppWebView(
      initialUrl: "http://admin:admin123@mhome-showroom.ddns.net:20033/Streaming/channels/2/preview",
      initialHeaders: {},
      initialOptions: InAppWebViewWidgetOptions(
        android: AndroidInAppWebViewOptions(
          builtInZoomControls: true,
          loadWithOverviewMode: true,
          useWideViewPort: true
        )
//          inAppWebViewOptions: InAppWebViewOptions(
//            debuggingEnabled: true,
//          ),
//          androidInAppWebViewOptions: AndroidInAppWebViewOptions(
//              loadWithOverviewMode: true
//          )
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        webView = controller;
      },
      onLoadStart: (InAppWebViewController controller, String url) {
        setState(() {
//          this.url = url;
        });
      },
      onLoadStop: (InAppWebViewController controller, String url) async {
        setState(() {
//          this.url = url;
        });
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        setState(() {
//          this.progress = progress / 100;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Routing().setContext(context);
    return WillPopScope(
      child: Container(
        color: StyleAppTheme.nearlyWhite,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Container(alignment: Alignment.center, child: Text('Analytics page')),
              Container(width: 300, height: 300, child: _buildWv()),
              Expanded(child: Container(
                  color: Colors.white))
            ],
          ),
        ),
      ),
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Thông báo'),
          content: Text('Bạn có muốn thoát ứng dụng'),
          actions: [
            FlatButton(
              child: Text('Đồng ý'),
              onPressed: () => Platform.isIOS ? exit(0) : SystemNavigator.pop(),
            ),
            FlatButton(
              child: Text('Hủy'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
    );
  }
}
