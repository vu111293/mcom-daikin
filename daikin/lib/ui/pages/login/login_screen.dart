//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:loctroi/apis/net/user_service.dart';
//import 'package:loctroi/blocs/application_bloc.dart';
//import 'package:loctroi/blocs/bloc_provider.dart';
//import 'package:loctroi/constants/constants.dart';
//import 'package:loctroi/helper/phone_auth_helper.dart';
//import 'package:loctroi/models/user.dart';
//import 'package:loctroi/ui/customs/base_screen.dart';
//import 'package:loctroi/ui/customs/dialog.dart';
//import 'package:loctroi/ui/pages/home_screen.dart';
//import 'package:loctroi/ui/pages/login/confirm_number_phone_screen.dart';
//import 'package:loctroi/ui/pages/login/update_info_login_screen.dart';
//import 'package:loctroi/ui/route/routing.dart';
//import 'package:loctroi/utils/hex_color.dart';
//import 'package:loctroi/utils/scale_util.dart';
//
//class LoginScreen extends StatefulWidget {
//  LoginScreenState createState() => LoginScreenState();
//}
//
//class LoginScreenState extends State<LoginScreen> {
//  ApplicationBloc _appBloc;
//  TextEditingController phoneController = TextEditingController();
//  StreamSubscription _phoneAuthStream;
//  bool _isLoading = false;
//
//  String phone = '';
//
//  @override
//  void initState() {
//    _appBloc = BlocProvider.of<ApplicationBloc>(context);
//
//    _registerFbAuthResult();
//    super.initState();
//  }
//
//  _registerFbAuthResult() {
//    _phoneAuthStream?.cancel();
//    _phoneAuthStream = PhoneAuthHelper().authStream.listen((result) async {
//      print(result.status);
//      print(result.msg);
//      if (_isLoading) {
//        Navigator.pop(context);
//        _isLoading = false;
//      }
//      if (result.status == AuthStatus.CodeSent) {
//        _phoneAuthStream?.cancel();
//        Routing().navigate2(context, ConfirmNumberPhoneScreen(phone: phoneController.text)).then((v) {
//          _registerFbAuthResult();
//        });
//      } else if (result.status == AuthStatus.Verified) {
//        String uid = result.user.uid;
//        String token = (await result.user.getIdToken()).token;
//        print('FB|$uid|$token');
//        LUser user = await UserService().login('FB|$uid|$token');
//        _appBloc.getAuthBloc().updateUserAction(user);
//        _phoneAuthStream?.cancel();
//
//        if (user.isClientFilledInfo) {
//          Routing().popToRoot(context);
//          Routing().navigate2(context, HomeScreen(), replace: true);
//        } else {
//          Routing().navigate2(context, UpdateInfoLoginScreen(), replace: true);
//        }
//      } else if (result.status == AuthStatus.Timeout) {
////        showAlertDialog(context, 'Lỗi khi kết nối với máy chủ. Vui lòng thử lại');
//      } else {
//        showAlertDialog(context, 'Lỗi khi đăng nhập. Vui lòng thử lại');
//      }
//    });
//  }
//
//  @override
//  void dispose() {
//    _phoneAuthStream?.cancel();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ScaleUtil.instance = ScaleUtil.getInstance()..init(context);
//
//    return BaseScreen(
//      body: Container(
//        color: Colors.white,
//        child: Column(
//          children: <Widget>[
//            Container(
//              color: Colors.white,
//              alignment: Alignment.topCenter,
//              constraints: BoxConstraints(
//                minHeight: deviceHeight(context),
//              ),
//              child: Column(
//                children: <Widget>[
//                  Image.asset(
//                    "assets/images/bg_login.jpeg",
//                    fit: BoxFit.fitWidth,
//                    // alignment: Alignment.bottomCenter,
//                    width: deviceWidth(context),
//                    // height: ScaleUtil.getInstance().setHeight(350),
//                  ),
//                  Container(
//                    color: Colors.white,
//                    // padding: EdgeInsets.only(bottom: 130.0),
//                    // constraints: BoxConstraints(
//                    //   minHeight: deviceHeight(context) - ScaleUtil.getInstance().setHeight(120),
//                    // ),
//                    // margin: EdgeInsets.only(top: ScaleUtil.getInstance().setHeight(250)),
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
//                        Container(
//                          margin: EdgeInsets.symmetric(horizontal: ScaleUtil.getInstance().setWidth(30)),
//                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                          child: TextField(
//                            controller: phoneController,
//                            maxLines: 1,
//                            textAlign: TextAlign.center,
//                            keyboardType: TextInputType.number,
//                            cursorColor: ptPrimaryColor(context),
//                            style: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
//                            decoration: InputDecoration(
//                              hintText: 'Số điện thoại đăng nhập',
//                              // hintStyle: ptTitle(context).copyWith(),
//                              fillColor: ptPrimaryColor(context),
//                              focusedBorder: OutlineInputBorder(
//                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                borderSide: BorderSide(color: ptPrimaryColor(context), width: 3),
//                              ),
//                              enabledBorder: OutlineInputBorder(
//                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                borderSide: BorderSide(color: HexColor(appText60), width: 3),
//                              ),
//                            ),
//                            onSubmitted: (String value) {
//                              if (this.phone.length > 8) {
//                                _handlePhoneLogin();
//                              }
//                            },
//                            onChanged: (String value) {
//                              setState(() {
//                                this.phone = value;
//                              });
//                            },
//                          ),
//                        ),
//                        Container(
//                          alignment: Alignment.centerRight,
//                          margin: EdgeInsets.symmetric(horizontal: ScaleUtil.getInstance().setWidth(40)),
//                          padding: EdgeInsets.only(top: 10.0),
//                          child: Opacity(
//                            opacity: this.phone.length < 9 ? 0.5 : 1,
//                            child: RaisedButton(
//                              onPressed: _handlePhoneLogin,
//                              shape: RoundedRectangleBorder(
//                                  side: BorderSide(color: ptPrimaryColor(context), width: 4, style: BorderStyle.solid),
//                                  borderRadius: BorderRadius.circular(10)),
//                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                              child: Text(
//                                "Đăng Nhập".toUpperCase(),
//                                style: ptTitle(context).copyWith(color: Colors.white),
//                              ),
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Image.asset(
//              "assets/images/home_bottom.png",
//              width: deviceWidth(context),
//              fit: BoxFit.cover,
//              alignment: Alignment.bottomCenter,
//              // height: 130,
//            ),
//          ],
//        ),
//      ),
//      // bottomBar:
//    );
//  }
//
//  _handlePhoneLogin() {
//    _isLoading = true;
//    if (phoneController.text.isNotEmpty && this.phone.length > 8) {
//      showWaitingDialog(context);
//      PhoneAuthHelper().verifyPhoneNumber(phoneController.text);
//    } else {
//      showAlertDialog(context, 'Vui lòng nhập số điện thoại chính xác');
//    }
//  }
//}
