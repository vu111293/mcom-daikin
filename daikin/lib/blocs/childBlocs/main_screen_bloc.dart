

import 'package:rxdart/rxdart.dart';

class MainScreenBloc {

  final _pagerNavSubject = BehaviorSubject<int>();
  bool _needToAddCenterDevice = false;

  Function(int index) get switchPageAction => _pagerNavSubject.sink.add;
  Stream<int> get requestSwitchPageEvent => _pagerNavSubject.stream;

  bool get needToShowAddCenterDevice => _needToAddCenterDevice;
  requestNeedToAddCenterDevice() {
    _needToAddCenterDevice = true;
  }

  disableAddCenterDeviceRequest() {
    _needToAddCenterDevice = false;
  }

  dispose() {
    _pagerNavSubject.close();
  }
}