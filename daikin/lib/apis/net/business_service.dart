import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/apis/core/base_service.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/models/user.dart';

import '../loopback_config.dart';

class BusinessService extends BaseLoopBackApi {
  final LoopBackAuth auth;

  BusinessService() : auth = new LoopBackAuth();
  @override
  String getModelPath() {
    return "_";
  }

  @override
  dynamic fromJson(Map<String, Object> item) {
    return LUser.fromJson(item);
  }

  Future<List<Room>> getRoomList() async {
    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'rooms'].join('/');
    final result = await this.request(method: 'GET', url: url);
    return (result as List).map((item) => Room.fromJson(item)).toList();
  }

  Future<List<Device>> getDeviceList() async {
    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'devices'].join('/');
    final result = await this.request(method: 'GET', url: url);
    return (result as List).map((item) => Device.fromJson(item)).toList();
  }


//
//  Future<List<LTree>> getTreeList() async {
//    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'plant?limit=0'].join('/');
//    final result = await this.request(method: 'GET', url: url);
//    return (result as List).map((item) => LTree.fromJson(item)).toList();
//  }
//
//  Future<List<LHospital>> getHospitalList() async {
//    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'hospital?limit=0'].join('/');
//    final result = await this.request(method: 'GET', url: url);
//    result.sort((a, b) {
//      return b.toString().compareTo(a.toString());
//    });
//    return (result as List).map((item) => LHospital.fromJson(item)).toList();
//  }
//
//  Future<List<LDoctor>> getDoctorList() async {
//    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'user/doctor?limit=0'].join('/');
//    final result = await this.request(method: 'GET', url: url);
//    return (result as List).map((item) => LDoctor.fromJson(item)).toList();
//  }
//
//  Future<List<LQuestionResponse>> getMyQuestionList(String myId) async {
//    final url =
//        [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'issue?filter={"owner":"$myId"}&limit=0'].join('/');
//    final result = await this.request(method: 'GET', url: url);
//    return (result as List).map((item) => LQuestionResponse.fromJson(item)).toList();
//  }
//
//  Future<List<LQuestionResponse>> getPopularQuestionList() async {
//    final url = [
//      LoopBackConfig.getPath(),
//      LoopBackConfig.getApiVersion(),
//      'issue?order={"updatedAt": -1, "view": -1, "qtyRate": -1, "qtyComment": -1}&limit=0'
//    ].join('/');
//    final result = await this.request(method: 'GET', url: url);
//    return (result as List).map((item) => LQuestionResponse.fromJson(item)).toList();
//  }
//
//  Future<LQuestionResponse> sendQuestion(LQuestionRequest request) async {
//    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'issue'].join('/');
//    final result = await this.request(method: 'POST', url: url, postBody: request.toJson());
//    return LQuestionResponse.fromJson(result);
//  }
//
//  Future<LQuestionResponse> updateQuestion(String id, LQuestionRequest request) async {
//    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'issue', id].join('/');
//    final result = await this.request(method: 'PUT', url: url, postBody: request.toJson());
//    return LQuestionResponse.fromJson(result);
//  }
//
//  Future deleteQuestion(String id) async {
//    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'issue', id].join('/');
//    await this.request(method: 'DELETE', url: url);
//  }
}
