import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/apis/core/base_service.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/models/user.dart';
import '../loopback_config.dart';

class BusinessService extends BaseLoopBackApi {
  LoopBackAuth auth;
  BusinessService() {
    auth = new LoopBackAuth();
  }
  @override
  String getModelPath() {
    return "_";
  }

  @override
  dynamic fromJson(Map<String, Object> item) {
    return LUser.fromJson(item);
  }

  Future<List<HistoryEventModel>> fetchHistoryEventList() async {
    final result = await this.request(method: 'GET', url: '${LoopBackAuth().host}/api/panels/event?last=100&type=id');
    if (result is List) {
      return result.map((item) => HistoryEventModel.fromJson(item)).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> fetchDeviceState(int tick) async {
    String host = LoopBackAuth().host;
    if (host.startsWith('https://daikin.mcom.app')) return {};
    final result = await this.request(method: 'GET', url: '$host/api/refreshStates?last=$tick');
//    Response res = await Dio().get('$host/api/refreshStates?last=$tick', options: Options(
//        headers: {
//          'Authorization': LoopBackAuth().bearToken
//        }
//    ));
    return result;
  }

  Future<Map<String, List<DeviceIcon>>> getDeviceIcons() async {
    String host = LoopBackAuth().host;
    String token;
    // Get icons from showroom if
    if (host.startsWith('https://daikin.mcom.app')) {
      host = 'http://mhome-showroom.ddns.net';
      token = LoopBackAuth().generateBasicToken('kythuat@kimsontien.com', 'Chotronniemvui1');
    }

//    Response res = await Dio().get('$host/api/icons', options: Options(
//        headers: {
//          'Authorization': token?.isNotEmpty == true ? token : LoopBackAuth().bearToken
//        }
//    ));
    final result = await this.request(method: 'GET', url: '$host/api/icons', customToken: token);
    List<DeviceIcon> dIcons = (result['device'] as List).map((item) => DeviceIcon.fromJson(item)).toList();
    List<DeviceIcon> vIcons = (result['virtualDevice'] as List).map((item) => DeviceIcon.fromJson(item)).toList();
    return {
      'device': dIcons,
      'virtualDevice': vIcons
    };
  }

  Future<List<Room>> getRoomList() async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'rooms'
    ].join('/');

//    Response res = await Dio().get(url, options: Options(
//      headers: {
//        'Authorization': LoopBackAuth().bearToken
//      }
//    ));
    final result = await this.request(method: 'GET', url: url);
    return (result as List).map((item) => Room.fromJson(item)).toList();
  }

  Future<List<Device>> getDeviceList() async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices'
    ].join('/');

//    Response res = await Dio().get(url, options: Options(
//        headers: {
//          'Authorization': LoopBackAuth().bearToken
//        }
//    ));
    final result = await this.request(method: 'GET', url: url);
    return (result as List).map((item) => Device.fromJson(item)).toList();
  }

  Future<List<Scene>> getSceneList() async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'scenes'
    ].join('/');

//    Response res = await Dio().get(url, options: Options(
//        headers: {
//          'Authorization': LoopBackAuth().bearToken
//        }
//    ));
    final result = await this.request(method: 'GET', url: url);
    return (result as List).map((item) => Scene.fromJson(item)).toList();
  }

  Future<Device> getDeviceDetail(int id) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices',
      id
    ].join('/');
    final result = await this.request(method: 'GET', url: url);
    return Device.fromJson(result);
  }

  Future<void> callSceneAction(String id) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'scenes',
      id,
      'action/start'
    ].join('/');
    await this.request(method: 'POST', url: url);
    return;
  }

  Future<void> turnOnAlarmDevice(int id) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices',
      id,
      'action/setArmed'
    ].join('/');
    await this.request(
      method: 'POST',
      url: url,
        postBody: {
          'args': [true]
        });
    return;
  }

  Future<void> turnOffAlarmDevice(int id, String pin) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices',
      id,
      'action/setArmed'
    ].join('/');
    await this.request(
      method: 'POST',
      url: url,
      postBody: {
        'args': [false, pin]
      });
    return;
  }


  Future<void> turnOffDevice(int id) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices',
      id,
      'action/turnOff'
    ].join('/');
    await this.request(method: 'POST', url: url);
    return;
  }

  Future<void> turnOnDevice(int id) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices',
      id,
      'action/turnOn'
    ].join('/');
    await this.request(method: 'POST', url: url);
    return;
  }

  void turnOffSensor(int id) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices',
      id,
      'action/setArmed'
    ].join('/');
    await this.request(method: 'POST', url: url);
    return;
  }

  void turnOnSensor(int id) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices',
      id,
      'action/forceArm'
    ].join('/');
    await this.request(method: 'POST', url: url);
    return;
  }

  Future setRGBColor(int id, int r, int g, int b, int a) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'callAction'
    ].join('/');
    await this.request(method: 'GET', url: url, queryParams: {
      'name': 'setColor',
      'deviceID': id.toString(),
      'arg1': r.toString(),
      'arg2': g.toString(),
      'arg3': b.toString(),
      'arg4': a.toString()
    });
    return Future;
  }

  Future<void> pressButton(int deviceId, int id) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices',
      deviceId,
      'action/pressButton'
    ].join('/');
    await this.request(method: 'POST', url: url, postBody: {
      "args": [id]
    });
    return;
  }

  Future<void> setValue(int deviceId, int id) async {
    if (id > 99) id = 99;

    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      'devices',
      deviceId,
      'action/setValue'
    ].join('/');
    await this.request(method: 'POST', url: url, postBody: {
      "args": [id]
    });
    return;
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
