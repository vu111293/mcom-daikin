import 'dart:async';

import 'package:daikin/models/user.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';
import 'childBlocs/auth_bloc.dart';

class ApplicationBloc implements BlocBase {
  AuthBloc _authBloc;
  int countChangedMonney = 1;

  Observable<Exception> setupExceptionStream;

  final _setupStateSubject = PublishSubject<String>();
  Stream<String> get setupStateEvent => _setupStateSubject.stream;
  Function(String) get addSetupStateAction => _setupStateSubject.sink.add;

  AuthBloc get authBloc => _authBloc;


  @override
  void dispose() {
    _setupStateSubject.close();
  }

  ApplicationBloc() {
    _authBloc = new AuthBloc();
  }


  bool get isDoctor => _authBloc?.getUser?.type == 'doctor';
  LUser get getProfile => _authBloc?.getUser;


  loadBaseData() {

    // Simulator
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
