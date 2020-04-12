import 'dart:io';

import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/models/user.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/image_picker.dart';
import 'package:daikin/ui/pages/login/login_screen.dart';
import 'package:daikin/ui/pages/statics/historyEvent.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/ui/setting/my_center_screen.dart';
import 'package:daikin/ui/setting/profile_screen.dart';
import 'package:daikin/ui/setting/support_screen.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'about_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  ApplicationBloc _appBloc;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleLogout() {
    LoopBackAuth().clear();
    Routing().popToRoot(context);
    Routing().navigate2(context, LoginScreen(), replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          BaseHeaderScreen(
            hideProfile: true,
            title: "Cài đặt",
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    Routing().navigate2(context, ProfileScreen());
                  },
                  leading: Container(
                    width: 55.0,
                    height: 55.0,
                    child: ImagePickerWidget(
                      context: context,
                      isEdit: false,
                      circle: true,
                      size: 55.0,
                      resourceUrl: _appBloc.authBloc.currentUser.avatar,
                      onFileChanged: (fileUri, fileType) {
                        setState(() {});
                      },
                    ),
                  ),
                  title: Text(
                    _appBloc.authBloc.getUser.fullName,
                    style: ptSubtitle(context)
                        .copyWith(color: ptPrimaryColor(context)),
                  ),
                  subtitle: Text('',
                      style: ptTitle(context)
                          .copyWith(color: ptPrimaryColor(context))),
                  trailing: Container(
                    width: 32,
                    height: 32,
                    child: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: ptPrimaryColor(context),
                        child: Image.asset(
                          'assets/icons/But_chi.png',
                          width: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
//                SizedBox(
//                  height: 20,
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    Column(
//                      children: <Widget>[
//                        Container(
//                          width: deviceWidth(context) / 4,
//                          height: deviceWidth(context) / 4,
//                          child: Material(
//                            borderRadius: BorderRadius.all(Radius.circular(8)),
//                            elevation: 8,
//                            shadowColor: Colors.black26,
//                            color: Colors.red,
//                            child: Padding(
//                              padding:
//                                  EdgeInsets.all(deviceWidth(context) / 16),
//                              child: Image.asset(
//                                'assets/icons/Turn_off.png',
//                                color: Colors.white,
//                              ),
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(top: 8.0),
//                          child: Text(
//                            "Tắt hết thiết bị",
//                            style: ptBody1(context)
//                                .copyWith(color: ptPrimaryColor(context)),
//                            textAlign: TextAlign.center,
//                          ),
//                        )
//                      ],
//                    ),
//                    Column(
//                      children: <Widget>[
//                        Container(
//                          width: deviceWidth(context) / 4,
//                          height: deviceWidth(context) / 4,
//                          child: Material(
//                            borderRadius: BorderRadius.all(Radius.circular(8)),
//                            elevation: 8,
//                            shadowColor: Colors.black26,
//                            color: Colors.white,
//                            child: Padding(
//                              padding:
//                                  EdgeInsets.all(deviceWidth(context) / 16),
//                              child: Image.asset(
//                                'assets/icons/O_khoa.png',
//                                color: HexColor(appBorderColor),
//                              ),
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(top: 8.0),
//                          child: Text(
//                            "Rời khỏi nhà",
//                            style: ptBody1(context)
//                                .copyWith(color: ptPrimaryColor(context)),
//                            textAlign: TextAlign.center,
//                          ),
//                        )
//                      ],
//                    ),
//                    Column(
//                      children: <Widget>[
//                        Container(
//                          width: deviceWidth(context) / 4,
//                          height: deviceWidth(context) / 4,
//                          child: Material(
//                            borderRadius: BorderRadius.all(Radius.circular(8)),
//                            elevation: 8,
//                            shadowColor: Colors.black26,
//                            color: Colors.white,
//                            child: Padding(
//                              padding:
//                                  EdgeInsets.all(deviceWidth(context) / 16),
//                              child: Image.asset(
//                                'assets/icons/Chia_khoa.png',
//                                color: HexColor(appBorderColor),
//                              ),
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(top: 8.0),
//                          child: Text(
//                            "Về nhà",
//                            style: ptBody1(context)
//                                .copyWith(color: ptPrimaryColor(context)),
//                            textAlign: TextAlign.center,
//                          ),
//                        )
//                      ],
//                    ),
//                  ],
//                ),

                ///
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 10),
                  color: HexColor("#fafafa"),
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    Routing().navigate2(context, MyCenterScreen());
                  },
                  leading: Text(
                    "Thiết bị trung tâm",
                    style: ptTitle(context).copyWith(
                        color: ptPrimaryColor(context),
                        fontWeight: FontWeight.w600),
                  ),
                  trailing: StreamBuilder(
                    stream: _appBloc.centerBloc.currentCenterChangeEvent,
                    builder: (context, snapshot) {
                      String centerName = snapshot.hasData ? snapshot.data : '';
                      return Text(
                        upFirstText(centerName),
                        style: ptSubtitle(context).copyWith(),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  color: HexColor("#fafafa"),
                  height: 2.5,
                ),
                // ListTile(
                //   leading: Text(
                //     "Messages",
                //     style: ptTitle(context).copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.w600),
                //   ),
                //   title: Container(
                //     width: 30,
                //     height: 30,
                //     child: Align(
                //       alignment: Alignment.centerLeft,
                //       child: CircleAvatar(
                //         backgroundColor: Colors.red,
                //         child: Text(
                //           "3",
                //           style: ptCaption(context).copyWith(color: Colors.white),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 5),
                //   color: HexColor("#fafafa"),
                //   height: 2.5,
                // ),
                ListTile(
                  onTap: () {
                    Routing().navigate2(context, AboutScreen());
                  },
                  leading: Text(
                    "Giới thiệu",
                    style: ptTitle(context).copyWith(
                        color: ptPrimaryColor(context),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  color: HexColor("#fafafa"),
                  height: 2.5,
                ),
                ListTile(
                  onTap: () {
                    Routing().navigate2(context, HistoryEvent());
                  },
                  leading: Text(
                    "Lịch sử sự kiện",
                    style: ptTitle(context).copyWith(
                        color: ptPrimaryColor(context),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  color: HexColor("#fafafa"),
                  height: 2.5,
                ),

                ///
                // Container(
                //   margin: EdgeInsets.only(top: 16, bottom: 10),
                //   color: HexColor("#fafafa"),
                //   height: 10,
                // ),
                // ListTile(
                //   leading: Text(
                //     "Change Password",
                //     style: ptTitle(context).copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.w600),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 5),
                //   color: HexColor("#fafafa"),
                //   height: 2.5,
                // ),

                ListTile(
                  onTap: () {
                    Routing().navigate2(context, SupportScreen());
                  },
                  leading: Text(
                    "Hỗ trợ",
                    style: ptTitle(context).copyWith(
                        color: ptPrimaryColor(context),
                        fontWeight: FontWeight.w600),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  color: HexColor("#fafafa"),
                  height: 2.5,
                ),

                ///
                // Container(
                //   margin: EdgeInsets.only(top: 16, bottom: 10),
                //   color: HexColor("#fafafa"),
                //   height: 10,
                // ),
                ListTile(
                  onTap: () => showDialog<bool>(
                    context: context,
                    builder: (c) => AlertDialog(
                      title: Text('Thông báo'),
                      content: Text('Bạn có muốn đăng xuất'),
                      actions: [
                        FlatButton(
                          child: Text(
                            'Đồng ý',
                            style: ptButton(context)
                                .copyWith(color: ptPrimaryColor(context)),
                          ),
                          onPressed: handleLogout,
                        ),
                        FlatButton(
                          child: Text(
                            'Hủy',
                            style: ptButton(context)
                                .copyWith(color: ptPrimaryColor(context)),
                          ),
                          onPressed: () => Navigator.pop(c, false),
                        ),
                      ],
                    ),
                  ),
                  leading: InkWell(
                    child: Text(
                      "Đăng xuất",
                      style: ptTitle(context).copyWith(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
