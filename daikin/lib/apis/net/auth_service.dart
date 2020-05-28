import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/apis/core/base_service.dart';
import 'package:daikin/models/base_model.dart';
import 'package:daikin/models/user.dart';

import '../loopback_config.dart';

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

  Future<String> getAccessToken() async {
//    if (isDirty || auth.accessToken() == null || auth.accessToken().id == null || auth.accessToken().id.isEmpty) {
//      await auth.loadAccessToken();
//      isDirty = false;
//    }

      if (auth.accessToken == null) {
        await auth.loadAccessToken();
      }

    return auth.accessToken;
  }

  Future updateUserData(AccessToken accessToken, String id) async {
//    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'user', id + '?fields=["\$all"]'].join('/');
//    final result = await this.request(method: 'GET', url: url, isWrapBaseResponse: false, isUsingAdminToken: true);
//    accessToken.user = UserModel.fromJson(result["results"]["object"]);
//    accessToken.userId = result["results"]["object"]["id"];
//    print("phat updateUserData + setAccessToken");
//    return auth.setAccessToken(accessToken, true);

    return null;
  }

  Future<bool> uploadUserInformationToServer(UserModel userModel) async {
    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'user', userModel.id].join('/');
    print('bambi user model before post to server: ${userModel.toJson()}');

    try {
      final result = await this.request(
          method: 'PUT', url: url, postBody: userModel.toJson(), isWrapBaseResponse: false, isUsingAdminToken: true);
      print("bambi log thu result server tra ve la gi: ${result}");
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

//  Future<UserModel> loginWithFacebookAccounntKit(String fbToken) async {
//    final url = [
//      LoopBackConfig.getPath(),
//      LoopBackConfig.getApiVersion(),
//      getModelPath(),
//      'login_with_facebook_account_kit'
//    ].join('/');
//    final result = await this.request(
//        method: 'POST', url: url, postBody: {"token": fbToken, "account_type": "TELESALE"}, isWrapBaseResponse: false);
//
//    print("bambi log thu result server tra ve la gi: ${result}");
//
//    var userModel = UserModel.fromJson(result["results"]["object"]);
//    print("bambi parse dc user roi ne: ${userModel}");
//    AccessToken token = new AccessToken(
//        id: result["results"]["token"],
//        userId: result["results"]["object"]["id"],
//        user: userModel,
//        rememberMe: true,
//        created: DateTime.now());
////    auth.setAccessToken(token, true);
//    return token.user;
//  }

  Future<LUser> loginWithEmailAndPassword(String email, String password) async {
    String passwordMD5 = md5.convert(utf8.encode(password)).toString();
    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), getModelPath(), 'login'].join('/');
    final result = await this.request(
        method: 'POST',
        url: url,
        postBody: {"email": email, "password": passwordMD5, "account_type": "TELESALE"},
        isWrapBaseResponse: false);

    print('bambi log ra result cua api login with email: ${result}');
    var userModel = UserModel.fromJson(result["results"]["object"]["result"]);
    print("bambi parse dc user roi ne: ${userModel}");
    AccessToken token = new AccessToken(
        id: result["results"]["object"]["token"],
        userId: result["results"]["object"]["result"]["id"],
        rememberMe: true,
        created: DateTime.now());
//    auth.setAccessToken(token, true);
    return null;
  }

  Future<UserModel> registerWithEmailAndPassword(String email, String password) async {
    String passwordMD5 = md5.convert(utf8.encode(password)).toString();
    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), getModelPath(), 'register'].join('/');
    print('url of api register by email & password: ${url}');
    final result = await this.request(
        method: 'POST',
        url: url,
        postBody: {"email": email, "password": passwordMD5, "account_type": "TELESALE"},
        isWrapBaseResponse: false);
    print("Result: " + result.toString());
    if (result["code"] == 200) {
//      var userModel = UserModel.fromJson(result["results"]["object"]);
//      AccessToken token =
//          new AccessToken(userId: userModel.id, user: userModel, rememberMe: false, created: DateTime.now());
//      auth.setAccessToken(token, true);
//      return token.user;
    } else {
      return null;
    }
  }

  Future<bool> forgetPassword(String email) async {
    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), getModelPath(), 'forget_password'].join('/');
    print('url of api register by email & password: ${url}');
    final result = await this.request(
        method: 'POST', url: url, postBody: {"email": email, "account_type": "TELESALE"}, isWrapBaseResponse: false);
    if (result["code"] == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future updateSettingUser(String id, Map<String, dynamic> body) async {
    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'user', id].join('/');
    // Map<String, dynamic>
    final result = await this.request(method: 'PUT', url: url, postBody: body, isWrapBaseResponse: false);
    // print("updateSettingUser done" + result["results"]["object"]["allowNotification"].toString());
    return UserModel.fromJson(result["results"]["object"]);
  }

  Future<bool> changePassword(String oldPassword, newPassword) async {
    String oldPasswordMD5 = md5.convert(utf8.encode(oldPassword)).toString();
    String newPasswordMD5 = md5.convert(utf8.encode(newPassword)).toString();
    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), 'user', 'change_password/'].join('/');
    try {
      final response = await this.request(
          method: 'PUT',
          url: url,
          postBody: {
            "oldPassword": oldPasswordMD5,
            "newPassword": newPasswordMD5,
          },
          isWrapBaseResponse: false);
      print(response.toString());
      if (response["code"] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
