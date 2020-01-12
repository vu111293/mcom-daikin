import 'dart:async';

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

  static final LoopBackAuth _instance = new LoopBackAuth._internal();

  factory LoopBackAuth() {
    return _instance;
  }

  LoopBackAuth._internal();

  Future<AccessStatus> loadAccessToken() async {
    try {
      String accessTokenStr = await _getPersist("accessToken");
      String userIdStr = await _getPersist("userId");
      if (accessTokenStr == null ||
          accessTokenStr.isEmpty ||
          userIdStr == null ||
          userIdStr.isEmpty) {
        return AccessStatus.TOKEN_NULL;
      }
      _token = accessTokenStr;
      _userId = userIdStr;
      _bearToken = 'Basic a3l0aHVhdEBraW1zb250aWVuLmNvbTpDaG90cm9ubmllbXZ1aTE=';
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

  String get accessToken => _token;
  String get bearToken => _bearToken;
  String get fbToken => _fbToken;
  String get userId => _userId;

  // Persist
  void save() {
    _setPersist('accessToken', _token ?? '');
    _setPersist('bearToken', _bearToken ?? '');
    _setPersist('fbToken', _bearToken ?? '');
    _setPersist('userId', _userId ?? '');
  }

  void clear() {
    _token = null;
    _bearToken = null;
    _userId = null;
    fbToken = null;
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
}
