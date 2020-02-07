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
    final result = await graphqlAPI.login(fbToken);
    String token = (result.data as dynamic)['login']['token'];
    print('Access token: $token');

    this.auth.fbToken = fbToken;
    this.auth.accessToken = token;
    this.auth.bearToken =
        'Basic a3l0aHVhdEBraW1zb250aWVuLmNvbTpDaG90cm9ubmllbXZ1aTE=';

    var user = LUser.fromJson((result.data as dynamic)['login']['user']);
    this.auth.userId = user.id;

    return user;
  }

  Future<LUser> me() async {
    print('Call API me');
    print(LoopBackAuth().accessToken);
    final result = await graphqlAPI.me();
    print(jsonEncode((result.data as dynamic)['me']));
    var user = LUser.fromJson((result.data as dynamic)['me']);
    return user;
  }

  Future<LUser> updateUser(
      String _id, String fullName, String email, String avatar) async {
    try {
      final result = await graphqlAPI.updateUser(_id, fullName, email, avatar);
      var user = LUser.fromJson((result.data as dynamic)['updateUser']);
      return user;
    } catch (err) {
      print(err);
      throw err;
    }
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
