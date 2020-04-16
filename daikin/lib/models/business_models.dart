//"id":1,
//"name":"zwave",
//"roomID":0,
//"type":"com.fibaro.zwavePrimaryController",
//"baseType":"",
//"enabled":true,
//"visible":false,
//"isPlugin":false,
//"parentId":0,
//"remoteGatewayId":0,
//"viewXml":false,
//"configXml":false,

import 'package:daikin/apis/local/room_local_service.dart';
import 'package:daikin/constants/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_models.g.dart';

enum DeviceType { AIR_CONDITIONAL, CAMERA_IP, UNKNOWN }


@JsonSerializable(nullable: false)
class DeviceIcon {
  int id;
  String deviceType;
  String iconSetName;
  String iconName;

  DeviceIcon({this.id, this.deviceType, this.iconSetName, this.iconName});

  factory DeviceIcon.fromJson(Map<String, dynamic> json) {
    final item = _$DeviceIconFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$DeviceIconToJson(this);
}

@JsonSerializable(nullable: false)
class Device {
  final int id;
  final String name;
  final int roomID;
  final String type;
  final String baseType;
  final bool enabled;
  final bool visible;
  final bool isPlugin;
  final int parentId;
  final int remoteGatewayId;
  final bool viewXml;
  final bool configXml;
  @JsonKey(nullable: true)
  final List<String> interfaces;
  @JsonKey(toJson: _propertiesToJson)
  DeviceProperty properties;
  @JsonKey(toJson: _actionsToJson)
  final DeviceAction actions;
  final int created;
  final int modified;
  final int sortOrder;
  final String lastBreached;
  @JsonKey(nullable: true, defaultValue: [], ignore: true)
  List<Device> devices;

  @JsonKey(ignore: true)
  String iconName;

  Device(
      {this.id,
      this.name,
      this.roomID,
      this.type,
      this.baseType,
      this.enabled,
      this.visible,
      this.isPlugin,
      this.parentId,
      this.remoteGatewayId,
      this.viewXml,
      this.configXml,
      this.interfaces,
      this.properties,
      this.actions,
      this.created,
      this.modified,
      this.sortOrder,
      this.lastBreached,
      });

  factory Device.fromJson(Map<String, dynamic> json) {
    final item = _$DeviceFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  DeviceType get getDeviceType {
    if (type == 'virtual_device' && name.startsWith('AC_')) {
      return DeviceType.AIR_CONDITIONAL;
    }

    if (type == 'com.fibaro.ipCamera' && baseType == 'com.fibaro.camera') {
      return DeviceType.CAMERA_IP;
    }

    return DeviceType.UNKNOWN;
  }

  String get getDeviceIconURL {
    return getDeviceIconURLByValue(properties.value);
  }

  String getDeviceIconURLByValue(String value) {
    String prefix = '${iconName}100.png';

    print(type);
    switch(type) {
      case 'virtual_device':
        if (iconName == null) {
          return 'http://mhome-showroom.ddns.net/fibaro/n_vicons/light.png';
        }
        return 'http://mhome-showroom.ddns.net/fibaro/n_vicons/$iconName.png';

//      case 'com.fibaro.FGMS001':
      case 'com.fibaro.FGMS001v2':
//        iconName = 'motion_sensor';
//        prefix = properties.value == 'true' ? 'motion_sensor100.png' : 'motion_sensor0.png';
//        prefix = properties.value == 'true' ? '${iconName}100.png' : '${iconName}0.png';
//        break;

      case 'com.fibaro.FGSS001':
      case 'com.fibaro.doorSensor':
      case 'com.fibaro.binarySwitch':
        prefix = value == 'true' ? '${iconName}100.png' : '${iconName}0.png';
        break;

      case 'com.fibaro.sonosSpeaker':
        return 'http://mhome-showroom.ddns.net/plugins/com.fibaro.sonosSpeaker/img/xhdpi/icon.png';

      case 'com.fibaro.FGRGBW441M':
        return 'http://mhome-showroom.ddns.net/fibaro/en/img/rgb/rgb_19.png';

      case 'com.fibaro.FGKF601':
        prefix = '${iconName}-locked.png';
        break;

      case 'com.fibaro.ipCamera':
        return 'https://thanhbinhcomputer.com.vn/wp-content/uploads/2019/07/ipc-a22ep-imou-icon.png';
        break;

      case 'com.fibaro.FGD212':
        int v = (int.parse(value)*1.0/10).toInt() * 10;
        prefix = '${iconName}$v.png';
        break;

      case 'com.fibaro.FGRM222':
        int v = (int.parse(value)*1.0/10).toInt() * 10;
        prefix = '${iconName}$v.png';
        break;

      case 'com.fibaro.temperatureSensor':
      case 'com.fibaro.FGPB101':
      case 'com.fibaro.lightSensor':
        prefix = '$iconName.png';
        break;

    }

    print('http://mhome-showroom.ddns.net/fibaro/icons/$iconName/$prefix');
    return 'http://mhome-showroom.ddns.net/fibaro/icons/$iconName/$prefix';
  }
}

Map<String, dynamic> _propertiesToJson(DeviceProperty item) => item.toJson();

Map<String, dynamic> _actionsToJson(DeviceAction item) => item.toJson();

@JsonSerializable(nullable: true)
class DeviceProperty {
  String UIMessageSendTime;
  String autoConfig;
  bool configured;
  String date;
  String deviceControlType;
  dynamic deviceIcon;
  String disabled;
  String emailNotificationID;
  String emailNotificationType;
  String endPoint;
  String endPointId;
  String log;
  String logTemp;
  String manufacturer;
  String markAsDead;
  String model;
  String nodeID;
  String nodeId;

  //String parameters;
  String parametersTemplate;
  String pollingDeadDevice;
  String pollingTime;
  String pollingTimeNext;
  int pollingTimeSec;
  String productInfo;
  String pushNotificationID;
  String pushNotificationType;
  String remoteGatewayId;
  String requestNodeNeighborStat;
  String requestNodeNeighborStatTimeStemp;
  String requestNodeNeighborState;
  String requestNodeNeighborStateTimeStemp;
  String saveLogs;
  String serialNumber;
  String showChildren;
  String smsNotificationID;
  String smsNotificationType;
  String status;
  String sunriseHour;
  String sunsetHour;
  String useTemplate;
  String itemDescription;
  String value;
  String zwaveBuildVersion;
  String zwaveCompany;
  String zwaveInfo;
  String zwaveRegion;
  String zwaveVersion;
  List<DeviceRow> rows;

  String httpsEnabled;
  String ip;
  String jpgPath;
  String mjpgPath;
  String username;
  String password;
  String dead;
  String deadReason;
//  "isLight": "true",
//  "lastColorSet": "100,255,50,255",
  String isLight;
  String lastColorSet;


  // For sensor only
  String armed;

  DeviceProperty(
      {this.UIMessageSendTime,
      this.autoConfig,
      this.configured,
      this.date,
      this.deviceControlType,
      this.deviceIcon,
      this.disabled,
      this.emailNotificationID,
      this.emailNotificationType,
      this.endPoint,
      this.endPointId,
      this.log,
      this.logTemp,
      this.manufacturer,
      this.markAsDead,
      this.model,
      this.nodeID,
      this.nodeId,
      //this.parameters,
      this.parametersTemplate,
      this.pollingDeadDevice,
      this.pollingTime,
      this.pollingTimeNext,
      this.pollingTimeSec,
      this.productInfo,
      this.pushNotificationID,
      this.pushNotificationType,
      this.remoteGatewayId,
      this.requestNodeNeighborStat,
      this.requestNodeNeighborStatTimeStemp,
      this.requestNodeNeighborState,
      this.requestNodeNeighborStateTimeStemp,
      this.saveLogs,
      this.serialNumber,
      this.showChildren,
      this.smsNotificationID,
      this.smsNotificationType,
      this.status,
      this.sunriseHour,
      this.sunsetHour,
      this.useTemplate,
      this.itemDescription,
      this.value,
      this.zwaveBuildVersion,
      this.zwaveCompany,
      this.zwaveInfo,
      this.zwaveRegion,
      this.rows,
      this.zwaveVersion,
      this.httpsEnabled,
      this.ip,
      this.jpgPath,
      this.mjpgPath,
      this.username,
      this.password,
      this.isLight,
      this.lastColorSet,
      this.armed,
      this.dead,
      this.deadReason});

  factory DeviceProperty.fromJson(Map<String, dynamic> json) {
    final item = _$DevicePropertyFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$DevicePropertyToJson(this);

  bool get isSensorDevice => armed?.isNotEmpty == true;

  bool get getSensorEnable => armed?.isNotEmpty == true ? armed == 'true' : false;

  // For Camera properties
  String get getCameraUrl {
    String http = httpsEnabled == 'true' ? 'https' : 'http';
    String path = mjpgPath.isNotEmpty && mjpgPath.startsWith('/')
        ? mjpgPath.substring(1)
        : mjpgPath;
    return Uri.encodeFull('$http://$username:$password@$ip/$path');
  }

  String get getCameraThumbPreview {
    String http = httpsEnabled == 'true' ? 'https' : 'http';
    String path = jpgPath.isNotEmpty && jpgPath.startsWith('/')
        ? jpgPath.substring(1)
        : jpgPath;
    return Uri.encodeFull(
        '$http://${Uri.encodeComponent(username)}:${Uri.encodeComponent(password)}@$ip/$path');
  }

  // For RGB light

  bool get isLightDevice => isLight == 'true';

  int _getColorAtIndex(int id) {
    List<String> p = lastColorSet.split(',');
    if (p.length > id) {
      return int.parse(p[id]);
    }
    return 0;
  }

  int get getRed => _getColorAtIndex(0);
  int get getGreen => _getColorAtIndex(1);
  int get getBlue => _getColorAtIndex(2);
  int get getBrightness => _getColorAtIndex(3);

  bool get isLightOn => value != '0';
}

//"pollingDeadDevice":1,
//"pollingTimeSec":1,
//"reconfigure":0,
//"requestNodeNeighborUpdate":1,
//"turnOff":0,
//"turnOn":0
@JsonSerializable(nullable: false)
class DeviceAction {
  final int pollingDeadDevice;
  final int pollingTimeSec;
  final int reconfigure;
  final int requestNodeNeighborUpdate;
  final int turnOff;
  final int turnOn;
  final int setArmed;

  DeviceAction(
      {this.pollingDeadDevice,
      this.pollingTimeSec,
      this.reconfigure,
      this.requestNodeNeighborUpdate,
      this.turnOff,
      this.turnOn,
      this.setArmed});

  factory DeviceAction.fromJson(Map<String, dynamic> json) {
    final item = _$DeviceActionFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$DeviceActionToJson(this);
}

//{
//"id":18,
//"name":"Tiếp Tân",
//"sectionID":18,
//"icon":"room_polkabuty",
//"defaultSensors":{
//"temperature":192,
//"humidity":0,
//"light":193
//},
//"defaultThermostat":0,
//"sortOrder":2,
//"category":"other"
//},

@JsonSerializable(nullable: false)
class Room {
  final int id;
  final String name;
  final int sectionID;
  final String icon;
  final int defaultThermostat;
  final int sortOrder;
  final String category;
  @JsonKey(nullable: true)
  List<Device> devices = [];
  @JsonKey(nullable: true)
  List<Scene> scenes = [];
  @JsonKey(toJson: _defSensorToJson)
  final RoomDefaultSensor defaultSensors;

  @JsonKey(ignore: true)
  Device temperature;
  @JsonKey(ignore: true)
  Device humidity;
  @JsonKey(ignore: true)
  Device light;

  Room(
      {this.id,
      this.name,
      this.sectionID,
      this.icon,
      this.defaultThermostat,
      this.defaultSensors,
      this.sortOrder,
      List<Device> devices,
      List<Scene> scenes,
      this.category})
      : devices = devices ?? <Device>[],
        scenes = scenes ?? <Scene>[];

  factory Room.fromJson(Map<String, dynamic> json) {
    final item = _$RoomFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$RoomToJson(this);

  String get getName {
    String configName = RoomLocalService.instance.getConfig(id).name;
    return configName?.isNotEmpty == true ? configName : name;
  }

  String get getIconAssetPath {
    return RoomLocalService.instance.getConfig(id).getIconPathAsset();
  }

  String get getRoomIconURL {
    if (category == 'alarm') return 'http://mhome-showroom.ddns.net/fibaro/icons/User1008/User1008100.png';
    return 'http://mhome-showroom.ddns.net/fibaro/icons/rooms/$icon.png';
  }
}

Map<String, dynamic> _defSensorToJson(RoomDefaultSensor item) => item.toJson();

@JsonSerializable(nullable: false)
class RoomConfig {
  int roomId;
  String icon;
  String cover;
  String name;

  RoomConfig({this.roomId, this.icon, this.cover, this.name});

  factory RoomConfig.fromJson(Map<String, dynamic> json) {
    final item = _$RoomConfigFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$RoomConfigToJson(this);

  String getCoverPathAsset() {
    ImageAsset image = assetCoverList.firstWhere((item) => item.id == cover, orElse: () => null);

    if (image == null) {
      image = RoomLocalService.instance.coverAssets.firstWhere((item) => item.id == cover, orElse: () => null);
    }
    return image?.assetPath;
  }

  String getIconPathAsset() {
    return assetIconList
        .firstWhere((item) => item.id == icon, orElse: () => null)
        .assetPath;
  }
}

@JsonSerializable(nullable: false)
class RoomDefaultSensor {
  final int temperature;
  final int humidity;
  final int light;

  RoomDefaultSensor({this.temperature, this.humidity, this.light});

  factory RoomDefaultSensor.fromJson(Map<String, dynamic> json) {
    final item = _$RoomDefaultSensorFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$RoomDefaultSensorToJson(this);


  int get temperatureToC => ((temperature ?? 0 - 32)*5/9).toInt();

}

@JsonSerializable(nullable: false)
class Scene {
  final int id;
  final String name;
  final String type;
  final int roomID;
  final int iconID;

  Scene({this.name, this.id, this.type, this.roomID, this.iconID});

  factory Scene.fromJson(Map<String, dynamic> json) {
    final item = _$SceneFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$SceneToJson(this);

  String get getName {
    if (name.startsWith('M_')) return name.substring(2);
    return name;
  }
}

@JsonSerializable(nullable: true)
class DeviceRow {
  final String type;
  List<ElementDeviceRow> elements;

  DeviceRow({this.type, List<ElementDeviceRow> elements})
      : elements = elements ?? <ElementDeviceRow>[];

  factory DeviceRow.fromJson(Map<String, dynamic> json) {
    final item = _$DeviceRowFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$DeviceRowToJson(this);
}

@JsonSerializable(nullable: true)
class ElementDeviceRow {
  final String name;
  final String caption;
  final bool main;

  final int id;

  ElementDeviceRow({this.caption, this.name, this.main, this.id});

  factory ElementDeviceRow.fromJson(Map<String, dynamic> json) {
    final item = _$ElementDeviceRowFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$ElementDeviceRowToJson(this);
}

@JsonSerializable(nullable: true)
class ImageAsset {
  String id;
  String name;
  String assetPath;

  ImageAsset({this.id, this.name, this.assetPath});

  factory ImageAsset.fromJson(Map<String, dynamic> json) {
    final item = _$ImageAssetFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$ImageAssetToJson(this);
}



//{"id":1839447,"type":"DEVICE_PROPERTY_CHANGED","timestamp":1586687379,"deviceID":182,"deviceType":"com.fibaro.lightSensor","propertyName":"value","oldValue":4.0,"newValue":3.0,"icon":null}
@JsonSerializable(nullable: true)
class HistoryEventModel {
  final int id;
  final String type;
  final int timestamp;
  final int deviceID;
  final String deviceType;
  final String propertyName;
  final double oldValue;
  final double newValue;
  final dynamic icon;

  @JsonKey(ignore: true)
  Device device;
  @JsonKey(ignore: true)
  Room room;

  HistoryEventModel({
    this.id,
    this.type,
    this.timestamp,
    this.deviceID,
    this.deviceType,
    this.propertyName,
    this.oldValue,
    this.newValue,
    this.icon
  });

  factory HistoryEventModel.fromJson(Map<String, dynamic> json) {
    final item = _$HistoryEventModelFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$HistoryEventModelToJson(this);


  String get getValueInString {
    String v;
    switch(device.type) {
      case 'com.fibaro.FGMS001v2':
      case 'com.fibaro.FGSS001':
      case 'com.fibaro.doorSensor':
      case 'com.fibaro.binarySwitch':
        v = newValue == 1.0 ? 'true' : 'false';
        break;

      default:
        v = newValue.toString();
        break;
    }
    return v;
  }

  String get getOldValue {
    return _parseValue(oldValue);
  }


  String get getNewValue {
    return _parseValue(newValue);
  }


  String _parseValue(double value) {
    String v;
    switch(device.type) {
      case 'com.fibaro.doorSensor':
        v = value.toString() + '%';
        break;

      case 'com.fibaro.FGMS001v2':
      case 'com.fibaro.FGSS001':
        v = value == 0.0 ? 'Breached' : 'Safe';
        break;

      case 'com.fibaro.binarySwitch':
        v = value == 0.0 ? 'OFF' : 'ON';
        break;

      default:
        v = newValue.toString();
        break;
    }
    return v;
  }
}