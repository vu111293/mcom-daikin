// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LUser _$LUserFromJson(Map<String, dynamic> json) {
  return LUser(
    id: json['_id'] as String,
    address: json['address'] as String,
    avatar: json['avatar'] as String,
    email: json['email'] as String,
    fullName: json['fullName'] as String,
    permissions: (json['permissions'] as List).map((e) => e as String).toList(),
    phone: json['phone'] as String,
    role: json['role'] as String,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$LUserToJson(LUser instance) => <String, dynamic>{
      '_id': instance.id,
      'uid': instance.uid,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'avatar': instance.avatar,
      'role': instance.role,
      'permissions': instance.permissions,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['id'] as String,
    json['sex'] as String,
    json['username'] as String,
    json['fullname'] as String,
    json['local'] as String,
    json['avatar'] as String,
    json['phone'] as String,
    json['login_type'] as String,
    json['city_code'] as String,
    json['national_id'] as String,
    json['date_of_birth'] as String,
    json['email'] as String,
    json['experience'] as String,
    json['working_hour'] as String,
    json['expected_salary'] as String,
    json['national_id_front_image'] as String,
    json['national_id_back_image'] as String,
    json['identity_video'] as String,
    json['account_type'] as String,
    (json['rate'] as num).toDouble(),
    json['is_verified'] as bool,
    json['isNewUser'] as bool,
    json['money'] as String,
    json['name_company'] as String,
    json['avatar_company'] as String,
    json['contact_name_company'] as String,
    json['contact_phone_company'] as String,
    json['contact_email_company'] as String,
    json['allowNotification'] as bool,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'sex': instance.sex,
      'username': instance.username,
      'fullname': instance.fullname,
      'local': instance.local,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'login_type': instance.login_type,
      'city_code': instance.city_code,
      'national_id': instance.national_id,
      'date_of_birth': instance.date_of_birth,
      'email': instance.email,
      'experience': instance.experience,
      'working_hour': instance.working_hour,
      'expected_salary': instance.expected_salary,
      'national_id_front_image': instance.national_id_front_image,
      'national_id_back_image': instance.national_id_back_image,
      'identity_video': instance.identity_video,
      'account_type': instance.account_type,
      'rate': instance.rate,
      'is_verified': instance.is_verified,
      'isNewUser': instance.isNewUser,
      'money': instance.money,
      'name_company': instance.name_company,
      'avatar_company': instance.avatar_company,
      'contact_name_company': instance.contact_name_company,
      'contact_phone_company': instance.contact_phone_company,
      'contact_email_company': instance.contact_email_company,
      'allowNotification': instance.allowNotification,
    };
