import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/power_button.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

const den = [
  "assets/devices/den_off.png",
  "assets/devices/den_on.png",
];
const denTran = [
  'assets/icons/Den_tran.png',
  'assets/icons/Den_tran.png',
];
const motion = [
  "assets/devices/motion_on.png",
  "assets/devices/motion_on.png",
];
const cua = [
  "assets/devices/cua_cam_bien_lock.png",
  "assets/devices/cua_cam_bien_open.png",
];
const tree = [
  "assets/devices/tree_0.png",
  "assets/devices/tree_1.png",
  "assets/devices/tree_2.png",
  "assets/devices/tree_3.png",
  "assets/devices/tree_4.png",
];
const sensor = [
  "assets/devices/sensor_0.png",
  "assets/devices/sensor_1.png",
  "assets/devices/sensor_2.png",
  "assets/devices/sensor_3.png",
  "assets/devices/sensor_4.png",
  "assets/devices/sensor_5.png",
];
const rem = [
  "assets/devices/rem_0.png",
  "assets/devices/rem_1.png",
  "assets/devices/rem_2.png",
  "assets/devices/rem_3.png",
];

class DeviceOnOffDetailScreen extends StatefulWidget {
  Category item;
  bool status;
  DeviceOnOffDetailScreen({this.item, this.status = false});
  _DeviceOnOffDetailScreenState createState() => _DeviceOnOffDetailScreenState();
}

class _DeviceOnOffDetailScreenState extends State<DeviceOnOffDetailScreen> {
  bool currentStateDevice;
  int indexImage = 0;
  List listImage = [];

  @override
  void initState() {
    super.initState();
    switch (widget.item.title) {
      case 'Desk lamp':
        setState(() {
          listImage = den;
        });
        break;
      case 'Bed Lamp':
        setState(() {
          listImage = denTran;
        });
        break;
      case 'Tưới cây':
        setState(() {
          listImage = tree;
        });
        break;
      case 'Cửa chính':
        setState(() {
          listImage = cua;
        });
        break;
      case 'Motion':
        setState(() {
          listImage = motion;
        });
        break;
      case 'Siren':
        setState(() {
          listImage = sensor;
        });
        break;
      case 'Rèm cửa':
        setState(() {
          listImage = rem;
        });
        break;
    }
    currentStateDevice = widget.status;
    if (widget.status) {
      indexImage = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BaseHeaderScreen(
            isBack: true,
            title: widget.item.title.toUpperCase(),
          ),
          BaseHeaderScreen(
            hideProfile: true,
            isSubHeader: true,
            title: widget.item.title,
            subTitle: currentStateDevice ? "Thiết bị của bạn đang hoạt động" : widget.item.subTitle,
          ),
          listImage.length > 0
              ? currentStateDevice
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print('indexImage $indexImage  max${listImage.length}');

                          if (indexImage + 1 == listImage.length) {
                            setState(() {
                              indexImage = 0;
                              currentStateDevice = false;
                            });
                          } else {
                            setState(() {
                              indexImage++;
                            });
                          }
                        },
                        child: Container(
                          child: Center(
                            child: Image.asset(
                              listImage[indexImage],
                              fit: BoxFit.contain,
                              width: widget.item.title == 'Motion'
                                  ? deviceWidth(context) * 0.8
                                  : deviceWidth(context) * 0.3,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print('222  indexImage $indexImage  max${listImage.length}');

                          setState(() {
                            currentStateDevice = true;

                            indexImage++;
                          });
                        },
                        child: Container(
                          child: Center(
                            child: Image.asset(listImage[indexImage],
                                fit: BoxFit.contain,
                                width: widget.item.title == 'Motion'
                                    ? deviceWidth(context) * 0.8
                                    : deviceWidth(context) * 0.3,
                                color: HexColor(appBorderColor)),
                          ),
                        ),
                      ),
                    )
              : Expanded(child: Center(child: Text('Image not found'))),

          /// Power control button
          GestureDetector(
            child: PowerButton(currentStateDevice: currentStateDevice),
            onTap: () {
              setState(() {
                currentStateDevice = !currentStateDevice;
              });
            },
          )
        ],
      ),
    );
  }
}
