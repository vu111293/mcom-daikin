import 'package:daikin/models/business_models.dart';
import 'package:flutter/material.dart';

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
