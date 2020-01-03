import 'dart:async';

import 'package:daikin/ui/pages/login/confirm_number_phone_screen.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:daikin/apis/net/user_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
// import 'package:daikin/helper/phone_auth_helper.dart';
import 'package:daikin/models/user.dart';
import 'package:daikin/ui/customs/base_screen.dart';
import 'package:daikin/ui/customs/dialog.dart';
// import 'package:daikin/ui/pages/home_screen.dart';
// import 'package:daikin/ui/pages/login/confirm_number_phone_screen.dart';
// import 'package:daikin/ui/pages/login/update_info_login_screen.dart';
// import 'package:daikin/ui/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:daikin/utils/scale_util.dart';

class LoginScreen extends StatefulWidget {
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  ApplicationBloc _appBloc;
  TextEditingController phoneController = TextEditingController();
  StreamSubscription _phoneAuthStream;
  bool _isLoading = false;

  String phone = '';

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);

    //  _registerFbAuthResult();
    super.initState();
  }

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

//        if (user.isClientFilledInfo) {
//          Routing().popToRoot(context);
//          Routing().navigate2(context, HomeScreen(), replace: true);
//        } else {
//          Routing().navigate2(context, UpdateInfoLoginScreen(), replace: true);
//        }
//      } else if (result.status == AuthStatus.Timeout) {
// //        showAlertDialog(context, 'Lỗi khi kết nối với máy chủ. Vui lòng thử lại');
//      } else {
//        showAlertDialog(context, 'Lỗi khi đăng nhập. Vui lòng thử lại');
//      }
//    });
//  }

  @override
  void dispose() {
    _phoneAuthStream?.cancel();
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Đăng nhập'.toUpperCase(), style: ptDisplay1(context).copyWith(color: HexColor(appText))),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScaleUtil.getInstance().setHeight(8), bottom: ScaleUtil.getInstance().setHeight(20)),
                      child: Text(
                        'Hệ thống Bệnh viện Cây ăn quả được thành lập bởi sự hợp tác giữa Viện Cây Ăn Quả Miền Nam & Tập Đoàn Lộc Trời',
                        style: ptSubtitle(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScaleUtil.getInstance().setWidth(30)),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextField(
                        controller: phoneController,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        cursorColor: ptPrimaryColor(context),
                        style: ptTitle(context).copyWith(),
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại',
                          hintText: 'Số điện thoại đăng nhập',
                          labelStyle: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
                        ),
                        onSubmitted: (String value) {
                          if (this.phone.length > 8) {
                            _handlePhoneLogin();
                          }
                        },
                        onChanged: (String value) {
                          setState(() {
                            this.phone = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: kToolbarHeight / 2),
                  child: Opacity(
                    opacity: this.phone.length < 9 ? 0.5 : 1,
                    child: RaisedButton(
                      onPressed: _handlePhoneLogin,
                      shape: StadiumBorder(),
                      color: ptPrimaryColor(context),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Text(
                        "Tiếp tục".toUpperCase(),
                        style: ptTitle(context).copyWith(color: Colors.white),
                      ),
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

  _handlePhoneLogin() {
    _isLoading = true;
    if (phoneController.text.isNotEmpty && this.phone.length > 8) {
      showWaitingDialog(context);
      //  PhoneAuthHelper().verifyPhoneNumber(phoneController.text);
      Routing().navigate2(context, ConfirmNumberPhoneScreen(phone: phoneController.text));
      showAlertDialog(context, 'Đăng nhập thành công');
    } else {
      showAlertDialog(context, 'Vui lòng nhập số điện thoại chính xác');
    }
  }
}
