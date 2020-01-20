// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    id: json['id'] as int,
    name: json['name'] as String,
    roomID: json['roomID'] as int,
    type: json['type'] as String,
    baseType: json['baseType'] as String,
    enabled: json['enabled'] as bool,
    visible: json['visible'] as bool,
    isPlugin: json['isPlugin'] as bool,
    parentId: json['parentId'] as int,
    remoteGatewayId: json['remoteGatewayId'] as int,
    viewXml: json['viewXml'] as bool,
    configXml: json['configXml'] as bool,
    interfaces: (json['interfaces'] as List)?.map((e) => e as String)?.toList(),
    properties:
        DeviceProperty.fromJson(json['properties'] as Map<String, dynamic>),
    actions: DeviceAction.fromJson(json['actions'] as Map<String, dynamic>),
    created: json['created'] as int,
    modified: json['modified'] as int,
    sortOrder: json['sortOrder'] as int,
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'roomID': instance.roomID,
      'type': instance.type,
      'baseType': instance.baseType,
      'enabled': instance.enabled,
      'visible': instance.visible,
      'isPlugin': instance.isPlugin,
      'parentId': instance.parentId,
      'remoteGatewayId': instance.remoteGatewayId,
      'viewXml': instance.viewXml,
      'configXml': instance.configXml,
      'interfaces': instance.interfaces,
      'properties': _propertiesToJson(instance.properties),
      'actions': _actionsToJson(instance.actions),
      'created': instance.created,
      'modified': instance.modified,
      'sortOrder': instance.sortOrder,
    };

DeviceProperty _$DevicePropertyFromJson(Map<String, dynamic> json) {
  return DeviceProperty(
    UIMessageSendTime: json['UIMessageSendTime'] as String,
    autoConfig: json['autoConfig'] as String,
    configured: json['configured'] as bool,
    date: json['date'] as String,
    dead: json['dead'] as String,
    deviceControlType: json['deviceControlType'] as String,
    deviceIcon: json['deviceIcon'],
    disabled: json['disabled'] as String,
    emailNotificationID: json['emailNotificationID'] as String,
    emailNotificationType: json['emailNotificationType'] as String,
    endPoint: json['endPoint'] as String,
    endPointId: json['endPointId'] as String,
    log: json['log'] as String,
    logTemp: json['logTemp'] as String,
    manufacturer: json['manufacturer'] as String,
    markAsDead: json['markAsDead'] as String,
    model: json['model'] as String,
    nodeID: json['nodeID'] as String,
    nodeId: json['nodeId'] as String,
    parametersTemplate: json['parametersTemplate'] as String,
    pollingDeadDevice: json['pollingDeadDevice'] as String,
    pollingTime: json['pollingTime'] as String,
    pollingTimeNext: json['pollingTimeNext'] as String,
    pollingTimeSec: json['pollingTimeSec'] as int,
    productInfo: json['productInfo'] as String,
    pushNotificationID: json['pushNotificationID'] as String,
    pushNotificationType: json['pushNotificationType'] as String,
    remoteGatewayId: json['remoteGatewayId'] as String,
    requestNodeNeighborStat: json['requestNodeNeighborStat'] as String,
    requestNodeNeighborStatTimeStemp:
        json['requestNodeNeighborStatTimeStemp'] as String,
    requestNodeNeighborState: json['requestNodeNeighborState'] as String,
    requestNodeNeighborStateTimeStemp:
        json['requestNodeNeighborStateTimeStemp'] as String,
    saveLogs: json['saveLogs'] as String,
    serialNumber: json['serialNumber'] as String,
    showChildren: json['showChildren'] as String,
    smsNotificationID: json['smsNotificationID'] as String,
    smsNotificationType: json['smsNotificationType'] as String,
    status: json['status'] as String,
    sunriseHour: json['sunriseHour'] as String,
    sunsetHour: json['sunsetHour'] as String,
    useTemplate: json['useTemplate'] as String,
    itemDescription: json['itemDescription'] as String,
    value: json['value'] as String,
    zwaveBuildVersion: json['zwaveBuildVersion'] as String,
    zwaveCompany: json['zwaveCompany'] as String,
    zwaveInfo: json['zwaveInfo'] as String,
    zwaveRegion: json['zwaveRegion'] as String,
    rows: (json['rows'] as List)
        ?.map((e) =>
            e == null ? null : DeviceRow.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    zwaveVersion: json['zwaveVersion'] as String,
  );
}

Map<String, dynamic> _$DevicePropertyToJson(DeviceProperty instance) =>
    <String, dynamic>{
      'UIMessageSendTime': instance.UIMessageSendTime,
      'autoConfig': instance.autoConfig,
      'configured': instance.configured,
      'date': instance.date,
      'dead': instance.dead,
      'deviceControlType': instance.deviceControlType,
      'deviceIcon': instance.deviceIcon,
      'disabled': instance.disabled,
      'emailNotificationID': instance.emailNotificationID,
      'emailNotificationType': instance.emailNotificationType,
      'endPoint': instance.endPoint,
      'endPointId': instance.endPointId,
      'log': instance.log,
      'logTemp': instance.logTemp,
      'manufacturer': instance.manufacturer,
      'markAsDead': instance.markAsDead,
      'model': instance.model,
      'nodeID': instance.nodeID,
      'nodeId': instance.nodeId,
      'parametersTemplate': instance.parametersTemplate,
      'pollingDeadDevice': instance.pollingDeadDevice,
      'pollingTime': instance.pollingTime,
      'pollingTimeNext': instance.pollingTimeNext,
      'pollingTimeSec': instance.pollingTimeSec,
      'productInfo': instance.productInfo,
      'pushNotificationID': instance.pushNotificationID,
      'pushNotificationType': instance.pushNotificationType,
      'remoteGatewayId': instance.remoteGatewayId,
      'requestNodeNeighborStat': instance.requestNodeNeighborStat,
      'requestNodeNeighborStatTimeStemp':
          instance.requestNodeNeighborStatTimeStemp,
      'requestNodeNeighborState': instance.requestNodeNeighborState,
      'requestNodeNeighborStateTimeStemp':
          instance.requestNodeNeighborStateTimeStemp,
      'saveLogs': instance.saveLogs,
      'serialNumber': instance.serialNumber,
      'showChildren': instance.showChildren,
      'smsNotificationID': instance.smsNotificationID,
      'smsNotificationType': instance.smsNotificationType,
      'status': instance.status,
      'sunriseHour': instance.sunriseHour,
      'sunsetHour': instance.sunsetHour,
      'useTemplate': instance.useTemplate,
      'itemDescription': instance.itemDescription,
      'value': instance.value,
      'zwaveBuildVersion': instance.zwaveBuildVersion,
      'zwaveCompany': instance.zwaveCompany,
      'zwaveInfo': instance.zwaveInfo,
      'zwaveRegion': instance.zwaveRegion,
      'zwaveVersion': instance.zwaveVersion,
      'rows': instance.rows,
    };

DeviceAction _$DeviceActionFromJson(Map<String, dynamic> json) {
  return DeviceAction(
    pollingDeadDevice: json['pollingDeadDevice'] as int,
    pollingTimeSec: json['pollingTimeSec'] as int,
    reconfigure: json['reconfigure'] as int,
    requestNodeNeighborUpdate: json['requestNodeNeighborUpdate'] as int,
    turnOff: json['turnOff'] as int,
    turnOn: json['turnOn'] as int,
  );
}

Map<String, dynamic> _$DeviceActionToJson(DeviceAction instance) =>
    <String, dynamic>{
      'pollingDeadDevice': instance.pollingDeadDevice,
      'pollingTimeSec': instance.pollingTimeSec,
      'reconfigure': instance.reconfigure,
      'requestNodeNeighborUpdate': instance.requestNodeNeighborUpdate,
      'turnOff': instance.turnOff,
      'turnOn': instance.turnOn,
    };

Room _$RoomFromJson(Map<String, dynamic> json) {
  return Room(
    id: json['id'] as int,
    name: json['name'] as String,
    sectionID: json['sectionID'] as int,
    icon: json['icon'] as String,
    defaultThermostat: json['defaultThermostat'] as int,
    defaultSensors: RoomDefaultSensor.fromJson(
        json['defaultSensors'] as Map<String, dynamic>),
    sortOrder: json['sortOrder'] as int,
    devices: (json['devices'] as List)
        ?.map((e) =>
            e == null ? null : Device.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    scenes: (json['scenes'] as List)
        ?.map(
            (e) => e == null ? null : Scene.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    category: json['category'] as String,
  );
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sectionID': instance.sectionID,
      'icon': instance.icon,
      'defaultThermostat': instance.defaultThermostat,
      'sortOrder': instance.sortOrder,
      'category': instance.category,
      'devices': instance.devices,
      'scenes': instance.scenes,
      'defaultSensors': _defSensorToJson(instance.defaultSensors),
    };

RoomDefaultSensor _$RoomDefaultSensorFromJson(Map<String, dynamic> json) {
  return RoomDefaultSensor(
    temperature: json['temperature'] as int,
    humidity: json['humidity'] as int,
    light: json['light'] as int,
  );
}

Map<String, dynamic> _$RoomDefaultSensorToJson(RoomDefaultSensor instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'light': instance.light,
    };

Scene _$SceneFromJson(Map<String, dynamic> json) {
  return Scene(
    name: json['name'] as String,
    id: json['id'] as int,
    type: json['type'] as String,
    roomID: json['roomID'] as int,
    iconID: json['iconID'] as int,
  );
}

Map<String, dynamic> _$SceneToJson(Scene instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'roomID': instance.roomID,
      'iconID': instance.iconID,
    };

DeviceRow _$DeviceRowFromJson(Map<String, dynamic> json) {
  return DeviceRow(
    type: json['type'] as String,
    elements: (json['elements'] as List)
        ?.map((e) => e == null
            ? null
            : ElementDeviceRow.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DeviceRowToJson(DeviceRow instance) => <String, dynamic>{
      'type': instance.type,
      'elements': instance.elements,
    };

ElementDeviceRow _$ElementDeviceRowFromJson(Map<String, dynamic> json) {
  return ElementDeviceRow(
    caption: json['caption'] as String,
    name: json['name'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$ElementDeviceRowToJson(ElementDeviceRow instance) =>
    <String, dynamic>{
      'name': instance.name,
      'caption': instance.caption,
      'id': instance.id,
    };
