import 'dart:async';

import 'package:daikin/apis/local/room_local_service.dart';
import 'package:daikin/blocs/childBlocs/center_bloc.dart';
import 'package:daikin/blocs/childBlocs/home_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';
import 'childBlocs/auth_bloc.dart';

class ApplicationBloc implements BlocBase {
  AuthBloc _authBloc;
  HomeBloc _homeBloc;
  CenterBloc _centerBloc;

  int countChangedMonney = 1;

  ValueStream<Exception> setupExceptionStream;

  final _deviceIdSubject = BehaviorSubject<String>();

  final _setupStateSubject = PublishSubject<String>();
  Stream<String> get setupStateEvent => _setupStateSubject.stream;
  Function(String) get addSetupStateAction => _setupStateSubject.sink.add;
  Function(String) get setDeviceIdAction => _deviceIdSubject.sink.add;

  AuthBloc get authBloc => _authBloc;
  HomeBloc get homeBloc => _homeBloc;
  CenterBloc get centerBloc => _centerBloc;

  @override
  void dispose() {
    _setupStateSubject.close();
    _deviceIdSubject.close();

  }

  ApplicationBloc() {
    _authBloc = AuthBloc();
    _homeBloc = HomeBloc();
    _centerBloc = CenterBloc();

    // Load local setting here
    RoomLocalService.instance.loadConfig();
  }

  String get deviceId => _deviceIdSubject.stream.value;

  Future setCurrentCenter(dynamic data) async {
    await _centerBloc.setCurrentCenter(data);
    await this.fetchUserData();
    return Future;
  }

  Future fetchUserData() async {
    await _homeBloc.fetchHomeData();
    _homeBloc.registerTickUpdate();
    return Future;
  }

  loadBaseData() {
    Future.delayed(Duration(seconds: 3), () {
      addSetupStateAction('done');
    });
  }
}
