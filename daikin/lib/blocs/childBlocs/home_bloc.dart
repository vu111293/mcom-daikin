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

  Stream get roomDataStream => _roomsSubject.stream;

  Stream get devicesDataStream => _devicesSubject.stream;

  Stream get scenesDataStream => _scenesSubject.stream;

  Stream get activeDeviceStream => _activeDeviceSubject.stream;

  Stream get cameraDevicesStream => _cameraDevicesSubject;

  Function(List<Scene>) get scenesAction => _scenesSubject.sink.add;

  Future fetchHomeData() {
    return Future.wait([
      _businessService.getRoomList(),
      _businessService.getDeviceList(),
      _businessService.getSceneList()
    ]).then((results) {
      List<Room> rooms = results[0];
      List<Device> devices = results[1];
      List<Scene> scenes = results[2];

      devices = devices.where((v) => v.visible).toList();
      List<Device> activeDevice =
          devices.where((v) => v.properties.value == 'true').toList();
      for (var i = 0; i < rooms.length; i++) {
        for (var j = 0; j < devices.length; j++) {
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

      // sort device in rooms
      rooms.forEach((r) {
        r.devices.sort((a, b) => b.sortOrder - a.sortOrder);
      });

      // Parse camera devices
      List<Device> cameraDevices = devices
          .where((item) => item.getDeviceType == DeviceType.CAMERA_IP)
          .toList();

      print("SINK ADD");

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
    }).catchError((e) {
      print('Fetch home data error: $e');
    });
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
  }
}
