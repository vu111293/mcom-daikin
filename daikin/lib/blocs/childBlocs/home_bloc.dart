import 'dart:async';
import 'dart:math';

import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/models/business_models.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final BusinessService _businessService = BusinessService();
  final _roomsSubject = BehaviorSubject<List<Room>>();
  final _devicesSubject = BehaviorSubject<List<Device>>();
  final _scenesSubject = BehaviorSubject<List<Scene>>();
  final _cameraDevicesSubject = BehaviorSubject<List<Device>>();
  final _activeDeviceSubject = BehaviorSubject<List<Device>>();

  Stream<List<Room>> get roomDataStream => _roomsSubject.stream;

  Stream get devicesDataStream => _devicesSubject.stream;

  Stream get scenesDataStream => _scenesSubject.stream;
  
  Stream get topSceneDataStream => _scenesSubject.stream
      .map((items) => items.where((item) => item.name.startsWith('M_'))
      .toList());

  Stream get activeDeviceStream => _activeDeviceSubject.stream;

  Stream get cameraDevicesStream => _cameraDevicesSubject;

  Function(List<Scene>) get scenesAction => _scenesSubject.sink.add;

  List<Device> get getLatestDeviceList => _devicesSubject.stream.value;
  List<Room> get getLatestRoomList => _roomsSubject.stream.value;

  Timer _timerUpdate;
  int _latestTick = 0;
  registerTickUpdate() {
    if (_timerUpdate != null && _timerUpdate.isActive) {
      _timerUpdate.cancel();
    }
    _timerUpdate = Timer.periodic(Duration(seconds: 5), (t) async {
      Map<String, dynamic> ret = await _businessService.fetchDeviceState(_latestTick);
      if (ret.containsKey('last')) {
        _latestTick = ret['last'] as int;
      }
      if (ret.containsKey('changes')) {
        try {
          List<Device> deviceList = _devicesSubject.stream.value;
          if (deviceList == null) deviceList = [];
          (ret['changes'] as List).forEach((item) {
            if (item['id'] != null && (item['value'] != null || item['armed'] != null)) {
              int id = item['id'] as int;
              Device d = deviceList.firstWhere((item) => item.id == id, orElse: () => null);
              if (d != null) {
                if (item['value'] != null) {
                  d.properties.value = item['value'] as String;
                }
                if (item['armed'] != null) {
                  d.properties.armed = item['armed'] as String;
                }
              }
            }
          });
          _devicesSubject.sink.add(deviceList);
          List<Device> activeDevice = deviceList.where((v) => v.getDeviceType != DeviceType.ALARM && v.properties.value == 'true').toList();
          _activeDeviceSubject.sink.add(activeDevice);
        } catch (e) {
          print(e);
        }
      }
    });
  }

  Future fetchHomeData({int tryTime = 3}) async {
    try {
      var results = await Future.wait([
        _businessService.getRoomList(),
        _businessService.getDeviceList(),
        _businessService.getSceneList(),
        _businessService.getDeviceIcons()]);

//      List<Room> rooms = await _businessService.getRoomList();
//      List<Device> devices = await _businessService.getDeviceList();
//      List<Scene> scenes = await _businessService.getSceneList();
//      Map<String, List<DeviceIcon>> mIcons = await _businessService.getDeviceIcons();

      List<Room> rooms = results[0];
      List<Device> devices = results[1];
      List<Scene> scenes = results[2];
      Map<String, List<DeviceIcon>> mIcons = results[3];

      devices = devices.where((item) => item.name?.startsWith('A_') == false).toList();
      rooms = rooms.where((item) => item.name?.startsWith('A_') == false).toList();
      scenes = scenes.where((item) => item.name?.startsWith('A_') == false).toList();

      // map device icon to device
      devices.forEach((d) {
        String iconId = d.properties.deviceIcon?.toString();
        DeviceIcon dIcon = (d.type == 'virtual_device' ? mIcons['virtualDevice'] : mIcons['device']).firstWhere((i) => i.id.toString() == iconId, orElse: () => null);
        d.iconName = d.type == 'virtual_device' ? dIcon?.iconName : dIcon?.iconSetName;
      });

      devices = devices.where((v) => v.visible).toList();
      List<Device> activeDevice = devices.where((v) => v.properties.value == 'true').toList();
      for (var i = 0; i < rooms.length; i++) {
        for (var j = 0; j < devices.length; j++) {
          if (devices[j].getDeviceType == DeviceType.CAMERA_IP) continue;
          if (rooms[i].id == devices[j].roomID) {
            rooms[i].devices.add(devices[j]);
          }
        }

        for (var k = 0; k < scenes.length; k++) {
          if (rooms[i].id == scenes[k].roomID) {
            rooms[i].scenes.add(scenes[k]);
          }
        }
      }

      // Not support alarm device in this time
      List<Device> sensorItems = devices.where((d) => d.getDeviceType == DeviceType.ALARM).toList();
      Room alarmRoom = Room(id: 0, name: 'Alarm', icon: 'alarm', category: 'alarm', devices: sensorItems);
      rooms.add(alarmRoom);

      // sort device in rooms
      rooms.forEach((r) {
        // map sensor device for room
        RoomDefaultSensor defSensors = r.defaultSensors;
        if (defSensors != null) {
          if (defSensors.temperature > 0) {
            r.temperature = devices.firstWhere((d) => d.id == defSensors.temperature, orElse: () => null);
          }
          if (defSensors.humidity > 0) {
            r.humidity = devices.firstWhere((d) => d.id == defSensors.humidity, orElse: () => null);
          }
          if (defSensors.light > 0) {
            r.light = devices.firstWhere((d) => d.id == defSensors.light, orElse: () => null);
          }
        }

        r.devices.sort((a, b) => b.sortOrder - a.sortOrder);
      });

      // Parse camera devices
      List<Device> cameraDevices = devices.where((item) => item.getDeviceType == DeviceType.CAMERA_IP).toList();

      cameraDevices = cameraDevices.map((c) {
        c.devices = devices.where((item) => item.roomID == c.roomID).toList();

        return c;
      }).toList();

      _scenesSubject.sink.add(scenes);
      _roomsSubject.sink.add(rooms);
      _cameraDevicesSubject.sink.add(cameraDevices);
      _activeDeviceSubject.sink.add(activeDevice);
      _devicesSubject.sink.add(devices);
      // _devicesSubject.sink.add(results[1]);
      return Future;
    } catch (e) {
      return _handleErrorExp(e: e, tryTime: tryTime);
    }
  }

  _handleErrorExp({e, int tryTime}) async {
    print('Fetch home data error: $e');
    if (tryTime > 0) {
      await Future.delayed(Duration(seconds: 2));
      return fetchHomeData(tryTime: tryTime - 1);
    } else {
      throw e;
    }
  }

  updateActiveDevice() {
    List<Device> devices = _devicesSubject.stream.value;
    List<Device> activeDevice =
        devices.where((v) => v.properties.value == 'true').toList();
    _activeDeviceSubject.sink.add(activeDevice);
  }

  Room randomRoom() {
    List<Room> currentRooms = _roomsSubject.stream.value;
    return currentRooms[randRange(0, currentRooms.length)];
  }

  int randRange(int min, int max) {
    var random = new Random();
    return min + random.nextInt(max - min);
  }

  updateDevice(Device d) {
    List<Room> currentRooms = _roomsSubject.stream.value;
    Room room =
        currentRooms.firstWhere((r) => r.id == d.roomID, orElse: () => null);
    if (room != null) {
      Device device = room.devices
          .firstWhere((item) => item.id == d.id, orElse: () => null);
      if (device != null) {
        room.devices.remove(device);
        room.devices.add(d);
        room.devices.sort((a, b) => b.sortOrder - a.sortOrder);
      }
    }
    _roomsSubject.sink.add(currentRooms);
  }

  dispose() {
    _roomsSubject.close();
    _devicesSubject.close();
    _scenesSubject.close();
    _cameraDevicesSubject.close();
    _activeDeviceSubject.close();
  }
}
