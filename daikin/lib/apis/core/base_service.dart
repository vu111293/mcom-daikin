import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'auth_service.dart';

abstract class BaseLoopBackApi {
  LoopBackAuth auth;

  BaseLoopBackApi(): auth = new LoopBackAuth();

  Future<dynamic> request({
    String method,
    String url,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> postBody,
    String customToken}) async {

    var uri = Uri.parse(url);
    if (queryParams != null && queryParams.length > 0) {
      List.from(queryParams.keys).forEach((k) {
        if (queryParams[k] == null) {
          queryParams.remove(k);
        }
      });
      uri = uri.replace(queryParameters: queryParams);
    }

    // Put auth token
    Map<String, dynamic> reqHeader = {};
    if (customToken?.isNotEmpty == true) {
      reqHeader[HttpHeaders.authorizationHeader] = customToken;
    } else if (auth?.bearToken?.isNotEmpty == true) {
      reqHeader[HttpHeaders.authorizationHeader] = auth.bearToken;
    }

    Dio dio = Dio();
//    dio.interceptors.add(PrettyDioLogger());
// customization
//    dio.interceptors.add(PrettyDioLogger(
//        requestHeader: false,
//        requestBody: false,
//        responseBody: true,
//        responseHeader: false,
//        error: true,
//        compact: true,
//        maxWidth: 1000));
    
    Response dioRes;
    Options dioOptions = Options(
      headers: reqHeader,
      sendTimeout: 15000,
      receiveTimeout: 30000,
    );

    switch(method.toUpperCase()) {
      case 'GET':
        dioRes = await dio.getUri(uri, options: dioOptions);
        break;

      case 'POST':
        dioRes = await dio.postUri(uri, data: postBody, options: dioOptions);
        break;

      case 'PUT':
        dioRes = await dio.putUri(uri, data: postBody, options: dioOptions);
        break;

      case 'DELETE':
        dioRes = await dio.deleteUri(uri, data: postBody, options: dioOptions);
        break;

      default:
        throw Exception('Not support method $method');
        break;
    }

    if (dioRes.statusCode >= 300 || dioRes.statusCode < 200) {
      throw Exception('Request return diff 2xx code ${dioRes.toString()}');
    }

    return dioRes.data;
  }

  String getModelPath();

  dynamic fromJson(Map<String, Object> item);
}
