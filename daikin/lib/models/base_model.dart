import 'package:json_annotation/json_annotation.dart';
part 'base_model.g.dart';

@JsonSerializable()
class AccessToken {
  @JsonKey()
  String id;

  @JsonKey()
  int ttl;

  @JsonKey()
  DateTime created;

  @JsonKey()
  String userId;

  bool rememberMe;

  AccessToken({this.id, this.userId, this.ttl, scopes, this.rememberMe, this.created});

  factory AccessToken.fromJson(Map<String, dynamic> json) => _$AccessTokenFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);
}

@JsonSerializable()
class LoopBackFilter {
  @JsonKey()
  final List<String> fields;

  @JsonKey()
  final List<String> include;

  @JsonKey()
  final String order;

  @JsonKey()
  final int limit;

  @JsonKey()
  final int offset;

  @JsonKey()
  final Object where;
  LoopBackFilter({fields, include, this.order, this.limit, this.offset, where})
      : this.fields = fields ?? [],
        this.include = include ?? [],
        this.where = where ?? {};
}
