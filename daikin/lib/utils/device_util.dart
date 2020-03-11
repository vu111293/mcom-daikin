


import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/models/business_models.dart';

class DeviceUtil {


  static Future<Device> turnDevice(Device d, bool isOn) async {
    if (d.type == "com.fibaro.binarySwitch") {
      d.properties.value = isOn.toString();
      if (isOn) {
        await BusinessService().turnOnDevice(d.id);
      } else {
        await BusinessService().turnOffDevice(d.id);
      }
      // Den Led RGB
    } else if (d.type == "com.fibaro.FGRGBW441M") {
      if (isOn) {
        d.properties.value = '1';
      } else {
        d.properties.value = '0';
      }
      if (isOn) {
        await BusinessService().turnOnDevice(d.id);
      } else {
        await BusinessService().turnOffDevice(d.id);
      }
    } else if (d.type == "virtual_device") {
      // Rem cua
    } else if (d.type == "com.fibaro.FGRM222") {
      // Den Chum
    } else if (d.type == "com.fibaro.FGD212") {
      int realValue;
      if (isOn) {
        realValue = 100;
      } else {
        realValue = 0;
      }
      d.properties.value = realValue.toString();
      await BusinessService().setValue(d.id, realValue);
    }

    return d;
  }

  static bool isTurnOn(Device d) {
    switch(d.type) {
      case "com.fibaro.binarySwitch":
        return d.properties.value == 'true';
        break;
      case "com.fibaro.FGRGBW441M":
        return d.properties.value == '1';
        break;

      case "virtual_device":
        break;
      case "com.fibaro.FGRM222":
        break;

      case "com.fibaro.FGD212":
        return int.parse(d.properties.value) > 0;
        break;

      default:
        break;
    }

    return true;
  }
}