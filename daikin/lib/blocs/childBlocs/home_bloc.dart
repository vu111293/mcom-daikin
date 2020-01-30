import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/models/business_models.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final BusinessService _businessService = BusinessService();
  final _roomsSubject = BehaviorSubject<List<Room>>();
  final _devicesSubject = BehaviorSubject<List<Device>>();
  final _scenesSubject = BehaviorSubject<List<Scene>>();
  final _cameraDevicesSubject = BehaviorSubject<List<Device>>();

  Stream get roomDataStream => _roomsSubject.stream;
  Stream get devicesDataStream => _devicesSubject.stream;
  Stream get scenesDataStream => _scenesSubject.stream;
  Stream get cameraDevicesStream => _cameraDevicesSubject;

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
      _scenesSubject.sink.add(scenes);
      _roomsSubject.sink.add(rooms);

      // Parse camera devices
      List<Device> cameraDevices = devices.where((item) => item.getDeviceType == DeviceType.CAMERA_IP).toList();
      _cameraDevicesSubject.sink.add(cameraDevices);


      // _devicesSubject.sink.add(results[1]);
    }).catchError((e) {
      print('Fetch home data error: $e');
    });
  }

  dispose() {
    _roomsSubject.close();
    _devicesSubject.close();
    _scenesSubject.close();
    _cameraDevicesSubject.close();
  }
}
