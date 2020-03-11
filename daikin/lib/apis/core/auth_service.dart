import 'dart:async';
import 'dart:convert';

import 'package:daikin/blocs/childBlocs/center_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AccessStatus {
  NOT_REMEMBER_ME,
  TOKEN_NULL,
  TOKEN_EXPIRE,
  EXCEPTION,
  TOKEN_VALID,
}

class LoopBackAuth {
  String _prefix = "LoopBackAuth_";
  String _token;
  String _bearToken;
  String _userId;
  String _fbToken;
  String _host = '';

  static final LoopBackAuth _instance = new LoopBackAuth._internal();
  factory LoopBackAuth() {
    return _instance;
  }

  LoopBackAuth._internal();

  Future<AccessStatus> loadAccessToken() async {
    try {
      String accessTokenStr = await _getPersist("accessToken");
      String userIdStr = await _getPersist("userId");
      String fbToken = await _getPersist("fbToken");
      dynamic currentCenter = await getCurrentCenter();
      if (accessTokenStr == null || accessTokenStr.isEmpty || userIdStr == null || userIdStr.isEmpty
          || fbToken == null || fbToken.isEmpty) {
        return AccessStatus.TOKEN_NULL;
      }
      _token = accessTokenStr;
      _userId = userIdStr;
      _fbToken = fbToken;

      print("Current Center");
      print(jsonEncode(currentCenter));
      if (currentCenter == null) {
        _bearToken = "";
        _host = "https://daikin.mcom.app";
      } else {
        _bearToken = this.generateBasicToken(currentCenter["username"], currentCenter["password"]);
        _host = currentCenter["ip"];
      }
      // _host = "http://mhome-showroom.ddns.net:80";
    } catch (e) {
      return AccessStatus.EXCEPTION;
    }
    return AccessStatus.TOKEN_VALID;
  }

  set accessToken(String token) {
    _token = token;
    save();
  }

  set bearToken(String token) {
    _bearToken = token;
    save();
  }

  set userId(id) {
    _userId = id;
    save();
  }

  set fbToken(String token) {
    _fbToken = token;
    save();
  }

  set host(String host) {
    _host = host;
    save();
  }

  String get accessToken => _token;
  String get bearToken => _bearToken;
  String get fbToken => _fbToken;
  String get userId => _userId;
  String get host => _host;

  // Persist
  void save() {
    _setPersist('accessToken', _token ?? '');
    _setPersist('bearToken', _bearToken ?? '');
    _setPersist('fbToken', _fbToken ?? '');
    _setPersist('userId', _userId ?? '');
    _setPersist('host', _host ?? '');
  }

  void clear() {
    _token = null;
    _bearToken = null;
    _userId = null;
    fbToken = null;
//    _host = null;
    save();
  }

  Future<dynamic> _getPersist(String prop) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('${this._prefix}$prop');
  }

  void _setPersist(String prop, dynamic value) async {
    final key = '${this._prefix}$prop';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value == null) {
      await prefs.remove(key);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw new Error();
    }
  }

  Future<List<dynamic>> getCenter(String key) async {
    var result = await this._getPersist(key);
    if (result == null) {
      result = [
        {
          "id": "1",
          "name": "Demo",
          "ip": "https://daikin.mcom.app",
          "username": "username",
          "password": "password"
        }
      ];

      this.setCenter("center", jsonEncode(result));
      this.setCurrentCenter(result[0]);
      return result;
    } else
      return jsonDecode(await this._getPersist(key));
  }

  void setCenter(String key, String value) {
    return this._setPersist(key, value);
  }

  void setCurrentCenter(dynamic value) {
    this._setPersist("current_center", jsonEncode(value));
    _bearToken = generateBasicToken(value["username"], value["password"]);
    _host = value["ip"];
    save();
  }

  String generateBasicToken(String username, String password) {
    String credentials = username + ":" + password;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);

    print(encoded);
    return "Basic " + encoded;
  }

  dynamic getCurrentCenter() async {
    dynamic result = await this._getPersist("current_center");
    if (result == null) {
      result = {
        "id": "1",
        "name": "Demo",
        "ip": "https://daikin.mcom.app",
        "username": "username",
        "password": "password"
      };

      this.setCenter("center", jsonEncode([result]));
      this.setCurrentCenter(result);
      return result;
    } else {
      var dat = jsonDecode(result);
      return dat;
    }
  }
}
