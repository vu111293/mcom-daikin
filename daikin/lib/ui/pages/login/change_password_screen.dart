//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//
//class ChangePasswordScreen extends StatefulWidget {
//  ChangePasswordScreenState createState() => ChangePasswordScreenState();
//}
//
//class ChangePasswordScreenState extends State<ChangePasswordScreen> {
//  ApplicationBloc _appBloc;
//  TextEditingController emailController = TextEditingController();
//  TextEditingController currentPwdController = TextEditingController();
//  TextEditingController newPwdController = TextEditingController();
//  TextEditingController confirmNewPwdController = TextEditingController();
//  StreamSubscription _phoneAuthStream;
//  final _formKey = GlobalKey<FormState>();
//
//  // For check password strength
//  RegExp regex1 = new RegExp(r'^(?=.*?[A-Z])');
//  RegExp regex2 = new RegExp(r'^(?=.*?[a-z])');
//  RegExp regex3 = new RegExp(r'^(?=.*?[0-9])');
//  RegExp regex4 = new RegExp(r'^(?=.*?[!@#\$&*~]).{1,}$');
//
//  bool checkPass1 = false;
//  bool checkPass2 = false;
//  bool checkPass3 = false;
//  bool checkPass4 = false;
//
//  @override
//  void initState() {
//    _appBloc = BlocProvider.of<ApplicationBloc>(context);
//    super.initState();
//    _registerFbAuthResult();
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
//    int doneStep = [
//      checkPass1,
//      checkPass2,
//      checkPass3,
//      checkPass4,
//    ].where((i) => i == true).toList().length;
//    double processBar = 0;
//    String titleProcessBar = '';
//    Color colorProcessBar = Colors.transparent;
//    switch (doneStep) {
//      case 1:
//        processBar = 0.3;
//        titleProcessBar = 'Yếu';
//
//        colorProcessBar = Colors.red;
//        break;
//      case 2:
//        processBar = 0.5;
//        titleProcessBar = 'Trung bình';
//        colorProcessBar = Colors.orange;
//        break;
//      case 3:
//        processBar = 0.7;
//        titleProcessBar = 'Mạnh';
//        colorProcessBar = Colors.yellow;
//        break;
//      case 4:
//        processBar = 1.3;
//        titleProcessBar = 'Rất mạnh';
//        colorProcessBar = ptPrimaryColor(context);
//        break;
//      default:
//        processBar = 0;
//    }
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
//                    width: deviceWidth(context),
//                  ),
//                  Container(
//                    color: Colors.white,
//                    child: Form(
//                        key: _formKey,
//                        child: Padding(
//                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Padding(
//                                  padding: EdgeInsets.symmetric(vertical: 12.0),
//                                  child: Text('ĐỔI MẬT KHẨU',
//                                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))),
//                              TextFormField(
//                                controller: currentPwdController,
//                                obscureText: true,
//                                style: ptTitle(context),
//                                keyboardType: TextInputType.visiblePassword,
//                                decoration: InputDecoration(
//                                  prefixIcon: Padding(
//                                    padding: EdgeInsets.only(right: 20.0),
//                                    child: Icon(
//                                      Icons.lock,
//                                      color: HexColor(appText60),
//                                      size: 30.0,
//                                    ),
//                                  ),
//                                  hintText: 'Mật khẩu hiện tại',
//                                  hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                                  fillColor: ptPrimaryColor(context),
//                                  border: InputBorder.none,
//                                  enabledBorder: InputBorder.none,
//                                  disabledBorder: InputBorder.none,
//                                  focusedBorder: InputBorder.none,
//                                ),
//                                maxLines: 1,
//                                validator: (text) {
//                                  if (text.isEmpty) {
//                                    return 'Vui lòng nhập mật khẩu';
//                                  }
//                                  return null;
//                                },
//                              ),
//                              SizedBox(height: 18.0),
//                              TextFormField(
//                                controller: newPwdController,
//                                onChanged: (value) {
//                                  if (regex1.hasMatch(value)) {
//                                    setState(() {
//                                      checkPass1 = true;
//                                    });
//                                  } else {
//                                    setState(() {
//                                      checkPass1 = false;
//                                    });
//                                  }
//                                  if (regex2.hasMatch(value)) {
//                                    setState(() {
//                                      checkPass2 = true;
//                                    });
//                                  } else {
//                                    setState(() {
//                                      checkPass2 = false;
//                                    });
//                                  }
//                                  if (regex3.hasMatch(value)) {
//                                    setState(() {
//                                      checkPass3 = true;
//                                    });
//                                  } else {
//                                    setState(() {
//                                      checkPass3 = false;
//                                    });
//                                  }
//                                  if (regex4.hasMatch(value)) {
//                                    setState(() {
//                                      checkPass4 = true;
//                                    });
//                                  } else {
//                                    setState(() {
//                                      checkPass4 = false;
//                                    });
//                                  }
//                                },
//                                obscureText: true,
//                                style: ptTitle(context),
//                                keyboardType: TextInputType.visiblePassword,
//                                decoration: InputDecoration(
//                                  prefixIcon: Padding(
//                                    padding: EdgeInsets.only(right: 20.0),
//                                    child: Icon(
//                                      Icons.lock,
//                                      color: HexColor(appText60),
//                                      size: 30.0,
//                                    ),
//                                  ),
//                                  hintText: 'Mật khẩu mới',
//                                  hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                                  fillColor: ptPrimaryColor(context),
//                                  border: InputBorder.none,
//                                  enabledBorder: InputBorder.none,
//                                  disabledBorder: InputBorder.none,
//                                  focusedBorder: InputBorder.none,
//                                ),
//                                maxLines: 1,
//                                validator: (text) {
//                                  if (text.isEmpty) {
//                                    return 'Vui lòng nhập mật khẩu';
//                                  }
//                                  if (text.length < 8) {
//                                    return 'Độ dài mật khẩu phải có ít nhất 8 ký tự!';
//                                  }
//                                  if (this.checkPass1 == false ||
//                                      this.checkPass2 == false ||
//                                      this.checkPass3 == false) {
//                                    return 'Mật khẩu phải bao gồm: số, chữ, chữ viết hoa!';
//                                  }
//                                  return null;
//                                },
//                              ),
//                              Container(
//                                width: double.infinity,
//                                height: 20.0,
//                                padding: EdgeInsets.symmetric(horizontal: 50.0),
//                                child: LiquidLinearProgressIndicator(
//                                  value: processBar,
//                                  backgroundColor: Colors.white,
//                                  valueColor: AlwaysStoppedAnimation(colorProcessBar),
//                                  borderRadius: 12.0,
//                                  center: Text(titleProcessBar, style: ptSubtitle(context)),
//                                ),
//                              ),
//                              TextFormField(
//                                controller: confirmNewPwdController,
//                                obscureText: true,
//                                style: ptTitle(context),
//                                keyboardType: TextInputType.visiblePassword,
//                                decoration: InputDecoration(
//                                  prefixIcon: Padding(
//                                    padding: EdgeInsets.only(right: 20.0),
//                                    child: Icon(
//                                      Icons.lock,
//                                      color: HexColor(appText60),
//                                      size: 30.0,
//                                    ),
//                                  ),
//                                  hintText: 'Nhập lại mật khẩu mới',
//                                  hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                                  fillColor: ptPrimaryColor(context),
//                                  border: InputBorder.none,
//                                  enabledBorder: InputBorder.none,
//                                  disabledBorder: InputBorder.none,
//                                  focusedBorder: InputBorder.none,
//                                ),
//                                maxLines: 1,
//                                validator: (text) {
//                                  if (text.isEmpty) {
//                                    return 'Vui lòng nhập lại mật khẩu mới';
//                                  }
//                                  if (text.length < 8) {
//                                    return 'Độ dài mật khẩu không hợp lệ';
//                                  }
//
//                                  if (newPwdController.text != text) {
//                                    return 'Mật khẩu không trùng khớp';
//                                  }
//                                  return null;
//                                },
//                              ),
//                            ],
//                          ),
//                        )),
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: <Widget>[
//                      Container(
//                        alignment: Alignment.centerRight,
//                        padding: EdgeInsets.only(top: 18.0),
//                        child: Opacity(
//                            opacity: 1,
//                            child: FlatButton(
//                                onPressed: () => Navigator.of(context).pop(),
//                                shape: RoundedRectangleBorder(
//                                    side:
//                                        BorderSide(color: ptPrimaryColor(context), width: 4, style: BorderStyle.solid),
//                                    borderRadius: BorderRadius.circular(10)),
//                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                child: Text(
//                                  "Quay lại".toUpperCase(),
//                                  style: ptTitle(context).copyWith(color: Colors.black),
//                                ))),
//                      ),
//                      Container(
//                        alignment: Alignment.centerRight,
//                        margin: EdgeInsets.symmetric(horizontal: ScaleUtil.getInstance().setWidth(30)),
//                        padding: EdgeInsets.only(top: 18.0),
//                        child: Opacity(
//                            opacity: 1,
//                            child: FlatButton(
//                                onPressed: _handleChangePassword,
//                                shape: RoundedRectangleBorder(
//                                    side:
//                                        BorderSide(color: ptPrimaryColor(context), width: 4, style: BorderStyle.solid),
//                                    borderRadius: BorderRadius.circular(10)),
//                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                child: Text(
//                                  "ĐỔI MẬT KHẨU".toUpperCase(),
//                                  style: ptTitle(context).copyWith(color: Colors.black),
//                                ))),
//                      )
//                    ],
//                  )
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
//  _registerFbAuthResult() {
//    _phoneAuthStream?.cancel();
//    _phoneAuthStream = PhoneAuthHelper().authStream.listen((result) async {
//      if (result.status == AuthStatus.Verified) {
//        Navigator.pop(context);
//
//        // Enter current password ok
//        try {
//          String newPwd = newPwdController.text;
//          print('NEW PASSWORD: $newPwd');
//          showWaitingDialog(context);
//          await UserService().changePassword(userId: _appBloc.getProfile.id, newPwd: newPwd);
//          Navigator.pop(context);
//
//          _appBloc.getAuthBloc().updateUserAction(_appBloc.getProfile.copyWith(password: newPwd));
//          // Notify to user
//          showAlertDialog(context, 'Đổi mật khẩu thành công', confirmTap: () {
//            Navigator.pop(context);
//            Navigator.pop(context);
//          });
//        } catch (e) {
//          Navigator.pop(context);
//          showAlertDialog(context, 'Xãy ra lỗi: ${e.toString()}');
//        }
//      } else {
//        Navigator.pop(context);
//        showAlertDialog(context, 'Email hoặc mật khẩu không đúng. Vui lòng thử lại');
//      }
//    });
//  }
//
//  _handleChangePassword() async {
//    if (_formKey.currentState.validate() == false) {
//      return Future;
//    }
//
//    String curPwd = currentPwdController.text;
//    String email = _appBloc.getProfile.email;
//    showWaitingDialog(context);
//    PhoneAuthHelper().loginWithEmailVsPassword(email, curPwd);
//    return Future;
//  }
//}
