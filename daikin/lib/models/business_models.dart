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

import 'package:json_annotation/json_annotation.dart';

part 'business_models.g.dart';

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
  final DeviceProperty properties;
  @JsonKey(toJson: _actionsToJson)
  final DeviceAction actions;
  final int created;
  final int modified;
  final int sortOrder;

  Device({this.id, this.name, this.roomID, this.type, this.baseType, this.enabled, this.visible, this.isPlugin, this.parentId, this.remoteGatewayId, this.viewXml, this.configXml, this.interfaces, this.properties, this.actions, this.created, this.modified, this.sortOrder});

  factory Device.fromJson(Map<String, dynamic> json) {
    final item = _$DeviceFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

Map<String, dynamic> _propertiesToJson(DeviceProperty item) => item.toJson();

Map<String, dynamic> _actionsToJson(DeviceAction item) => item.toJson();

@JsonSerializable(nullable: false)
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
  final String value;
  final String zwaveBuildVersion;
  final String zwaveCompany;
  final String zwaveInfo;
  final String zwaveRegion;
  final String zwaveVersion;

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
      this.zwaveVersion});

  factory DeviceProperty.fromJson(Map<String, dynamic> json) {
    final item = _$DevicePropertyFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$DevicePropertyToJson(this);
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

  DeviceAction({this.pollingDeadDevice, this.pollingTimeSec, this.reconfigure, this.requestNodeNeighborUpdate, this.turnOff, this.turnOn});

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
  @JsonKey(toJson: _defSensorToJson)
  final RoomDefaultSensor defaultSensors;

  Room({this.id, this.name, this.sectionID, this.icon, this.defaultThermostat, this.defaultSensors, this.sortOrder, this.category});

  factory Room.fromJson(Map<String, dynamic> json) {
    final item = _$RoomFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}

Map<String, dynamic> _defSensorToJson(RoomDefaultSensor item) => item.toJson();

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

  Scene({this.name, this.id, this.type});

  factory Scene.fromJson(Map<String, dynamic> json) {
    final item = _$SceneFromJson(json);
    return item;
  }

  Map<String, dynamic> toJson() => _$SceneToJson(this);
}