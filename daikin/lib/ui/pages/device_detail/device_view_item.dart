import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/pages/device_detail/buid_device_item.dart';
import 'package:daikin/ui/pages/device_detail/device_on_off_detail_screen.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

class DeviceViewItem extends StatefulWidget {
  const DeviceViewItem(
      {Key key, this.device, this.animationController, this.animation})
      : super(key: key);

  final Device device;
  final AnimationController animationController;
  final Animation<dynamic> animation;

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
    // Đen BTH
    if (_localDevice.type == "com.fibaro.binarySwitch") {
      return buildSwitchDevice(widget, _localDevice, (value) {
        onSwitchDevice(value, _localDevice);
      });
      // Den Led RGB
    } else if (_localDevice.type == "com.fibaro.FGRGBW441M") {
      return buildRGBDevice(widget, _localDevice, (value) {
        onSwitchRGBDevice(value, _localDevice);
      }, () {
        _refreshDeviceInfo(_localDevice);
      });
    } else if (_localDevice.type == "virtual_device") {
      return buildVirtualDevice(widget, _localDevice);
      // Rem cua
    } else if (_localDevice.type == "com.fibaro.FGRM222") {
      return buildBlindsDevice(widget, _localDevice, isSwitched, (value) {
        print("@@@@@@@@@@@@@@@@@@@@@@@");
      });
      // Den Chum
    } else if (_localDevice.type == "com.fibaro.FGD212") {
      return buildSwitchMultiDevice(widget, _localDevice, (value) {
        onClickMultiDevice(value, _localDevice);
      }, (value) {
        onSwitchMultiDevice(value, _localDevice);
      });
    }

    return defaultBuildDevice(widget, _localDevice, isSwitched, (value) {
      print("@@@@@@@@@@@@@@@@@@@@@@@");
    });
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
      BotToast.showText(text: "Thay đổi độ sáng thành công");
    }

    // if (!val) {
    //   BusinessService().turnOffDevice(device.id);
    //   BotToast.showText(text: "Tắt thiết bị thành công");
    // } else {
    //   BusinessService().turnOnDevice(device.id);
    //   BotToast.showText(text: "Bật thiết bị thành công");
    // }
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
}
