// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse(
    json['success'] as bool,
    json['message'] as String,
    json['code'] as int,
    json['data'],
  );
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
