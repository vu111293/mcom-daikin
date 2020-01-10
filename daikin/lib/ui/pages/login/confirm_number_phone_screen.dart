import 'dart:async';

import 'package:daikin/apis/net/user_service.dart';
import 'package:daikin/ui/pages/home/home_screen.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/ui/setting/profile_screen.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:daikin/utils/phone_auth.dart';
import 'package:flutter/material.dart';
// import 'package:daikin/apis/net/user_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
// import 'package:daikin/helper/phone_auth_helper.dart';
import 'package:daikin/models/user.dart';
import 'package:daikin/ui/customs/base_screen.dart';
import 'package:daikin/ui/customs/dialog.dart';
// import 'package:daikin/ui/pages/home_screen.dart';
import 'package:daikin/ui/pages/login/update_info_login_screen.dart';
// import 'package:daikin/ui/route/routing.dart';
import 'package:daikin/utils/scale_util.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../main.dart';
// import 'package:toast/toast.dart';

class ConfirmNumberPhoneScreen extends StatefulWidget {
  final String phone;
  ConfirmNumberPhoneScreen({
    Key key,
    this.phone,
  }) : super(key: key);
  ConfirmNumberPhoneScreenState createState() =>
      ConfirmNumberPhoneScreenState();
}

class ConfirmNumberPhoneScreenState extends State<ConfirmNumberPhoneScreen> {
  ApplicationBloc _appBloc;
  StreamSubscription _authStream;
  TextEditingController controller = TextEditingController();
  String thisText = "";
  int pinLength = 4;

  bool hasError = false;
  String errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    _registerFbAuthResult();
    super.initState();
  }

  _registerFbAuthResult() {
    _authStream?.cancel();
    _authStream = PhoneAuthUtils().authStream.listen((result) async {
      if (_isLoading) {
        Navigator.pop(context);
      }
      if (result.status == AuthStatus.CodeSent) {
        // Toast.show(
        //     "Mã xác thực đã được gửi đến bạn. Vui lòng kiểm tra", context);
      } else if (result.status == AuthStatus.Verified) {
        // do login and cache token
        String uid = result.user.uid;
        String token = (await result.user.getIdToken()).token;
        print('FB|$uid|$token');
        LUser user = await UserService().login('FB|$uid|$token');
        _appBloc.authBloc.updateUserAction(user);
        _authStream?.cancel();
        Routing().popToRoot(context);
        Routing().navigate2(context, MainScreen());
      } else if (result.status == AuthStatus.Timeout) {
        print('TIME OUT');
      } else {
        showAlertDialog(context, 'Xãy ra lỗi khi đăng nhập');
      }
    });
  }

  @override
  void dispose() {
    _authStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScaleUtil.instance = ScaleUtil.getInstance()..init(context);

    return BaseScreen(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          alignment: Alignment.center,
          height: deviceHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: kToolbarHeight),
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/app_logo2.png',
                    fit: BoxFit.contain,
                    width: deviceWidth(context) * 0.6,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Đăng nhập'.toUpperCase(),
                        style: ptDisplay1(context)
                            .copyWith(color: HexColor(appText))),
                    Padding(
                      padding: EdgeInsets.only(
                        top: ScaleUtil.getInstance().setHeight(8),
                        bottom: ScaleUtil.getInstance().setHeight(40),
                        left: ScaleUtil.getInstance().setHeight(16),
                        right: ScaleUtil.getInstance().setHeight(16),
                      ),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'Vui lòng nhập mã 6 số trong tin nhắn SMS mà chúng tôi vừa gửi qua số  ',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black)),
                            TextSpan(
                                text: widget.phone.toString(),
                                style: ptSubhead(context).copyWith(
                                    height: 1.5, fontWeight: FontWeight.bold))
                          ])),
                    ),
                    Container(
                      width: deviceWidth(context),
                      alignment: Alignment.center,
                      child: PinCodeTextField(
                        autofocus: false,
                        controller: controller,
                        highlight: true,
                        highlightColor: ptPrimaryColor(context),
                        defaultBorderColor: HexColor(appBorderColor),
                        hasTextBorderColor: ptPrimaryColor(context),
                        maxLength: 6,
                        hasError: hasError,
                        onTextChanged: (text) {
                          setState(() {});
                        },
                        pinBoxWidth: deviceWidth(context) / 8,
                        pinBoxHeight: 50,
                        wrapAlignment: WrapAlignment.center,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                        pinBoxRadius: 5,
                        pinTextStyle: ptHeadline(context),
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                            Duration(milliseconds: 300),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Visibility(
                      visible: hasError,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: ScaleUtil.getInstance().setHeight(10)),
                        child: Text(
                          "Sai mã pin!",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    InkWell(
                        child: Container(
                          padding: EdgeInsets.only(
                              right: ScaleUtil.getInstance().setWidth(10)),
                          alignment: Alignment.centerRight,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Chưa nhận được? ',
                                style: ptSubhead(context).copyWith()),
                            TextSpan(
                                text: "Gửi lại",
                                style: ptSubhead(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ptPrimaryColor(context)))
                          ])),
                        ),
                        onTap: () async {
                          await PhoneAuthUtils().verifyPhoneNumber(widget.phone);
                          showAlertDialog(context, "Đã gửi");
                        }),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: kToolbarHeight / 2),
                  child: RaisedButton(
                    onPressed: () {
                      _handleVerifyCode();
                    },
                    shape: StadiumBorder(),
                    color: ptPrimaryColor(context),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text(
                      "Xác nhận".toUpperCase(),
                      style: ptTitle(context).copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _handleVerifyCode() {
    String code = controller.text;
    if (code.length == 6) {
      _isLoading = true;
      showWaitingDialog(context);
      // Routing().navigate2(context, ProfileScreen(isLogin: true));

      PhoneAuthUtils().validateCode(code);
    }
  }
}
