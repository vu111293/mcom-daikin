//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:loctroi/apis/core/auth_service.dart';
//import 'package:loctroi/apis/net/user_service.dart';
//import 'package:loctroi/blocs/application_bloc.dart';
//import 'package:loctroi/blocs/bloc_provider.dart';
//import 'package:loctroi/constants/constants.dart';
//import 'package:loctroi/helper/phone_auth_helper.dart';
//import 'package:loctroi/models/user.dart';
//import 'package:loctroi/ui/customs/base_screen.dart';
//import 'package:loctroi/ui/customs/dialog.dart';
//import 'package:loctroi/ui/pages/advisory_screen.dart';
//import 'package:loctroi/ui/pages/login/update_info_login_doctor_screen.dart';
//import 'package:loctroi/ui/route/routing.dart';
//import 'package:loctroi/utils/hex_color.dart';
//import 'package:loctroi/utils/scale_util.dart';
//
//class LoginDoctorScreen extends StatefulWidget {
//  LoginDoctorScreenState createState() => LoginDoctorScreenState();
//}
//
//class LoginDoctorScreenState extends State<LoginDoctorScreen> {
//  ApplicationBloc _appBloc;
//  TextEditingController emailController = TextEditingController();
//  TextEditingController passwordController = TextEditingController();
////  TextEditingController emailController = TextEditingController(text: 'manh.x.mai@loctroi.vn');
////  TextEditingController passwordController = TextEditingController(text: '123456');
////  TextEditingController emailController = TextEditingController(text: 'doctor01@gmail.com');
////  TextEditingController passwordController = TextEditingController(text: '111111');
//  StreamSubscription _phoneAuthStream;
//  final focus = FocusNode();
//  String email = '';
//  String pass = '';
//  @override
//  void initState() {
//    _appBloc = BlocProvider.of<ApplicationBloc>(context);
//    _registerFbAuthResult();
//    super.initState();
//  }
//
//  _registerFbAuthResult() {
//    _phoneAuthStream?.cancel();
//    _phoneAuthStream = PhoneAuthHelper().authStream.listen((result) async {
//      if (result.status == AuthStatus.Verified) {
//        // do login and cache token
//        String uid = result.user.uid;
//        String token = (await result.user.getIdToken()).token;
//        print('FB|$uid|$token');
//        LUser user = await UserService().login('FB|$uid|$token').catchError((e) {
//          print(e);
//        });
//        Navigator.pop(context);
//
//        if (user.isEditor) {
//          LoopBackAuth().clear();
//          showAlertWithTitleDialog(context, 'Giới hạn đăng nhập',
//              'Bạn không thể đăng nhập với tài khoản biên tập viên. Vui lòng sử dụng tài khoản bác sĩ');
//        } else {
//          _appBloc.getAuthBloc().updateUserAction(user);
//          _phoneAuthStream?.cancel();
//
//          if (user.isDoctorFilledInfo) {
//            Routing().popToRoot(context);
//            Routing().navigate2(context, AdvisoryScreen(), replace: true);
//          } else {
//            Routing().navigate2(context, UpdateInfoLoginDoctorScreen(), replace: true);
//          }
//        }
//      } else {
//        Navigator.pop(context);
//        showAlertDialog(context, 'Email hoặc mật khẩu không đúng. Vui lòng thử lại');
//      }
//    });
//  }
//
//  @override
//  void dispose() {
//    _phoneAuthStream.cancel();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ScaleUtil.instance = ScaleUtil.getInstance()..init(context);
//
//    return Container(
//      color: Colors.white,
//      child: BaseScreen(
//        body: Container(
//          color: Colors.white,
//          child: Column(
//            children: <Widget>[
//              Image.asset(
//                "assets/images/bg_login.jpeg",
//                fit: BoxFit.fitWidth,
//                // alignment: Alignment.bottomCenter,
//                width: deviceWidth(context),
//                // height: ScaleUtil.getInstance().setHeight(350),
//              ),
//              Container(
//                color: Colors.white,
//                // padding: EdgeInsets.only(bottom: 130.0),
//                // constraints: BoxConstraints(
//                //   minHeight: deviceHeight(context) - ScaleUtil.getInstance().setHeight(120),
//                // ),
//                // margin: EdgeInsets.only(top: ScaleUtil.getInstance().setHeight(250)),
//                child: Padding(
//                    padding: EdgeInsets.symmetric(horizontal: ScaleUtil.getInstance().setWidth(30)),
//                    child: Column(
//                      // crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        // CircleAvatar(
//                        //   backgroundColor: Colors.white,
//                        //   radius: ScaleUtil.getInstance().setWidth(80),
//                        //   child: Image.asset(
//                        //     "assets/images/logo2.png",
//                        //     width: ScaleUtil.getInstance().setWidth(150),
//                        //     fit: BoxFit.contain,
//                        //   ),
//                        // ),
//                        // Text('Bệnh viện cây ăn quả'.toUpperCase(),
//                        //     style: ptHeadline(context)
//                        //         .copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.bold)),
//                        // Padding(
//                        //   padding: EdgeInsets.only(
//                        //       top: ScaleUtil.getInstance().setHeight(8), bottom: ScaleUtil.getInstance().setHeight(20)),
//                        //   child: Text(
//                        //     'Hệ thống Bệnh viện Cây ăn quả được thành lập bởi sự hợp tác giữa Viện Cây Ăn Quả Miền Nam & Tập Đoàn Lộc Trời',
//                        //     style: ptSubtitle(context),
//                        //     textAlign: TextAlign.center,
//                        //   ),
//                        // ),
//                        // Padding(
//                        //   padding: EdgeInsets.only(bottom: ScaleUtil.getInstance().setHeight(30)),
//                        //   child: Text('www.benhviencayanqua.vn',
//                        //       style: ptSubtitle(context).copyWith(color: ptPrimaryColor(context))),
//                        // ),
//
//                        Column(
//                          children: <Widget>[
//                            TextField(
//                              controller: emailController,
//                              onChanged: (String value) {
//                                setState(() {
//                                  this.email = value;
//                                });
//                              },
//                              textInputAction: TextInputAction.next,
//                              maxLines: 1,
//                              keyboardType: TextInputType.emailAddress,
//                              cursorColor: ptPrimaryColor(context),
//                              textAlign: TextAlign.center,
//                              style: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
//                              decoration: InputDecoration(
//                                hintText: 'Email',
//                                // hintStyle: ptTitle(context).copyWith(),
//                                fillColor: ptPrimaryColor(context),
//                                focusedBorder: OutlineInputBorder(
//                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                  borderSide: BorderSide(color: ptPrimaryColor(context), width: 3),
//                                ),
//                                enabledBorder: OutlineInputBorder(
//                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                  borderSide: BorderSide(color: HexColor(appText60), width: 3),
//                                ),
//                              ),
//                              onSubmitted: (String value) {
//                                FocusScope.of(context).requestFocus(focus);
//                              },
//                            ),
//                            SizedBox(height: 10),
//                            TextField(
//                              controller: passwordController,
//                              onChanged: (String value) {
//                                setState(() {
//                                  this.pass = value;
//                                });
//                              },
//                              focusNode: focus,
//                              onSubmitted: (String value) {
//                                _handlePhoneLogin();
//                              },
//                              maxLines: 1,
//                              obscureText: true,
//                              keyboardType: TextInputType.visiblePassword,
//                              cursorColor: ptPrimaryColor(context),
//                              textAlign: TextAlign.center,
//                              style: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
//                              decoration: InputDecoration(
//                                hintText: 'Mật khẩu',
//                                // hintStyle: ptTitle(context).copyWith(),
//                                fillColor: ptPrimaryColor(context),
//                                focusedBorder: OutlineInputBorder(
//                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                  borderSide: BorderSide(color: ptPrimaryColor(context), width: 3),
//                                ),
//                                enabledBorder: OutlineInputBorder(
//                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                  borderSide: BorderSide(color: HexColor(appText60), width: 3),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                        InkWell(
//                          child: Container(
//                            padding: EdgeInsets.only(top: 24.0, right: 10),
//                            alignment: Alignment.centerRight,
//                            child: RichText(
//                                text: TextSpan(children: [
//                              TextSpan(text: 'Chưa có tài khoản? ', style: ptSubhead(context).copyWith(fontSize: 18.0)),
//                              TextSpan(
//                                  text: "Đăng ký",
//                                  style: ptSubhead(context).copyWith(
//                                      fontSize: 18.0, fontWeight: FontWeight.bold, color: ptPrimaryColor(context)))
//                            ])),
//                          ),
//                          onTap: _handleRegister,
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(top: 18.0),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.end,
//                            children: <Widget>[
//                              // FlatButton(
//                              //   onPressed: _handleRegister,
//                              //   shape: RoundedRectangleBorder(
//                              //       side:
//                              //           BorderSide(color: ptPrimaryColor(context), width: 4, style: BorderStyle.solid),
//                              //       borderRadius: BorderRadius.circular(10)),
//                              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                              //   child: Text(
//                              //     "Đăng Ký".toUpperCase(),
//                              //     style: ptTitle(context).copyWith(color: Colors.black),
//                              //   ),
//                              // ),
//                              Opacity(
//                                opacity: this.pass.length > 5 && this.email != '' ? 1 : 0.5,
//                                child: RaisedButton(
//                                  onPressed: _handlePhoneLogin,
//                                  shape: RoundedRectangleBorder(
//                                      side: BorderSide(
//                                          color: ptPrimaryColor(context), width: 4, style: BorderStyle.solid),
//                                      borderRadius: BorderRadius.circular(10)),
//                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                  child: Text(
//                                    "Đăng Nhập".toUpperCase(),
//                                    style: ptTitle(context).copyWith(color: Colors.white),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        )
//                      ],
//                    )),
//              ),
//              Image.asset(
//                "assets/images/home_bottom.png",
//                width: deviceWidth(context),
//                fit: BoxFit.cover,
//                alignment: Alignment.bottomCenter,
//                // height: 130,
//              ),
//            ],
//          ),
//        ),
//        // bottomBar:
//      ),
//    );
//  }
//
//  _handlePhoneLogin() {
//    String email = emailController.text;
//    String password = passwordController.text;
//    if (email.isNotEmpty && password.isNotEmpty) {
//      showWaitingDialog(context);
//      PhoneAuthHelper().loginWithEmailVsPassword(email?.trim(), password?.trim());
//    } else {
//      showAlertDialog(context, 'Vui lòng nhập đủ các trường được yêu cầu');
//    }
//  }
//
//  _handleRegister() {
//    showAlertDialog(context, 'Vui lòng liên hệ biên tập viên để được tạo tài khoản bác sĩ cho bạn.');
////    Routing().navigate2(context, RegisterDoctorScreen());
//  }
//}
