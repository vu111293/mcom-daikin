// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) {
  return AccessToken(
    id: json['id'] as String,
    userId: json['userId'] as String,
    ttl: json['ttl'] as int,
    rememberMe: json['rememberMe'] as bool,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
  );
}

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ttl': instance.ttl,
      'created': instance.created?.toIso8601String(),
      'userId': instance.userId,
      'rememberMe': instance.rememberMe,
    };

LoopBackFilter _$LoopBackFilterFromJson(Map<String, dynamic> json) {
  return LoopBackFilter(
    fields: json['fields'],
    include: json['include'],
    order: json['order'] as String,
    limit: json['limit'] as int,
    offset: json['offset'] as int,
    where: json['where'],
  );
}

Map<String, dynamic> _$LoopBackFilterToJson(LoopBackFilter instance) =>
    <String, dynamic>{
      'fields': instance.fields,
      'include': instance.include,
      'order': instance.order,
      'limit': instance.limit,
      'offset': instance.offset,
      'where': instance.where,
    };
