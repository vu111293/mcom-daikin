import 'dart:async';

import 'package:daikin/blocs/childBlocs/home_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';
import 'childBlocs/auth_bloc.dart';

class ApplicationBloc implements BlocBase {

  AuthBloc _authBloc;
  HomeBloc _homeBloc;

  int countChangedMonney = 1;

  Observable<Exception> setupExceptionStream;

  final _deviceIdSubject = BehaviorSubject<String>();

  final _setupStateSubject = PublishSubject<String>();
  Stream<String> get setupStateEvent => _setupStateSubject.stream;
  Function(String) get addSetupStateAction => _setupStateSubject.sink.add;
  Function(String) get setDeviceIdAction => _deviceIdSubject.sink.add;

  AuthBloc get authBloc => _authBloc;
  HomeBloc get homeBloc => _homeBloc;

  @override
  void dispose() {
    _setupStateSubject.close();
  }

  ApplicationBloc() {
    _authBloc = AuthBloc();
    _homeBloc = HomeBloc();
  }

  String get deviceId => _deviceIdSubject.stream.value;

  fetchUserData() {
    _homeBloc.fetchHomeData().then((r) {
      print('fetch user data done');
    });
  }

  loadBaseData() {
//    // Simulator
    Future.delayed(Duration(seconds: 3), () {
      addSetupStateAction('done');
    });

//    Future.wait([
//      BusinessService().getDoctorList(),
//      BusinessService().getHospitalList(),
//      BusinessService().getTreeList(),
//    ]).then((res) {
//      List<LDoctor> doctorList = res[0].cast<LDoctor>();
//      replaceDoctorAction(doctorList);
//
//      List<LHospital> hospitalList = res[1].cast<LHospital>().map<LHospital>((item) {
//        List<LDoctor> doctors = doctorList.where((doctor) => doctor.hospital == item.id).toList();
//        return item.copyWith(doctors: doctors);
//      }).toList();
//
//      // Push center hostital to top
//      hospitalList.sort((a,b) {
//        return a.type.compareTo(b.type);
//      });
//
//      replaceHospitalAction(hospitalList);
//      replaceTreeAction(res[2]);
//      addSetupStateAction('done');
//    }).catchError((e) {
//      print(e.toString());
//      addSetupStateAction('error');
//      throw e;
//    });
  }
}
