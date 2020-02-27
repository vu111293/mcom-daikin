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

enum DeviceType { CAMERA_IP, UNKNOWN }

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
  @JsonKey(nullable: true, defaultValue: [], ignore: true)
  List<Device> devices;

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
      this.sortOrder});

  factory Device.fromJson(Map<String, dynamic> json) {
    final item = _$DeviceFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  DeviceType get getDeviceType {
    if (type == 'com.fibaro.ipCamera' && baseType == 'com.fibaro.camera') {
      return DeviceType.CAMERA_IP;
    }

    return DeviceType.UNKNOWN;
  }
}

Map<String, dynamic> _propertiesToJson(DeviceProperty item) => item.toJson();

Map<String, dynamic> _actionsToJson(DeviceAction item) => item.toJson();

@JsonSerializable(nullable: true)
class DeviceProperty {
  final String UIMessageSendTime;
  final String autoConfig;
  final bool configured;
  final String date;
  final String dead;
  final String deviceControlType;
  final dynamic deviceIcon;
  final String disabled;
  final String emailNotificationID;
  final String emailNotificationType;
  final String endPoint;
  final String endPointId;
  final String log;
  final String logTemp;
  final String manufacturer;
  final String markAsDead;
  final String model;
  final String nodeID;
  final String nodeId;

  //final String parameters;
  final String parametersTemplate;
  final String pollingDeadDevice;
  final String pollingTime;
  final String pollingTimeNext;
  final int pollingTimeSec;
  final String productInfo;
  final String pushNotificationID;
  final String pushNotificationType;
  final String remoteGatewayId;
  final String requestNodeNeighborStat;
  final String requestNodeNeighborStatTimeStemp;
  final String requestNodeNeighborState;
  final String requestNodeNeighborStateTimeStemp;
  final String saveLogs;
  final String serialNumber;
  final String showChildren;
  final String smsNotificationID;
  final String smsNotificationType;
  final String status;
  final String sunriseHour;
  final String sunsetHour;
  final String useTemplate;
  final String itemDescription;
  String value;
  final String zwaveBuildVersion;
  final String zwaveCompany;
  final String zwaveInfo;
  final String zwaveRegion;
  final String zwaveVersion;
  List<DeviceRow> rows;

  final String httpsEnabled;
  final String ip;
  final String jpgPath;
  final String mjpgPath;
  final String username;
  final String password;
//  "isLight": "true",
//  "lastColorSet": "100,255,50,255",
  final String isLight;
  final String lastColorSet;

  DeviceProperty(
      {this.UIMessageSendTime,
      this.autoConfig,
      this.configured,
      this.date,
      this.dead,
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
      List<DeviceRow> rows,
      this.zwaveVersion,
      this.httpsEnabled,
      this.ip,
      this.jpgPath,
      this.mjpgPath,
      this.username,
      this.password,
      this.isLight,
      this.lastColorSet})
      : rows = rows ?? <DeviceRow>[];

  factory DeviceProperty.fromJson(Map<String, dynamic> json) {
    final item = _$DevicePropertyFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$DevicePropertyToJson(this);

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
    return Uri.encodeFull('$http://${Uri.encodeComponent(username)}:${Uri.encodeComponent(password)}@$ip/$path');
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

  DeviceAction(
      {this.pollingDeadDevice,
      this.pollingTimeSec,
      this.reconfigure,
      this.requestNodeNeighborUpdate,
      this.turnOff,
      this.turnOn});

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
    return assetCoverList.firstWhere((item) => item.id == cover, orElse: () => null).assetPath;
  }

  String getIconPathAsset() {
    return assetIconList.firstWhere((item) => item.id == icon, orElse: () => null).assetPath;
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
  final int id;

  ElementDeviceRow({this.caption, this.name, this.id});

  factory ElementDeviceRow.fromJson(Map<String, dynamic> json) {
    final item = _$ElementDeviceRowFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$ElementDeviceRowToJson(this);
}

class ImageAsset {
  String id;
  String name;
  String assetPath;

  ImageAsset({this.id, this.name, this.assetPath});
}
