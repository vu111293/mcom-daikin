import 'dart:convert';

import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/apis/net/auth_service.dart';
import 'package:daikin/blocs/childBlocs/home_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CenterBloc {
  LoopBackAuth _loopBackAuth;
  BehaviorSubject<List<dynamic>> _centerSubject = new BehaviorSubject();
  BehaviorSubject<dynamic> currentCenterSubject = new BehaviorSubject();

  Stream get centerDataStream => _centerSubject.stream;
  HomeBloc _homeBloc;
  CenterBloc() {
    _loopBackAuth = LoopBackAuth();
    _homeBloc = HomeBloc();
  }

  dynamic currentCenter;

  setCenter(dynamic data) async {
    List<dynamic> result = await _loopBackAuth.getCenter("center");
    data["id"] = (result.length + 1).toString();
    result.add(data);
    _loopBackAuth.setCenter("center", jsonEncode(result));
    this.getCenter();
  }

  setCurrentCenter(dynamic data) async {
    _loopBackAuth.setCurrentCenter(data);
  }

  getCurrentCenter() async {
    dynamic result = await _loopBackAuth.getCurrentCenter();
    return result;
  }

  getCenter() async {
    print("GetCenter");
    List<dynamic> result = await _loopBackAuth.getCenter("center");
    _centerSubject.sink.add(result);
    return result;
  }

  removeCenter(String id) async {
    List<dynamic> result = await _loopBackAuth.getCenter("center");
    int index = -1;
    for (int i = 0; i < result.length; i++) {
      if (result[i]["id"] == id) {
        index = i;
        break;
      }
    }
    result.removeAt(index);
    _loopBackAuth.setCenter("center", jsonEncode(result));
    this.getCenter();
  }

  updateCenter(String id, dynamic data) async {
    List<dynamic> result = await _loopBackAuth.getCenter("center");
    for (int i = 0; i < result.length; i++) {
      if (result[i]["id"] == id) {
        result[i] = data;
        break;
      }
    }
    _loopBackAuth.setCenter("center", jsonEncode(result));
    this.getCenter();
  }
}
