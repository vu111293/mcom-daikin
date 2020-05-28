import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:daikin/models/base_response.dart';

import 'auth_service.dart';
import 'errors.dart';

abstract class BaseLoopBackApi {
  HttpClient _httpClient;
  LoopBackAuth auth;

  BaseLoopBackApi()
      : _httpClient = new HttpClient(),
        auth = new LoopBackAuth();

  Future<dynamic> request({
    String method,
    String url,
    Map<String, dynamic> urlParams,
    Map<String, dynamic> postBody,
    bool isWrapBaseResponse = false,
    isUsingAdminToken = false,
    String customToken = ''
  }) async {
    _httpClient.idleTimeout = new Duration(seconds: 60);
    var uri = Uri.parse(url);
    if (urlParams != null && urlParams.length > 0) {
      List.from(urlParams.keys).forEach((k) {
        if (urlParams[k] == null) {
          urlParams.remove(k);
        }
      });
      uri = uri.replace(queryParameters: urlParams);
    }
    HttpClientRequest request = await _httpClient.openUrl(method, uri).catchError((e) {
      print("request error: " + e.toString());
      throw NetServiceError(type: ErrorType.NETWORK_ERROR, message: 'Net error');
    })
          ..headers.contentType = ContentType.json
          ..headers.chunkedTransferEncoding = false;

//    if (auth?.accessToken != null && auth?.accessToken?.isNotEmpty == true) {
//      request.headers.add('x-token', auth.accessToken);
//    }

    if (customToken?.isNotEmpty == true) {
      request.headers.add(HttpHeaders.authorizationHeader, customToken);
    } else if (auth?.bearToken?.isNotEmpty == true) {
      request.headers.add(HttpHeaders.authorizationHeader, auth.bearToken);
    }

    if (postBody != null) {
      var stringBody = json.encode(postBody);
      request.headers.contentLength = utf8.encode(stringBody).length;
      request.write(stringBody);
    }

    HttpClientResponse response = await request.close().catchError((e) {
      print(e);
      throw new NetServiceError(
          type: ErrorType.NETWORK_ERROR,
          message: 'Connection error, please try later.');
    });

    print('Phat API: ${url.toString()} -> ${response.statusCode.toString()} -> ${response.reasonPhrase.toString()}');
    if (postBody != null) {
      postBody.keys.forEach((k) {
        print('$k : ${postBody[k]}');
      });
    }
//    print("test thu goi api tra ve error: " + response.reasonPhrase);

    String raw = await response.transform(utf8.decoder).join();
    dynamic data = '';
    try {
      data = json.decode(raw);
    } catch (e) {
      print('Error when parse: $e');
    }
    print('Response: $data');

    if (response.headers.contentType.toString() !=
        ContentType.json.toString()) {
      throw new NetServiceError(
          type: ErrorType.UNSUPPORT_TYPE,
          message: 'Server returned an unsupported content type: ''${response.headers.contentType} from ${request.uri}');
    }

    if (response.statusCode == HttpStatus.noContent) {
      return "";
    }

    if (response.statusCode == HttpStatus.accepted) {
      return data;
    }

    if (response.statusCode != HttpStatus.ok) {
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          throw new NetServiceError(
              type: ErrorType.WRONG_CURRENT_PASSWORD,
              message: 'There is an error, please try later.');
        case HttpStatus.unauthorized:
          throw new NetServiceError(
              type: ErrorType.AUTH_FAIL,
              message: 'There is an error, please try later.');
        case HttpStatus.internalServerError:
          throw new NetServiceError(
              type: ErrorType.SYSTEM_ERROR,
              message: 'There is an error, please try later.');
        default:
          throw new NetServiceError(
              type: ErrorType.SYSTEM_ERROR,
              message: 'There is an error, please try later.');
      }
    }
//    String raw = await response.transform(utf8.decoder).join();
//    dynamic data = json.decode(raw);

    if (isWrapBaseResponse) {
      BaseResponse resp = BaseResponse.fromJson(data);
      if (resp.code == 200) {
        return resp.data;
      } else {
        throw new NetServiceError(type: resp.errorType, message: resp.message);
      }
    } else {
      return data;
    }
  }

  String getModelPath();

  dynamic fromJson(Map<String, Object> item);
}
