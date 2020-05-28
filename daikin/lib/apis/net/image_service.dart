import 'dart:convert';
import 'dart:io';

import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/apis/core/base_service.dart';
import 'package:dio/dio.dart';

import '../loopback_config.dart';

class ImageService extends BaseLoopBackApi {
  final LoopBackAuth auth;

  ImageService() : auth = new LoopBackAuth();
  @override
  String getModelPath() {
    return "";
  }

  @override
  dynamic fromJson(Map<String, Object> item) {
    return null;
  }

  Future<String> uploadImageToImgur(File image) async {
    try {
      print("Start Upload");
      Dio dio = new Dio();
      String name = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path, filename: name),
      });
      var response = await dio.post(LoopBackConfig.getApiImgur(),
          data: formData,
          options: Options(
              headers: {"Authorization": LoopBackConfig.getSecretImgur()},
              method: 'POST',
              responseType: ResponseType.json));

      print("Upload Successfully");
      print(response.data);
      var data = json.decode(json.encode(response.data));
      return data['data']['link'].toString();
    } catch (error) {
      throw Exception('There is an error, please try later.');
    }
  }
}
