import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/apis/core/base_service.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

import '../loopback_config.dart';

class FileService extends BaseLoopBackApi {
  final LoopBackAuth auth;
  bool isDirty = true;

  FileService() : auth = new LoopBackAuth();

  @override
  String getModelPath() {
    return "file";
  }

  String getSettingModelPath() {
    return "Account-Settings";
  }

  @override
  fromJson(Map<String, Object> item) {
    // TODO: implement fromJson
    return null;
  }

  ///upload file to server,
  ///accept a local file uri and a type
  ///return a web url if success else return back local file uri
  Future<String> uploadFile(String fileUri, String type) async {
    final url = [LoopBackConfig.getPath(), LoopBackConfig.getApiVersion(), type, 'upload'].join('/');
    File file = new File(fileUri);
    Dio dio = new Dio();
    dio.options.headers = {
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwYXlsb2FkIjp7ImVtcGxveWVlX2lkIjoiMDJkMWMxZDAtN2I5Ny0xMWU5LTgzN2EtZWQ3ZDVhNjRkMTI2Iiwicm9sZSI6IlNVUEVSQURNSU4ifSwicm9sZSI6IlNVUEVSQURNSU4iLCJleHAiOiIyMDE5LTEwLTEwVDA2OjIxOjQ4LjQ5NVoifQ.P2K7uE6mlEtxNUQIVbdc3c_PqNc6fweBbCGsaT3cTmw"
    };
    FormData formdata = new FormData(); // just like JS
    formdata.add(type, new UploadFileInfo(file, basename(file.path)));
    //print("FormData: " + formdata.toString());
    print("URL: " + url);
    try {
      var response = await dio.post(url,
          data: formdata,
          options: Options(method: 'POST', responseType: ResponseType.json // or ResponseType.JSON
              ));

      print('bambi ne respionse ne ba: ${response.data['results']["object"]["url"]}');

      return response.data['results']["object"]["url"];
    } catch (e) {
      print('bambi type:  ' + type);
      print('bambi upload file failed: ${e.toString()}');
      return fileUri;
    }
  }
}
