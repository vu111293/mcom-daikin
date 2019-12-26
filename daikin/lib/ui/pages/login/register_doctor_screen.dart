//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:loctroi/blocs/application_bloc.dart';
//import 'package:loctroi/constants/constants.dart';
//import 'package:loctroi/helper/phone_auth_helper.dart';
//import 'package:loctroi/ui/pages/login/login_doctor_screen.dart';
//import 'package:loctroi/ui/pages/login/update_info_login_doctor_screen.dart';
//import 'package:loctroi/ui/route/routing.dart';
//import 'package:loctroi/utils/hex_color.dart';
//import 'package:loctroi/utils/scale_util.dart';
//
//class RegisterDoctorScreen extends StatefulWidget {
//  RegisterDoctorScreenState createState() => RegisterDoctorScreenState();
//}
//
//class RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
//  ApplicationBloc _appBloc;
//  TextEditingController emailController = TextEditingController();
//  TextEditingController passwordController = TextEditingController();
//  TextEditingController confimPasswordController = TextEditingController();
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ScaleUtil.instance = ScaleUtil.getInstance()..init(context);
//
//    return Scaffold(
//      backgroundColor: Colors.white,
//      bottomNavigationBar: Container(
//        child: Material(
//          color: ptPrimaryColor(context),
//          child: Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  decoration: BoxDecoration(
//                    border: Border(
//                      top: BorderSide(
//                        color: Colors.black26,
//                        width: 1,
//                      ),
//                    ),
//                    color: Colors.white,
//                  ),
//                  height: 72.0,
//                  child: InkWell(
//                    onTap: () {
//                      Routing().navigate2(context, LoginDoctorScreen());
//                    },
//                    child: Padding(
//                      padding: EdgeInsets.only(left: 30.0),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Padding(
//                            padding: EdgeInsets.only(left: 10.0),
//                            child: Text(
//                              "Đã có tài khoản",
//                              style: ptCaption(context).copyWith(color: ptPrimaryColor(context)),
//                            ),
//                          ), // text
//                          Padding(
//                            padding: EdgeInsets.only(left: 10.0),
//                            child: Text(
//                              "ĐĂNG NHẬP",
//                              style: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
//                            ),
//                          ), // text
//                          // icon
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//              Expanded(
//                child: Container(
//                  height: 72.0,
//                  child: InkWell(
//                    onTap: () {
//                      Routing().navigate2(context, UpdateInfoLoginDoctorScreen());
//                    },
//                    child: Padding(
//                      padding: EdgeInsets.only(right: 30.0),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Padding(
//                            padding: EdgeInsets.only(right: 10.0),
//                            child: Text(
//                              "Tiếp tục",
//                              style: ptTitle(context).copyWith(color: Colors.white),
//                            ),
//                          ), // text
//                          Icon(
//                            Icons.arrow_forward,
//                            color: Colors.white,
//                            size: 25.0,
//                          ), // icon
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//      body: SingleChildScrollView(
//        physics: ClampingScrollPhysics(),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            InkWell(
//              child: Image.asset(
//                "assets/images/backgroundLogin.png",
//                fit: BoxFit.cover,
//                alignment: Alignment.bottomCenter,
//                width: deviceWidth(context),
//                height: ScaleUtil.getInstance().setHeight(180),
//              ),
//              onTap: () {
//                SystemChannels.textInput.invokeMethod('TextInput.hide');
//              },
//            ),
//            Padding(
//              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 30.0),
//                    child: Row(
//                      children: <Widget>[
//                        Image.asset(
//                          "assets/images/logo.png",
//                          width: 80,
//                          fit: BoxFit.contain,
//                        ),
//                        SizedBox(
//                          width: 30.0,
//                        ),
//                        Image.asset(
//                          "assets/images/logo2.png",
//                          width: 80,
//                          fit: BoxFit.contain,
//                        ),
//                      ],
//                    ),
//                  ),
//                  Text('ĐĂNG KÝ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
//                  Padding(
//                    padding: EdgeInsets.only(top: 8.0, bottom: 20),
//                    child: Text(
//                        'Hệ thống Bệnh viện Cây ăn quả được thành lập bởi sự hợp tác giữa Viện Cây Ăn Quả Miền Nam & Tập Đoàn Lộc Trời',
//                        style: TextStyle(fontSize: 18.0)),
//                  ),
//                  TextField(
//                    controller: emailController,
//                    maxLines: 1,
//                    style: ptTitle(context),
//                    keyboardType: TextInputType.number,
//                    decoration: InputDecoration(
//                      prefixIcon: Padding(
//                        padding: EdgeInsets.only(right: 20.0),
//                        child: Icon(
//                          Icons.phone_in_talk,
//                          color: HexColor(appText60),
//                          size: 30.0,
//                        ),
//                      ),
//                      hintText: 'Email',
//                      hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                      fillColor: ptPrimaryColor(context),
//                      border: InputBorder.none,
//                      enabledBorder: InputBorder.none,
//                      disabledBorder: InputBorder.none,
//                      focusedBorder: InputBorder.none,
//                    ),
//                    onSubmitted: (String value) {},
//                  ),
//                  TextField(
//                    controller: passwordController,
//                    onSubmitted: (String value) {},
//                    obscureText: true,
//                    style: ptTitle(context),
//                    keyboardType: TextInputType.visiblePassword,
//                    decoration: InputDecoration(
//                      prefixIcon: Padding(
//                        padding: EdgeInsets.only(right: 20.0),
//                        child: Icon(
//                          Icons.lock,
//                          color: HexColor(appText60),
//                          size: 30.0,
//                        ),
//                      ),
//                      hintText: 'Mật khẩu',
//                      hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                      fillColor: ptPrimaryColor(context),
//                      border: InputBorder.none,
//                      enabledBorder: InputBorder.none,
//                      disabledBorder: InputBorder.none,
//                      focusedBorder: InputBorder.none,
//                    ),
//                    maxLines: 1,
//                  ),
//                  TextField(
//                    controller: confimPasswordController,
//                    onSubmitted: (String value) {},
//                    obscureText: true,
//                    style: ptTitle(context),
//                    keyboardType: TextInputType.visiblePassword,
//                    decoration: InputDecoration(
//                      prefixIcon: Padding(
//                        padding: EdgeInsets.only(right: 20.0),
//                        child: Icon(
//                          Icons.lock,
//                          color: HexColor(appText60),
//                          size: 30.0,
//                        ),
//                      ),
//                      hintText: 'Nhập lại mật khẩu',
//                      hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                      fillColor: ptPrimaryColor(context),
//                      border: InputBorder.none,
//                      enabledBorder: InputBorder.none,
//                      disabledBorder: InputBorder.none,
//                      focusedBorder: InputBorder.none,
//                    ),
//                    maxLines: 1,
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  _handlePhoneLogin() {
//    PhoneAuthHelper().verifyPhoneNumber(emailController.text);
//
////    Routing().navigate2(context, VerifyAccount());
//  }
//}
