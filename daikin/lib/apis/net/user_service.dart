import 'dart:convert';

import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/apis/core/base_service.dart';
import 'package:daikin/apis/graphql/graphql.dart';
import 'package:daikin/models/user.dart';
import 'package:daikin/utils/cache_utils.dart';

import '../loopback_config.dart';

class UserService extends BaseLoopBackApi {
  final LoopBackAuth auth;

  UserService() : auth = new LoopBackAuth();
  @override
  String getModelPath() {
    return "user";
  }

  String getSettingModelPath() {
    return "Account-Settings";
  }

  @override
  dynamic fromJson(Map<String, Object> item) {
    return UserModel.fromJson(item);
  }

  Future<LUser> login(String fbToken) async {
    // final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), getModelPath(), 'login'].join('/');
    // final result = await this.request(method: 'POST', url: url, postBody: {'token': fbToken});

// this.auth.accessToken = ""
    
    // // cache token
    // String token = result['token'];
    // // LoopBackAuth().setAccessToken(token);
    // // LoopBackAuth().setFbToken(fbToken);
    // print('Access token: $token');

    // return LUser.fromJson(result['user']);
    final result = await graphqlAPI.login(fbToken);
    String token = (result.data as dynamic)['login']['token'];
    print('Access token: $token');

    this.auth.bearToken = fbToken;
    this.auth.accessToken = token;

    var user = LUser.fromJson((result.data as dynamic)['login']['user']);
    this.auth.userId = user.id;

    return user;
  
  }



  Future<List<UserModel>> getListUser() async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      getModelPath() + '?fields=["\$all"]',
    ].join('/');

    final result =
        await this.request(method: 'GET', url: url, isWrapBaseResponse: false);
    final jsonRows = result["results"]["objects"]["rows"] as List;

    final items = (jsonRows).map((item) {
      return UserModel.fromJson(item);
    }).toList();
    CacheUtils.saveJsonDB('user.dat', json.encode(result));
    return items;
  }

  Future<List<UserModel>> getListTelesalesWithEmail(String email) async {
    final url = [
      LoopBackConfig.getPath(),
      LoopBackConfig.getApiVersion(),
      getModelPath() +
          '?fields=["\$all"]&filter={"account_type": "TELESALE", "email": "$email"}',
    ].join('/');

    final result =
        await this.request(method: 'GET', url: url, isWrapBaseResponse: false);
    final jsonRows = result["results"]["objects"]["rows"] as List;

    final items = (jsonRows).map((item) {
      return UserModel.fromJson(item);
    }).toList();
    CacheUtils.saveJsonDB('user.dat', json.encode(result));
    return items;
  }
}
