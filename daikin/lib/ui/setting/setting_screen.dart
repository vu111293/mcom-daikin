import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/pages/login/login_screen.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/ui/setting/profile_screen.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
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
            title: "Setting",
            subTitle: "Edit all your setting",
          ),
          Container(
            height: contentScreen(context),
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
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/userImage.png'),
                      ),
                    ),
                    title: Text(
                      'Hello !',
                      style: ptSubtitle(context).copyWith(color: ptPrimaryColor(context)),
                    ),
                    subtitle: Text('Đâu Phải Phát', style: ptTitle(context).copyWith(color: ptPrimaryColor(context))),
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
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: deviceWidth(context) / 4,
                            height: deviceWidth(context) / 4,
                            child: Material(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              elevation: 8,
                              shadowColor: Colors.black26,
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(deviceWidth(context) / 16),
                                child: Image.asset(
                                  'assets/icons/Turn_off.png',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Off Energy",
                              style: ptBody1(context).copyWith(color: ptPrimaryColor(context)),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: deviceWidth(context) / 4,
                            height: deviceWidth(context) / 4,
                            child: Material(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              elevation: 8,
                              shadowColor: Colors.black26,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(deviceWidth(context) / 16),
                                child: Image.asset(
                                  'assets/icons/O_khoa.png',
                                  color: HexColor(appBorderColor),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Left Home",
                              style: ptBody1(context).copyWith(color: ptPrimaryColor(context)),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: deviceWidth(context) / 4,
                            height: deviceWidth(context) / 4,
                            child: Material(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              elevation: 8,
                              shadowColor: Colors.black26,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(deviceWidth(context) / 16),
                                child: Image.asset(
                                  'assets/icons/Chia_khoa.png',
                                  color: HexColor(appBorderColor),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Came Home",
                              style: ptBody1(context).copyWith(color: ptPrimaryColor(context)),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  ///
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 10),
                    color: HexColor("#fafafa"),
                    height: 10,
                  ),
                  ListTile(
                    leading: Text(
                      "My Center",
                      style: ptTitle(context).copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: HexColor("#fafafa"),
                    height: 2.5,
                  ),
                  ListTile(
                    leading: Text(
                      "Messages",
                      style: ptTitle(context).copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.w600),
                    ),
                    title: Container(
                      width: 30,
                      height: 30,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(
                            "3",
                            style: ptCaption(context).copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: HexColor("#fafafa"),
                    height: 2.5,
                  ),
                  ListTile(
                    leading: Text(
                      "About",
                      style: ptTitle(context).copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: HexColor("#fafafa"),
                    height: 2.5,
                  ),

                  ///
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 10),
                    color: HexColor("#fafafa"),
                    height: 10,
                  ),
                  ListTile(
                    leading: Text(
                      "Change Password",
                      style: ptTitle(context).copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: HexColor("#fafafa"),
                    height: 2.5,
                  ),

                  ListTile(
                    leading: Text(
                      "Support",
                      style: ptTitle(context).copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.w600),
                    ),
                  ),

                  ///
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 10),
                    color: HexColor("#fafafa"),
                    height: 10,
                  ),
                  ListTile(
                      leading: InkWell(
                    onTap: handleLogout,
                    child: Text(
                      "Sign Out",
                      style: ptTitle(context).copyWith(color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
