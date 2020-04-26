import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:daikin/utils/logCode.dart';
import 'package:flutter/material.dart';

class VirtualDeviceScreen extends StatefulWidget {
  final Device device;
  VirtualDeviceScreen({this.device});
  _VirtualDeviceScreenState createState() => _VirtualDeviceScreenState();
}

class _VirtualDeviceScreenState extends State<VirtualDeviceScreen> {

  bool currentStateDevice = false;
  String name = "Motion";
  List<dynamic> listImage = [];
  int indexImage = 0;

  Device _device;
  Timer _timer;

  @override
  void initState() {
    _device = widget.device;
    _autoRefreshDevice();
    super.initState();
  }

  _autoRefreshDevice() async {
    _timer = Timer.periodic(Duration(seconds: 5), (t) async {
      Device d = await BusinessService().getDeviceDetail(_device.id);
      setState(() {
        _device = d;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // logCode(_device.properties.rows[0]);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BaseHeaderScreen(
                  isBack: true,
                  title: upFirstText(_device.name),
                ),
                // BaseHeaderScreen(
                //     hideProfile: true,
                //     isSubHeader: true,
                //     title: upFirstText(_device.name),
                //     // subTitle: currentStateDevice
                //     //     ? "Thiết bị của bạn đang hoạt động"
                //     //     : "Thiết bị chưa hoạt động" //: widget.item.subTitle,
                //     ),
                SizedBox(
                  height: 16.0,
                ),
                getRowUI(_device.properties.rows),
              ],
            ),
          ),
        ));
  }

  Widget getRowUI(List<DeviceRow> rows) {
    List<Widget> col = [];

    print(rows.length);
    for (var i = 0; i < rows.length; i++) {
      print(rows[i].type == 'label');
      if (rows[i].type == 'label') {
        col.add(getLabelUI(
            rows[i].elements[0].caption, rows[i]?.elements[0]?.main));
      } else if (rows[i].type == 'button') {
        List<Widget> row = [];

        for (var j = 0; j < rows[i].elements.length; j++) {
          row.add(
            Expanded(
              child: getButtonUI(rows[i].elements[j]),
            ),
          );
        }

        col.add(Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: row,
            )));
      }
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: col,
      ),
    );
  }

  Widget getLabelUI(String name, bool main) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding:  EdgeInsets.only(right:16.0),
            child: Text(main ? 'Bật' : 'Tắt', style: TextStyle(fontSize: 18.0)),
          ),
        ],
      ),
    );
  }

  Widget getButtonUI(ElementDeviceRow element) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        elevation: 8,
        shadowColor: Colors.black26,
        color: StyleAppTheme.nearlyWhite,
        child: InkWell(
          splashColor: Colors.white24,
          onTap: () {
            BusinessService().pressButton(_device.id, element.id);
            BotToast.showText(text: 'Click thành công');
          },
          child: Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 16, left: 4, right: 4),
              child: Center(
                child: Text(
                  element.caption,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.27,
                    color: StyleAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
