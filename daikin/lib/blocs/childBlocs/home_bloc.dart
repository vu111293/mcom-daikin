import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/models/business_models.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final BusinessService _businessService = BusinessService();
  final _roomsSubject = BehaviorSubject<List<Room>>();
  final _devicesSubject = BehaviorSubject<List<Device>>();
  final _scenesSubject = BehaviorSubject<List<Scene>>();

  Stream get roomDataStream => _roomsSubject.stream;
  Stream get devicesDataStream => _devicesSubject.stream;
  Stream get scenesDataStream => _scenesSubject.stream;

  Future fetchHomeData() {
    return Future.wait([
      _businessService.getRoomList(),
      _businessService.getDeviceList(),
      _businessService.getSceneList()
    ]).then((results) {
      List<Room> rooms = results[0];
      List<Device> devices = results[1];

      for (var i = 0; i < rooms.length; i++) {
        for (var j = 0; j < devices.length; j++) {
          if (rooms[i].id == devices[j].roomID) {
            rooms[i].devices.add(devices[j]);
          }
        }
      }
      _scenesSubject.sink.add(results[2]);
      _roomsSubject.sink.add(rooms);
      // _devicesSubject.sink.add(results[1]);
    }).catchError((e) {
      print('Fetch home data error: $e');
    });
  }

  dispose() {
    _roomsSubject.close();
    _devicesSubject.close();
    _scenesSubject.close();
  }
}
