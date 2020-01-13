import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/power_button.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';

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

  var _progress = 0.0;
  double percentage = 30.0;

  double initial = 0.0;
  @override
  void initState() {
    super.initState();
    switch (widget.item.title) {
      case 'Desk lamp':
        setState(() {
          listImage = den;
        });
        break;
      // case 'Bed Lamp':
      //   setState(() {
      //     listImage = denTran;
      //   });
      //   break;
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
      _progress = 1;
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
              : widget.item.title == "Bed Lamp"
                  ? Expanded(
                      child: Container(
                        width: deviceWidth(context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/devices/sun.png",
                              fit: BoxFit.contain,
                              width: 32,
                              color: currentStateDevice ? Colors.yellow : HexColor(appBorderColor),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                '${percentage.round()}% Brightness',
                                style: ptTitle(context).copyWith(
                                  color: currentStateDevice ? HexColor(appText) : HexColor(appBorderColor),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onPanStart: (DragStartDetails details) {
                                initial = details.globalPosition.dy;
                              },
                              onPanUpdate: (DragUpdateDetails details) {
                                double distance = initial - details.globalPosition.dy;
                                double percentageAddition = distance / 254;
                                // print('percentage ' +
                                //     (percentage + percentageAddition).clamp(0.0, 100.0).round().toString());
                                setState(() {
                                  percentage = (percentage + percentageAddition).clamp(0.0, 100.0);
                                });
                              },
                              onPanEnd: (DragEndDetails details) {
                                initial = 0.0;
                              },
                              child: Container(
                                height: 250,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: HexColor("#ECECEC"),
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: currentStateDevice ? HexColor(appColor) : HexColor(appBorderColor),
                                        borderRadius: BorderRadius.all(Radius.circular(40)),
                                      ),
                                      width: 130,
                                      height: (percentage / 100) * 250,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text('Image not found'),
                      ),
                    ),

          widget.item.title == 'Rèm cửa'
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: HexColor(appBorderColor),
                      inactiveTrackColor: HexColor(appBorderColor),
                      trackHeight: 20.0,
                      thumbColor: currentStateDevice ? ptPrimaryColor(context) : HexColor(appNotWhite),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                      overlayColor: currentStateDevice ? ptPrimaryColor(context) : HexColor(appNotWhite),
                      activeTickMarkColor: Colors.transparent,
                      inactiveTickMarkColor: Colors.transparent,
                    ),
                    child: Slider(
                        min: 0,
                        max: rem.length.toDouble(),
                        divisions: 3,
                        value: _progress,
                        onChanged: (value) {
                          setState(() {
                            _progress = value;
                          });

                          if (value < 1.0) {
                            setState(() {
                              indexImage = 0;
                              currentStateDevice = false;
                            });
                            return;
                          }
                          if (value < 2.0) {
                            setState(() {
                              indexImage = 1;
                            });
                            return;
                          }
                          if (value < 3.0) {
                            setState(() {
                              indexImage = 2;
                            });
                            return;
                          }
                          if (value == 4.0) {
                            setState(() {
                              indexImage = 3;
                            });
                            return;
                          }
                        }),
                  ),
                )
              : Container(),

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
