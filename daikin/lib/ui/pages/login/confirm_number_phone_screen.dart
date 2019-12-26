//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:loctroi/apis/net/user_service.dart';
//import 'package:loctroi/blocs/application_bloc.dart';
//import 'package:loctroi/blocs/bloc_provider.dart';
//import 'package:loctroi/constants/constants.dart';
//import 'package:loctroi/helper/phone_auth_helper.dart';
//import 'package:loctroi/models/user.dart';
//import 'package:loctroi/ui/customs/base_screen.dart';
//import 'package:loctroi/ui/customs/dialog.dart';
//import 'package:loctroi/ui/pages/home_screen.dart';
//import 'package:loctroi/ui/pages/login/update_info_login_screen.dart';
//import 'package:loctroi/ui/route/routing.dart';
//import 'package:loctroi/utils/scale_util.dart';
//import 'package:pin_code_text_field/pin_code_text_field.dart';
//import 'package:toast/toast.dart';
//
//class ConfirmNumberPhoneScreen extends StatefulWidget {
//  final String phone;
//  ConfirmNumberPhoneScreen({
//    Key key,
//    this.phone,
//  }) : super(key: key);
//  ConfirmNumberPhoneScreenState createState() => ConfirmNumberPhoneScreenState();
//}
//
//class ConfirmNumberPhoneScreenState extends State<ConfirmNumberPhoneScreen> {
//  ApplicationBloc _appBloc;
//  StreamSubscription _authStream;
//  TextEditingController controller = TextEditingController();
//  String thisText = "";
//  int pinLength = 4;
//
//  bool hasError = false;
//  String errorMessage;
//  bool _isLoading = false;
//
//  @override
//  void initState() {
//    _appBloc = BlocProvider.of<ApplicationBloc>(context);
//    _registerFbAuthResult();
//    super.initState();
//  }
//
//  _registerFbAuthResult() {
//    _authStream?.cancel();
//    _authStream = PhoneAuthHelper().authStream.listen((result) async {
//      if (_isLoading) {
//        Navigator.pop(context);
//      }
//      if (result.status == AuthStatus.CodeSent) {
//        Toast.show("Mã xác thực đã được gửi đến bạn. Vui lòng kiểm tra", context);
//
//      } else if (result.status == AuthStatus.Verified) {
//        // do login and cache token
//        String uid = result.user.uid;
//        String token = (await result.user.getIdToken()).token;
//        print('FB|$uid|$token');
//        LUser user = await UserService().login('FB|$uid|$token');
//        _appBloc.getAuthBloc().updateUserAction(user);
//        _authStream?.cancel();
//        Routing().popToRoot(context);
//        if (user.isClientFilledInfo) {
//          Routing().navigate2(context, HomeScreen());
//        } else {
//          Routing().navigate2(context, UpdateInfoLoginScreen());
//        }
//      } else if (result.status == AuthStatus.Timeout) {
//        print('TIME OUT');
//      } else {
//        showAlertDialog(context, 'Xãy ra lỗi khi đăng nhập');
//      }
//    });
//  }
//
//  @override
//  void dispose() {
//    _authStream.cancel();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ScaleUtil.instance = ScaleUtil.getInstance()..init(context);
//    return BaseScreen(
//      body: Column(
//        children: <Widget>[
//          Image.asset(
//            "assets/images/bg_login.jpeg",
//            fit: BoxFit.fitWidth,
//            // alignment: Alignment.bottomCenter,
//            width: deviceWidth(context),
//            // height: ScaleUtil.getInstance().setHeight(350),
//          ),
//          Container(
//            color: Colors.white,
//            // constraints: BoxConstraints(
//            //   minHeight: deviceHeight(context) - ScaleUtil.getInstance().setHeight(120),
//            // ),
//            // margin: EdgeInsets.only(top: ScaleUtil.getInstance().setHeight(250)),
//            child: Column(
//              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.symmetric(horizontal: ScaleUtil.getInstance().setWidth(30)),
//                  child: Column(
//                    // crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      // CircleAvatar(
//                      //   backgroundColor: Colors.white,
//                      //   radius: ScaleUtil.getInstance().setWidth(80),
//                      //   child: Image.asset(
//                      //     "assets/images/logo2.png",
//                      //     width: ScaleUtil.getInstance().setWidth(150),
//                      //     fit: BoxFit.contain,
//                      //   ),
//                      // ),
//
//                      // Text('Bệnh viện cây ăn quả'.toUpperCase(),
//                      //     style: ptHeadline(context)
//                      //         .copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.bold)),
//                      // Padding(
//                      //   padding: EdgeInsets.only(
//                      //       top: ScaleUtil.getInstance().setHeight(8), bottom: ScaleUtil.getInstance().setHeight(20)),
//                      //   child: Text(
//                      //     'Hệ thống Bệnh viện Cây ăn quả được thành lập bởi sự hợp tác giữa Viện Cây Ăn Quả Miền Nam & Tập Đoàn Lộc Trời',
//                      //     style: ptSubtitle(context),
//                      //     textAlign: TextAlign.center,
//                      //   ),
//                      // ),
//                      // Padding(
//                      //   padding: EdgeInsets.only(bottom: ScaleUtil.getInstance().setHeight(30)),
//                      //   child: Text('www.benhviencayanqua.vn',
//                      //       style: ptSubtitle(context).copyWith(color: ptPrimaryColor(context))),
//                      // ),
//                      // // Text('XÁC NHẬN', style: ptHeadline(context).copyWith(fontSize: 30)),
//                      Padding(
//                        padding: EdgeInsets.only(
//                            top: ScaleUtil.getInstance().setHeight(8), bottom: ScaleUtil.getInstance().setHeight(20)),
//                        child: RichText(
//                            text: TextSpan(children: [
//                          TextSpan(
//                              text: 'Vui lòng nhập mã 6 số trong tin nhắn SMS mà chúng tôi vừa gửi qua số  ',
//                              style: TextStyle(fontSize: 18.0, color: Colors.black)),
//                          TextSpan(
//                              text: widget.phone.toString(),
//                              style: ptSubhead(context).copyWith(height: 1.5, fontWeight: FontWeight.bold))
//                        ])),
//                      ),
//                      Container(
//                        width: deviceWidth(context),
//                        child: PinCodeTextField(
//                          autofocus: false,
//                          controller: controller,
//                          highlight: true,
//                          highlightColor: Colors.blue,
//                          defaultBorderColor: Colors.black,
//                          hasTextBorderColor: Colors.green,
//                          maxLength: 6,
//                          hasError: hasError,
//                          onTextChanged: (text) {
//                            setState(() {});
//                          },
//                          isCupertino: true,
//                          pinBoxWidth: deviceWidth(context) / 7,
//                          pinBoxHeight: 50,
//                          pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
//                          wrapAlignment: WrapAlignment.start,
//                          pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
//                          pinTextStyle: TextStyle(fontSize: 30.0),
//                          pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
//                          pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
//                          keyboardType: TextInputType.number,
//                        ),
//                      ),
//                      Visibility(
//                        visible: hasError,
//                        child: Padding(
//                          padding: EdgeInsets.only(top: ScaleUtil.getInstance().setHeight(10)),
//                          child: Text(
//                            "Sai mã pin!",
//                            style: TextStyle(color: Colors.red),
//                          ),
//                        ),
//                      ),
//                      InkWell(
//                          child: Container(
//                            padding: EdgeInsets.only(
//                                top: ScaleUtil.getInstance().setHeight(24),
//                                right: ScaleUtil.getInstance().setWidth(10)),
//                            alignment: Alignment.centerRight,
//                            child: RichText(
//                                text: TextSpan(children: [
//                              TextSpan(text: 'Chưa nhận được? ', style: ptSubhead(context).copyWith(fontSize: 18.0)),
//                              TextSpan(
//                                  text: "Gửi lại",
//                                  style: ptSubhead(context).copyWith(
//                                      fontSize: 18.0, fontWeight: FontWeight.bold, color: ptPrimaryColor(context)))
//                            ])),
//                          ),
//                          onTap: () {
//                            Navigator.pop(context);
////                            _isLoading = true;
////                            showWaitingDialog(context);
////                            PhoneAuthHelper().verifyPhoneNumber(widget.phone);
//                          }),
//                      Container(
//                          child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Container(
//                              alignment: Alignment.center,
//                              padding: EdgeInsets.only(
//                                  top: ScaleUtil.getInstance().setHeight(24),
//                                  right: ScaleUtil.getInstance().setWidth(10)),
//                              child: FlatButton(
//                                onPressed: () {
//                                  Navigator.pop(context);
//                                },
//                                // shape: RoundedRectangleBorder(
//                                //     side:
//                                //         BorderSide(color: ptPrimaryColor(context), width: 4, style: BorderStyle.solid),
//                                //     borderRadius: BorderRadius.circular(10)),
//                                padding: EdgeInsets.symmetric(
//                                    horizontal: ScaleUtil.getInstance().setWidth(20),
//                                    vertical: ScaleUtil.getInstance().setHeight(19)),
//                                child: Text(
//                                  "Quay lại",
//                                  style: ptBody1(context).copyWith(color: Colors.black),
//                                ),
//                              )),
//                          Container(
//                            alignment: Alignment.center,
//                            padding: EdgeInsets.only(
//                                top: ScaleUtil.getInstance().setHeight(24), left: ScaleUtil.getInstance().setWidth(10)),
//                            child: RaisedButton(
//                              onPressed: _handleVerifyCode,
//                              shape: RoundedRectangleBorder(
//                                  side: BorderSide(color: ptPrimaryColor(context), width: 4, style: BorderStyle.solid),
//                                  borderRadius: BorderRadius.circular(10)),
//                              padding: EdgeInsets.symmetric(
//                                  horizontal: ScaleUtil.getInstance().setWidth(20),
//                                  vertical: ScaleUtil.getInstance().setHeight(15)),
//                              child: Text(
//                                "Xác nhận",
//                                style: ptTitle(context).copyWith(color: Colors.white),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ))
//                    ],
//                  ),
//                ),
//                Image.asset(
//                  "assets/images/home_bottom.png",
//                  width: deviceWidth(context),
//                  fit: BoxFit.contain,
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//      // bottomBar: Container(
//      //   height: 72.0,
//      //   color: ptPrimaryColor(context),
//      //   child: Row(
//      //     children: <Widget>[
//      //       Expanded(
//      //         child: Container(
//      //           decoration: BoxDecoration(
//      //             border: Border(
//      //               top: BorderSide(
//      //                 color: Colors.black26,
//      //                 width: 1,
//      //               ),
//      //             ),
//      //             color: Colors.white,
//      //           ),
//      //           height: 72.0,
//      //           child: InkWell(
//      //             onTap: () {
//      //               Navigator.pop(context);
//      //             },
//      //             child: Padding(
//      //               padding: EdgeInsets.only(left: 30.0),
//      //               child: Row(
//      //                 mainAxisAlignment: MainAxisAlignment.start,
//      //                 crossAxisAlignment: CrossAxisAlignment.center,
//      //                 children: <Widget>[
//      //                   Icon(
//      //                     Icons.arrow_back,
//      //                     color: ptPrimaryColor(context),
//      //                     size: 25.0,
//      //                   ),
//      //                   Padding(
//      //                     padding: EdgeInsets.only(left: 10.0),
//      //                     child: Text(
//      //                       "Trở lại",
//      //                       style: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
//      //                     ),
//      //                   ), // text
//      //                   // icon
//      //                 ],
//      //               ),
//      //             ),
//      //           ),
//      //         ),
//      //       ),
//      //       Expanded(
//      //         child: Container(
//      //           height: 72.0,
//      //           child: InkWell(
//      //             onTap: _handleVerifyCode,
//      //             child: Padding(
//      //               padding: EdgeInsets.only(right: 30.0),
//      //               child: Row(
//      //                 mainAxisAlignment: MainAxisAlignment.end,
//      //                 crossAxisAlignment: CrossAxisAlignment.center,
//      //                 children: <Widget>[
//      //                   Padding(
//      //                     padding: EdgeInsets.only(right: 10.0),
//      //                     child: Text(
//      //                       "Tiếp tục",
//      //                       style: ptTitle(context).copyWith(color: Colors.white),
//      //                     ),
//      //                   ), // text
//      //                   Icon(
//      //                     Icons.arrow_forward,
//      //                     color: Colors.white,
//      //                     size: 25.0,
//      //                   ), // icon
//      //                 ],
//      //               ),
//      //             ),
//      //           ),
//      //         ),
//      //       ),
//      //     ],
//      //   ),
//      // ),
//    );
//  }
//
//  _handleVerifyCode() {
//    String code = controller.text;
//    if (code.length == 6) {
//      _isLoading = true;
//      showWaitingDialog(context);
//      PhoneAuthHelper().validateCode(code);
//    }
//  }
//}
