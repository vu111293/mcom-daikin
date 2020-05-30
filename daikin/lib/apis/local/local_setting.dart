import 'dart:async';
import 'dart:convert';
import 'package:daikin/apis/core/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSetting {
  String _prefix = "LocalSetting_";
  String groupBy;
  String sortBy;
  String locale;

  final int RECOMMEND_CACHE_SIZE = 100;
  final int LIMIT_SHARE_HISTORY = 5;

  static final LocalSetting _instance = new LocalSetting._internal();

  factory LocalSetting() {
    return _instance;
  }

  LocalSetting._internal();

//  int get tagPermissionDefault => _tagPermissionDefault;

  Future loadSetting() async {
    groupBy = await _getPersist("groupBy");
    if (groupBy == null || groupBy.isEmpty) {
      groupBy = 'dept';
    }

    sortBy = await _getPersist("sortBy");
    if (sortBy == null || sortBy.isEmpty) {
      sortBy = 'az';
    }

    locale = await getCurrentLocale();
  }

  setGroupBy(String val) {
    _setPersist("groupBy", val);
    groupBy = val;
  }

  setSortBy(String val) {
    _setPersist("sortBy", val);
    sortBy = val;
  }

  setRequireAddDevice(bool request) {
    _setPersist('addNewDevice', request);
  }

  Future<bool> getRequireAddDevice() async {
    var ret = await _getPersist('addNewDevice');
    return ret ?? true;
  }

  setCurrentLocale(String code) {
    _setPersist('locale', code);
    locale = code;
  }

  saveRoomConfig(String raw) {
    _setPersist('room_conf', raw);
  }

  Future<dynamic> getRoomConfig() {
    return _getPersist('room_conf');
  }

  saveCoverAssets(String raw) {
    _setPersist('cover_assets', raw);
  }

  Future<dynamic> getCoverAssets() {
    return _getPersist('cover_assets');
  }

  Future<String> getCurrentLocale() async {
    String locale = await _getPersist('locale');
    return locale;
  }

//  Future<String> getSortBy() async {
//    String val = await _getPersist("sortBy");
//    if (val == null || val.isEmpty) return "az";
//    return val;
//  }

  void clear() {
    setGroupBy('dept');
    setSortBy('az');
    LoopBackAuth().clear();
//    savePassCodeLock("");
//    clearNewNotification();
//    clearFirebaseMessageToken();
//    clearRecommends();
//    clearShareHistories();
//    clearTagTypeDefault();
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
