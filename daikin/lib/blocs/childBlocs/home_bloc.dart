import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/models/business_models.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {

  final BusinessService _businessService = BusinessService();
  final _roomsSubject = BehaviorSubject<List<Room>>();
  final _devicesSubject = BehaviorSubject<List<Device>>();


  Stream get roomDataStream => _roomsSubject.stream;
  Stream get devicesDataStream => _devicesSubject.stream;

  Future fetchHomeData() {
    return Future.wait([_businessService.getRoomList(), _businessService.getDeviceList()]).then((results) {
      _roomsSubject.sink.add(results[0]);
      _devicesSubject.sink.add(results[1]);
    }).catchError((e) {
      print('Fetch home data error: $e');
    });
  }

  dispose() {
    _roomsSubject.close();
    _devicesSubject.close();
  }
}
