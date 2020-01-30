import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class CameraIpView extends StatefulWidget {
  final String url;
  final double width;
  final double height;

  CameraIpView({Key key, this.url, this.width, this.height}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CameraIpViewState();
  }
}

class CameraIpViewState extends State<CameraIpView> {

  static const int MAX_CAMERA_TRY = 3;

  InAppWebViewController webView;
  double dynamicHeight = 300.0;
  bool _camReady = false;
  String _camMessage;
  int _camTryNumber = 0;

  @override
  void initState() {
    if (widget.height > 0) {
      dynamicHeight = widget.height;
    }
    _camMessage = 'Đang tải...';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: dynamicHeight,
      child: Stack(children: <Widget>[
        IgnorePointer(
            child: InAppWebView(
              initialUrl: widget.url,
              initialHeaders: {},
              initialOptions: InAppWebViewWidgetOptions(
                  android: AndroidInAppWebViewOptions(
                    useWideViewPort: true,
                  ),
                  crossPlatform: InAppWebViewOptions(
                    javaScriptEnabled: true,
                  )
              ),
              onWebViewCreated: (InAppWebViewController controller) async {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                print('start load');
                _customizeWebviewLayout();
              },
              onLoadStop: (InAppWebViewController controller, String url) async {
                print('done load');
              },
              onProgressChanged: (InAppWebViewController controller, int progress) {
                setState(() {});
              },
            )),
        _camReady ? Container() : Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: Text(_camMessage, style: TextStyle(color: Colors.white)),)
      ],),
    );
  }

  void _customizeWebviewLayout() {
    Future.delayed(Duration(milliseconds: 500), () async {
      await webView.evaluateJavascript(
          source: "javascript:(function() {"
              "document.getElementsByTagName(\"img\")[0].width = \"${widget.width}\";"
              "document.getElementsByTagName(\"img\")[0].align = \"middle\";"
              "document.getElementsByTagName(\"img\")[0].style=\"-webkit-user-select: none;margin: 0,0,0,0;\";"
              "document.querySelector('meta[name=viewport]').setAttribute('content', 'width=device-width, initial-scale=1.0, user-scalable=no');"
              "})()");

      dynamic ret = await webView.evaluateJavascript(source: "document.getElementsByTagName(\"img\")[0].height;");
      if (ret != null && ret > 200) {
        _camTryNumber = 0;
        if (mounted) {
          setState(() {
            dynamicHeight = (ret as int) * 1.0;
          });
        }

        // Wait for refresh webpage
        Future.delayed(Duration(milliseconds: 1500), () {
          if (mounted) {
            setState(() {
              _camReady = true;
              _camMessage = '';
            });
          }
        });
      } else {
        if (_camTryNumber < MAX_CAMERA_TRY) {
          _camTryNumber++;
          refreshCamera();
        } else {
          if (mounted) {
            setState(() {
              _camReady = false;
              _camMessage = 'Camera đang bận.\nVui lòng thử lại sau';
            });
          }
        }
      }
    });
  }

  Future refreshCamera() async {
    setState(() {
      _camReady = false;
      _camMessage = 'Đang tải...';
    });
    await webView.reload();
    return Future;
  }
}