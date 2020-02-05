import 'package:daikin/apis/core/auth_service.dart';

class LoopBackConfig {
  static String _version = 'api';
  static String _authPrefix = '';
  static String _uploadContainer = 's3-colleagues-dev';
  static String _apiImgur = "https://api.imgur.com/3/image";
  static String _secretImgur = "Client-ID d4de8224fa0042f";

  static void setUploadContainer([String container = '']) {
    LoopBackConfig._uploadContainer = container;
  }

  static String getUploadContainer() {
    return LoopBackConfig._uploadContainer;
  }

  static void setApiVersion([String version = 'api']) {
    LoopBackConfig._version = version;
  }

  static String getApiVersion() {
    return LoopBackConfig._version;
  }

  // static void setBaseURL([String url = '/']) {
  //   LoopBackConfig._path = url;
  // }

  static String getPath() {
    return LoopBackAuth().host;
  }

  static void setAuthPrefix([String authPrefix = '']) {
    LoopBackConfig._authPrefix = authPrefix;
  }

  static String getAuthPrefix() {
    return LoopBackConfig._authPrefix;
  }

  static String getApiImgur() {
    return LoopBackConfig._apiImgur;
  }

  static void setApiImgur(String api) {
    LoopBackConfig._apiImgur = api;
  }

  static String getSecretImgur() {
    return LoopBackConfig._secretImgur;
  }

  static void setSecretImgur(String api) {
    LoopBackConfig._secretImgur = api;
  }
}
