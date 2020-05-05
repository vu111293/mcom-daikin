import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/ui/pages/dashboard/rgb_screen.dart';
import 'package:daikin/ui/pages/device_detail/switch_multi_device.dart';
import 'package:daikin/ui/pages/device_detail/virtual_device_screen.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

import 'air_conditioner_device.dart';
import 'blinds_device_screen.dart';

class DeviceViewItem extends StatefulWidget {

  final Device device;
  final bool isAlarm;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  const DeviceViewItem({Key key, this.isAlarm, this.device, this.animationController, this.animation}) : super(key: key);

  @override
  _DeviceViewItemState createState() => _DeviceViewItemState();
}

class _DeviceViewItemState extends State<DeviceViewItem> {
  bool isSwitched = false;
  ApplicationBloc _appBloc;
  Device _localDevice;

  @override
  void initState() {
    _localDevice = widget.device;
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildDevices();
  }

  Widget buildDevices() {
    if (_localDevice.getDeviceType == DeviceType.ALARM && widget.isAlarm) {
      return buildDeviceInCell(
          widget: widget,
          armed: _localDevice.properties.armed == 'true',
          defValue: _localDevice.properties.value == 'true',
          onAction: (v) {
            onSwitchAlarmDevice(v, _localDevice);
          });
    // Đen BTH
    } else if (_localDevice.type == "com.fibaro.binarySwitch") {
      return buildDeviceInCell(
          widget: widget,
          defValue: _localDevice.properties.value == 'true',
          onAction: (v) {
            onSwitchDevice(v, _localDevice);
          });
      // Den Led RGB
    } else if (_localDevice.type == "com.fibaro.FGRGBW441M") {
      return buildDeviceInCell(
          widget: widget,
          defValue: _localDevice.properties.value != '0',
          onAction: (v) {
            onSwitchRGBDevice(v, _localDevice);
          },
          onTap: () {
            Routing().navigate2(context, RgbScreen(device: widget.device)).then((d) {
              _refreshDeviceInfo(_localDevice);
            });
          });
    } else if (_localDevice.type == "virtual_device") {
      return buildDeviceInCell(
          widget: widget,
          defValue: _localDevice.properties.value == 'true',
          onTap: () {
            if (_localDevice.getDeviceType == DeviceType.AIR_CONDITIONAL) {
              Routing().navigate2(context, AirConditionerDevice(device: _localDevice));
            } else {
              Routing().navigate2(context, VirtualDeviceScreen(device: _localDevice));
            }
          });
      // Rem cua
    } else if (_localDevice.type == "com.fibaro.FGRM222") {
      return buildDeviceInCell(
          widget: widget,
          defValue: int.parse(_localDevice.properties.value) > 0,
          onAction: (v) {
            onSwitchMultiDevice(v ? 100 : 0, _localDevice);
          },
          onTap: () {
            Routing().navigate2(context, BlindsDeviceScreen(device: widget.device));
          });
      // Den Chum
    } else if (_localDevice.type == "com.fibaro.FGD212") {
      return buildDeviceInCell(
          widget: widget,
          defValue: int.parse(_localDevice.properties.value) > 0,
          onAction: (v) {
            onClickMultiDevice(v, _localDevice);
          },
          onTap: () {
            Routing().navigate2(
                context,
                SwitchMultiDevice(
                  device: widget.device,
                  setValue: (v) {
                    onSwitchMultiDevice(v, _localDevice);
                  },
                  onClick: (v) {
                    onClickMultiDevice(v, _localDevice);
                  },
                ));
          });
    }

    if (_localDevice.properties.isSensorDevice) {
      isSwitched = _localDevice.properties.getSensorEnable;
    }

    return buildDeviceInCell(
      widget: widget,
      defValue: isSwitched,
    );
  }

  Widget buildDeviceInCell({DeviceViewItem widget, bool defValue, bool armed, Function onAction, Function onTap}) {
    bool isDead = widget.device.properties.dead == "true";

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child: Material(
              elevation: 12,
              shadowColor: Colors.black54,
              color: isDead ? Colors.black26 : Colors.white,
              shape: RoundedRectangleBorder(
                side: defValue ? BorderSide(color: HexColor(appBorderColor2).withOpacity(0.1), width: 1) : BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Stack(children: <Widget>[
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Image.network(
                              widget.device.getDeviceIconURL,
                              width: 28,
                              height: 28,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                '${upFirstText(widget.device.getName)}',
                                textAlign: TextAlign.left,
                                style: ptBody1(context).copyWith(color: defValue ? HexColor(appColor) : HexColor(appBorderColor)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onAction == null
                                  ? Container()
                                  : Container(
                                  height: 30,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: -5,
                                        left: -10,
                                        child: Transform.scale(
                                          scale: 1.0,
                                          child: Switch(
                                            value: armed ?? defValue,
                                            onChanged: (value) {
                                              onAction(value);
                                              // setState(() {
                                              //   isSwitched = value;
                                              // });
                                            },
                                            materialTapTargetSize: MaterialTapTargetSize.padded,
                                            activeColor: Colors.white,
                                            activeTrackColor: HexColor(appColor),
                                            inactiveThumbColor: HexColor(appBorderColor),
                                            inactiveTrackColor: HexColor(appBorderColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(child: isDead ? InkWell(child: Container(
                  child: Icon(
                    Icons.warning,
                    size: 50,
                    color: Colors.yellow,
                  ),
                ), onTap: () {},) : Container())
              ],),
            ),
          ),
        );
      },
    );
  }

  void _refreshDeviceInfo(Device d) async {
    Device device = await BusinessService().getDeviceDetail(d.id);
    _appBloc.homeBloc.updateDevice(device);
    setState(() {
      _localDevice = device;
    });
  }

  onClickMultiDevice(bool val, Device device) {
    if (!val) {
      setState(() {
        device.properties.value = 0.toString();
      });

      BusinessService().turnOffDevice(device.id);
      BotToast.showText(text: "Tắt thiết bị thành công");
    } else {
      setState(() {
        device.properties.value = 99.toString();
      });

      BusinessService().turnOnDevice(device.id);
      BotToast.showText(text: "Bật thiết bị thành công");
    }
    _appBloc.homeBloc.updateActiveDevice();
  }

  onSwitchMultiDevice(int val, Device device) {
    //BotToast.showText(text: 'Đổi sang trạng thái ' + device.properties.value);
    setState(() {
      device.properties.value = val.toString();
    });

    if (val == 0) {
      BusinessService().setValue(device.id, val);
      BotToast.showText(text: "Tắt thiết bị thành công");
    } else {
      BusinessService().setValue(device.id, val);
      BotToast.showText(text: "Thay đổi trạng thái thành công");
    }
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
    _appBloc.homeBloc.updateActiveDevice();
  }

  onSwitchAlarmDevice(bool val, Device device) {
    if (val) {
      if (device.properties.value == 'false') {
        _switchOnAlarm(device);
      } else {
        showAlertWithTitleDialog(
            context,
            'Xác nhận', 'Cảm Biến ${device.getName} đang mở, bạn có chắc sẽ bật An Ninh không?',
            firstAction: 'CÓ',
            secondAction: 'KHÔNG',
            firstTap: () {
              Navigator.pop(context);
              _switchOnAlarm(device);
            },
            secondTap: () {
              Navigator.pop(context);
            });
      }
    } else {
      showPinCodeDialog(context, (pin) async {
        _switchOffAlarm(device, pin);
      });
    }
  }

  _switchOnAlarm(Device device) async {
    try {
      await BusinessService().turnOnAlarmDevice(device.id);
      BotToast.showText(text: "Bật an ninh thành công");
      setState(() {
        device.properties.armed = 'true';
      });
    } catch(e) {
      showAlertDialog(context, 'Xảy ra lỗi, không thể bật an ninh.');
    }
  }

  _switchOffAlarm(Device device, String pin) async {
    try {
      await BusinessService().turnOffAlarmDevice(device.id, pin);
      Navigator.pop(context);
      BotToast.showText(text: "Tắt thiết bị thành công");
      setState(() {
        device.properties.armed = 'false';
      });
    } catch(e) {
      showAlertDialog(context, 'Mã PIN không đúng');
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
    _appBloc.homeBloc.updateActiveDevice();
  }

  onSwitchSensorDevice(bool val, Device device) {
    device.properties.value = val.toString();
    //BotToast.showText(text: 'Đổi sang trạng thái ' + device.properties.value);
    setState(() {});

    if (!val) {
      BusinessService().turnOffSensor(device.id);
      BotToast.showText(text: "Tắt cảm biến thành công");
    } else {
      BusinessService().turnOnSensor(device.id);
      BotToast.showText(text: "Bật cảm biến thành công");
    }
    _appBloc.homeBloc.updateActiveDevice();
  }
}
