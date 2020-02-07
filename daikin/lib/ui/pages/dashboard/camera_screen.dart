import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/camera_ip_preview.dart';
import 'package:daikin/ui/customs/expansion_tile.dart' as expansionTile;
import 'package:daikin/ui/customs/action_button.dart';
import 'package:daikin/ui/pages/home/devices_list_view.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CameraScreen extends StatefulWidget {
  Device item;
  bool currentStateDevice;
  // Function callback;
  CameraScreen({this.item, this.currentStateDevice = false});
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  bool currentStateDevice;
  final _cameraKey = new GlobalKey<CameraIpViewState>();

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
    bool status = true;
    return SlidingUpPanel(
      backdropEnabled: true,
      minHeight: 80,
      backdropColor: HexColor('#19194C'),
      backdropOpacity: 0.57,
      panel: Material(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: deviceWidth(context),
            height: 40,
            child: Icon(
              Icons.keyboard_arrow_up,
              size: 40,
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children:
                  widget.item.devices.map((item) => buildDevice(item)).toList(),
            )),
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
            BaseHeaderScreen(
                hideProfile: true,
                isSubHeader: true,
                title: 'Camera',
                subTitle: widget.item.name),
            Expanded(
              child: Center(
                  child: CameraIpView(
                key: _cameraKey,
                url: widget.item.properties.getCameraUrl,
                width: MediaQuery.of(context).size.width,
                height: 300.0,
              )),
            ),

            /// Power control button
            Container(
              height: 56 * 3.0 + 10,
              child: GestureDetector(
                child:
                    ActionButton(icon: Icons.refresh, currentStateDevice: true),
                onTap: () {
                  _cameraKey.currentState.refreshCamera();

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

  Widget buildDevice(Device device) {
    if (device.type == "com.fibaro.binarySwitch") {
      return Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
        child: ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text(device.name),
          trailing: Switch(
            value: device.properties.value == 'true' ? true : false,
            onChanged: (val) {
              onSwitchDevice(val, device);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: Colors.white,
            activeTrackColor: HexColor(appColor),
            inactiveThumbColor: HexColor(appBorderColor),
            inactiveTrackColor: HexColor(appBorderColor),
          ),
        ),
      );
    } else if (device.type == "com.fibaro.FGRGBW441M") {
      return Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
        child: ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text(device.name),
          trailing: Switch(
            value: device.properties.value == '1' ? true : false,
            onChanged: (val) {
              onSwitchRGBDevice(val, device);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: Colors.white,
            activeTrackColor: HexColor(appColor),
            inactiveThumbColor: HexColor(appBorderColor),
            inactiveTrackColor: HexColor(appBorderColor),
          ),
        ),
      );
    } else if (device.type == "com.fibaro.FGD212") {
      return Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
        child: ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text(device.name),
          trailing: Switch(
            value: int.parse(device.properties.value) > 0 ? true : false,
            onChanged: (val) {
              onMultiSwitchDevice(val, device);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: Colors.white,
            activeTrackColor: HexColor(appColor),
            inactiveThumbColor: HexColor(appBorderColor),
            inactiveTrackColor: HexColor(appBorderColor),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: ListTile(
        leading: Icon(Icons.ac_unit),
        title: Text(device.name),
        // trailing: Switch(
        //   value: true,
        //   onChanged: (val) {
        //     print(val);
        //   },
        //   activeColor: Colors.green,
        //   inactiveThumbColor: Colors.pink,
        // ),
      ),
    );
  }

  onSwitchRGBDevice(bool val, Device device) {
    //BotToast.showText(text: 'Đổi sang trạng thái ' + device.properties.value);
    setState(() {
      if (val) {
        device.properties.value = '1';
      } else {
        device.properties.value = '0';
      }
    });

    if (!val) {
      BusinessService().turnOffDevice(device.id);
      BotToast.showText(text: "Tắt thiết bị thành công");
    } else {
      BusinessService().turnOnDevice(device.id);
      BotToast.showText(text: "Bật thiết bị thành công");
    }
  }

  onSwitchDevice(bool val, Device device) {
    device.properties.value = val.toString();
    //BotToast.showText(text: 'Đổi sang trạng thái ' + device.properties.value);
    setState(() {});

    if (!val) {
      BusinessService().turnOffDevice(device.id);
      BotToast.showText(text: "Tắt thiết bị thành công");
    } else {
      BusinessService().turnOnDevice(device.id);
      BotToast.showText(text: "Bật thiết bị thành công");
    }
  }

  onMultiSwitchDevice(bool val, Device device) {
    if (val) {
      device.properties.value = 99.toString();
    } else {
      device.properties.value = 0.toString();
    }
    //BotToast.showText(text: 'Đổi sang trạng thái ' + device.properties.value);
    setState(() {});

    if (!val) {
      BusinessService().turnOffDevice(device.id);
      BotToast.showText(text: "Tắt thiết bị thành công");
    } else {
      BusinessService().turnOnDevice(device.id);
      BotToast.showText(text: "Bật thiết bị thành công");
    }
  }
}
