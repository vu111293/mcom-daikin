import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

// *** PLEASE RUN COMMAND BELOW FOR REBUILD MODELS ****
// flutter packages pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(nullable: false)
class LUser {
  @JsonKey(name: '_id')
  final String id;
  final String uid;
  final String fullName;
  final String phone;
  final String email;
  final String address;
  final String avatar;
  final String role;
  final int unreadNotifyCount;
  final List<String> permissions;

  LUser(
      {
        this.id,
        this.address,
        this.avatar,
        this.email,
        this.fullName,
        this.permissions,
        this.phone,
        this.role,
        this.uid,
        this.unreadNotifyCount
      });

  factory LUser.fromJson(Map<String, dynamic> json) {
    final user = _$LUserFromJson(json);
    return user;
  }
  Map<String, dynamic> toJson() => _$LUserToJson(this);

  LUser copyWith(
      {String id,
      String uid,
      String fullName,
      String phone,
      String email,
      String address,
      String avatar,
      String position,
      String plant,
      double area,
      int locationLat,
      int locationLng,
      String type,
      String status,
      String password,
      String updatedAt,
      String createdAt}) {
    return LUser(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        address: address ?? this.address,
        avatar: avatar ?? this.avatar);
  }

  bool get needToUpdateProfile => fullName == null || fullName.isEmpty;
}

// this is model for only my account
@JsonSerializable(nullable: false)
class UserModel {
  String id;
  String sex;
  String username;
  String fullname;
  String local;
  String avatar;
  String phone;
  String login_type;
  String city_code;
  String national_id;
  String date_of_birth;
  String email;
  String experience;
  String working_hour;
  String expected_salary;
  String national_id_front_image;
  String national_id_back_image;
  String identity_video;
  String account_type;
  double rate;
  bool is_verified;
  bool isNewUser;
  String money;
  String name_company;
  String avatar_company;
  String contact_name_company;
  String contact_phone_company;
  String contact_email_company;
  bool allowNotification;
//  @JsonKey(toJson: _branchToJson, nullable: true)
//  Department department;
//  @JsonKey(toJson: _accountListToJson, nullable: true)
//  List<Account> favouriteColleagues;
  UserModel(
      this.id,
      this.sex,
      this.username,
      this.fullname,
      this.local,
      this.avatar,
      this.phone,
      this.login_type,
      this.city_code,
      this.national_id,
      this.date_of_birth,
      this.email,
      this.experience,
      this.working_hour,
      this.expected_salary,
      this.national_id_front_image,
      this.national_id_back_image,
      this.identity_video,
      this.account_type,
      this.rate,
      this.is_verified,
      this.isNewUser,
      this.money,
      this.name_company,
      this.avatar_company,
      this.contact_name_company,
      this.contact_phone_company,
      this.contact_email_company,
      this.allowNotification);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = _$UserModelFromJson(json);
    return user;
  }
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  @override
  String toString() {
    return """\n
      ===== USER MODEL =====
      id: $id,
      fullname: $fullname,
      phone: $phone,
      login_type: $login_type,
      city_code: $city_code,
      national_id: $national_id,
      date_of_birth: $date_of_birth,
      email: $email,
      experience: $experience,
      working_hour: $working_hour,
      expected_salary: $expected_salary,
      national_id_front_image: $national_id_front_image,
      national_id_back_image: $national_id_back_image,
      identity_video: $identity_video,
      account_type: $account_type,
      rate: $rate,
      is_verified: $is_verified,
      isNewUser: $isNewUser,
      \n
    """;
  }
}
