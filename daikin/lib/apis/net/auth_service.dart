import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/apis/core/base_service.dart';
import 'package:daikin/models/user.dart';

class AuthService extends BaseLoopBackApi {
  final LoopBackAuth auth;
  bool isDirty = true;

  AuthService() : auth = new LoopBackAuth();

  @override
  String getModelPath() {
    return "auth";
  }

  String getSettingModelPath() {
    return "Account-Settings";
  }

  @override
  dynamic fromJson(Map<String, Object> item) {
    return LUser.fromJson(item);
  }

  void logout() {
    isDirty = true;
    auth.clear();
  }
}
