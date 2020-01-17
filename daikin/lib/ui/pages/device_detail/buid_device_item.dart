import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/pages/device_detail/blinds_device_screen.dart';
import 'package:daikin/ui/pages/device_detail/switch_multi_device.dart';
import 'package:daikin/ui/pages/device_detail/virtual_device_screen.dart';
import 'package:daikin/ui/pages/device_detail/device_view_item.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';

import 'device_on_off_detail_screen.dart';

Widget defaultBuildDevice(
    DeviceViewItem widget, Device device, bool isSwitched, Function callback) {
  return AnimatedBuilder(
    animation: widget.animationController,
    builder: (BuildContext context, Widget child) {
      return FadeTransition(
        opacity: widget.animation,
        child: Transform(
          transform: Matrix4.translationValues(
              0.0, 50 * (1.0 - widget.animation.value), 0.0),
          child: Material(
            elevation: 5,
            shadowColor: Colors.black26,
            color: isSwitched ? Colors.white : HexColor("#f3f3f3"),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: HexColor(appBorderColor2).withOpacity(0.1), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Routing().navigate2(
                    context,
                    DeviceOnOffDetailScreen(
                      item: widget.device,
                      status: isSwitched,
                      callback: () {
                        callback();
                      },
                    ));
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/Tuyet.png",
                          //widget.category.imagePath,
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor),
                        ),
                        Text(
                          '',
                          // '${widget.device.name}',
                          textAlign: TextAlign.left,
                          style: ptOverline(context).copyWith(
                              color: isSwitched
                                  ? Colors.black87
                                  : HexColor(appBorderColor)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      '${widget.device.name}',
                      textAlign: TextAlign.left,
                      style: ptBody1(context).copyWith(
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                        height: 30,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: -5,
                              left: -10,
                              child: Transform.scale(
                                scale: 1.0,
                                child: Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    callback(value);
                                    // setState(() {
                                    //   isSwitched = value;
                                    // });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  activeColor: Colors.white,
                                  activeTrackColor: HexColor(appColor),
                                  inactiveThumbColor: HexColor(appBorderColor),
                                  inactiveTrackColor: HexColor(appBorderColor),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildBlindsDevice(
    DeviceViewItem widget, Device device, bool isSwitched, Function callback) {
  return AnimatedBuilder(
    animation: widget.animationController,
    builder: (BuildContext context, Widget child) {
      return FadeTransition(
        opacity: widget.animation,
        child: Transform(
          transform: Matrix4.translationValues(
              0.0, 50 * (1.0 - widget.animation.value), 0.0),
          child: Material(
            elevation: 5,
            shadowColor: Colors.black26,
            color: isSwitched ? Colors.white : HexColor("#f3f3f3"),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: HexColor(appBorderColor2).withOpacity(0.1), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Routing().navigate2(
                    context,
                    BlindsDeviceScreen(
                      device: widget.device,
                    ));
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/Tuyet.png",
                          //widget.category.imagePath,
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor),
                        ),
                        Text(
                          '',
                          // '${widget.device.name}',
                          textAlign: TextAlign.left,
                          style: ptOverline(context).copyWith(
                              color: isSwitched
                                  ? Colors.black87
                                  : HexColor(appBorderColor)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      '${widget.device.name}',
                      textAlign: TextAlign.left,
                      style: ptBody1(context).copyWith(
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                        height: 30,
                       ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildSwitchDevice(
    DeviceViewItem widget, Device device, Function callback) {
  bool isSwitched = device.properties.value == 'true' ? true : false;

  return AnimatedBuilder(
    animation: widget.animationController,
    builder: (BuildContext context, Widget child) {
      return FadeTransition(
        opacity: widget.animation,
        child: Transform(
          transform: Matrix4.translationValues(
              0.0, 50 * (1.0 - widget.animation.value), 0.0),
          child: Material(
            elevation: 5,
            shadowColor: Colors.black26,
            color: isSwitched ? Colors.white : HexColor("#f3f3f3"),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: HexColor(appBorderColor2).withOpacity(0.1), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Routing().navigate2(
                    context,
                    DeviceOnOffDetailScreen(
                      item: widget.device,
                      status: isSwitched,
                      callback: (value) {
                        callback(value);
                      },
                    ));
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/Tuyet.png",
                          //widget.category.imagePath,
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor),
                        ),
                        Text(
                          '',
                          // '${widget.device.name}',
                          textAlign: TextAlign.left,
                          style: ptOverline(context).copyWith(
                              color: isSwitched
                                  ? Colors.black87
                                  : HexColor(appBorderColor)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      '${widget.device.name}',
                      textAlign: TextAlign.left,
                      style: ptBody1(context).copyWith(
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                        height: 30,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: -5,
                              left: -10,
                              child: Transform.scale(
                                scale: 1.0,
                                child: Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    callback(value);
                                    // setState(() {
                                    //   isSwitched = value;
                                    // });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  activeColor: Colors.white,
                                  activeTrackColor: HexColor(appColor),
                                  inactiveThumbColor: HexColor(appBorderColor),
                                  inactiveTrackColor: HexColor(appBorderColor),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildRGBDevice(DeviceViewItem widget, Device device, Function callback) {
  bool isSwitched = device.properties.value == '1' ? true : false;

  return AnimatedBuilder(
    animation: widget.animationController,
    builder: (BuildContext context, Widget child) {
      return FadeTransition(
        opacity: widget.animation,
        child: Transform(
          transform: Matrix4.translationValues(
              0.0, 50 * (1.0 - widget.animation.value), 0.0),
          child: Material(
            elevation: 5,
            shadowColor: Colors.black26,
            color: isSwitched ? Colors.white : HexColor("#f3f3f3"),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: HexColor(appBorderColor2).withOpacity(0.1), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Routing().navigate2(
                    context,
                    DeviceOnOffDetailScreen(
                      item: widget.device,
                      status: isSwitched,
                      callback: (value) {
                        callback(value);
                      },
                    ));
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/Tuyet.png",
                          //widget.category.imagePath,
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor),
                        ),
                        Text(
                          '',
                          // '${widget.device.name}',
                          textAlign: TextAlign.left,
                          style: ptOverline(context).copyWith(
                              color: isSwitched
                                  ? Colors.black87
                                  : HexColor(appBorderColor)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      '${widget.device.name}',
                      textAlign: TextAlign.left,
                      style: ptBody1(context).copyWith(
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                        height: 30,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: -5,
                              left: -10,
                              child: Transform.scale(
                                scale: 1.0,
                                child: Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    callback(value);
                                    // setState(() {
                                    //   isSwitched = value;
                                    // });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  activeColor: Colors.white,
                                  activeTrackColor: HexColor(appColor),
                                  inactiveThumbColor: HexColor(appBorderColor),
                                  inactiveTrackColor: HexColor(appBorderColor),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildVirtualDevice(DeviceViewItem widget, Device device) {
  // bool isSwitched = device.properties.value == 'true' ? true : false;

  return AnimatedBuilder(
    animation: widget.animationController,
    builder: (BuildContext context, Widget child) {
      return FadeTransition(
        opacity: widget.animation,
        child: Transform(
          transform: Matrix4.translationValues(
              0.0, 50 * (1.0 - widget.animation.value), 0.0),
          child: Material(
            elevation: 5,
            shadowColor: Colors.black26,
            color: HexColor("#f3f3f3"),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: HexColor(appBorderColor2).withOpacity(0.1), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Routing()
                    .navigate2(context, VirtualDeviceScreen(device: device));
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/Tuyet.png",
                          //widget.category.imagePath,
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                          color: HexColor(appBorderColor),
                        ),
                        Text(
                          '',
                          // '${widget.device.name}',
                          textAlign: TextAlign.left,
                          style: ptOverline(context)
                              .copyWith(color: HexColor(appBorderColor)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      '${widget.device.name}',
                      textAlign: TextAlign.left,
                      style: ptBody1(context)
                          .copyWith(color: HexColor(appBorderColor)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                        height: 30,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: -5,
                              left: -10,
                              child: Transform.scale(
                                  scale: 1.0, child: Container()
                                  // Switch(
                                  //   value: isSwitched,
                                  //   onChanged: (value) {
                                  //     callback(value);
                                  //     // setState(() {
                                  //     //   isSwitched = value;
                                  //     // });
                                  //   },
                                  //   materialTapTargetSize:
                                  //       MaterialTapTargetSize.padded,
                                  //   activeColor: Colors.white,
                                  //   activeTrackColor: HexColor(appColor),
                                  //   inactiveThumbColor: HexColor(appBorderColor),
                                  //   inactiveTrackColor: HexColor(appBorderColor),
                                  // ),
                                  ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildSwitchMultiDevice(DeviceViewItem widget, Device device,
    Function callback, Function setValue) {
  bool isSwitched = int.parse(device.properties.value) > 0 ? true : false;

  return AnimatedBuilder(
    animation: widget.animationController,
    builder: (BuildContext context, Widget child) {
      return FadeTransition(
        opacity: widget.animation,
        child: Transform(
          transform: Matrix4.translationValues(
              0.0, 50 * (1.0 - widget.animation.value), 0.0),
          child: Material(
            elevation: 5,
            shadowColor: Colors.black26,
            color: isSwitched ? Colors.white : HexColor("#f3f3f3"),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: HexColor(appBorderColor2).withOpacity(0.1), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Routing().navigate2(
                    context,
                    SwitchMultiDevice(
                      device: widget.device,
                      setValue: setValue,
                      onClick: callback,
                    ));
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/Tuyet.png",
                          //widget.category.imagePath,
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor),
                        ),
                        Text(
                          '',
                          // '${widget.device.name}',
                          textAlign: TextAlign.left,
                          style: ptOverline(context).copyWith(
                              color: isSwitched
                                  ? Colors.black87
                                  : HexColor(appBorderColor)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      '${widget.device.name}',
                      textAlign: TextAlign.left,
                      style: ptBody1(context).copyWith(
                          color: isSwitched
                              ? HexColor(appColor)
                              : HexColor(appBorderColor)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                        height: 30,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: -5,
                              left: -10,
                              child: Transform.scale(
                                scale: 1.0,
                                child: Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    callback(value);
                                    // setState(() {
                                    //   isSwitched = value;
                                    // });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  activeColor: Colors.white,
                                  activeTrackColor: HexColor(appColor),
                                  inactiveThumbColor: HexColor(appBorderColor),
                                  inactiveTrackColor: HexColor(appBorderColor),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
