import 'dart:math';

import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/power_button.dart';
import 'package:daikin/ui/pages/home/devices_list_view.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CameraScreen extends StatefulWidget {
  Category item;
  bool currentStateDevice;
  // Function callback;
  CameraScreen({this.item, this.currentStateDevice = false});
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  bool currentStateDevice;
  @override
  void initState() {
    super.initState();
    widget.currentStateDevice = Random().nextBool();
    setState(() {
      currentStateDevice = widget.currentStateDevice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      minHeight: 62,
      backdropColor: HexColor('#19194C'),
      backdropOpacity: 0.57,
      panel: Material(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            color: Colors.red,
            height: 0,
            child: Icon(
              Icons.keyboard_arrow_up,
              size: 30,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: DevicesListView(
              disableScroll: true,
            ),
          ),
        ],
      )),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BaseHeaderScreen(
              isBack: true,
              title: 'Camera'.toUpperCase(),
            ),
            BaseHeaderScreen(hideProfile: true, isSubHeader: true, title: 'Camera', subTitle: widget.item.title),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 300,
                    height: 300,
                    color: currentStateDevice ? ptPrimaryColor(context) : HexColor(appBorderColor),
                  ),
                ),
              ),
            ),

            /// Power control button
            Container(
              height: 56 * 3.0 + 10,
              child: GestureDetector(
                child: PowerButton(currentStateDevice: currentStateDevice),
                onTap: () {
                  setState(() {
                    currentStateDevice = !currentStateDevice;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
