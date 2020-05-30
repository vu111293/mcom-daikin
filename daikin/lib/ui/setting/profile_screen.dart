import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/user_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/ui/customs/image_picker.dart';
import 'package:daikin/ui/pages/main.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatefulWidget {
  final bool isLogin;
  ProfileScreen({Key key, this.isLogin = false}) : super(key: key);
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  ApplicationBloc _appBloc;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String date;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    _fullNameController.text = _appBloc.authBloc.currentUser.fullName;
    _emailController.text = _appBloc.authBloc.currentUser.email;
    _phoneController.text = _appBloc.authBloc.currentUser.phone;

    setState(() {
      _status = !widget.isLogin;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    BaseHeaderScreen(
                      title: widget.isLogin
                          ? 'CẬP NHẬT THÔNG TIN'
                          : 'THÔNG TIN TÀI KHOẢN',
                      isBack: widget.isLogin ? false : true,
                      hideProfile: true,
                      isTitleOnly: widget.isLogin,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: 150,
                        child: ImagePickerWidget(
                          context: context,
                          isEdit: true,
                          circle: true,
                          size: 150.0,
                          resourceUrl: _appBloc.authBloc.currentUser.avatar,
                          onFileChanged: (fileUri, fileType) async {
                            var result = await UserService().updateUser(
                                _appBloc.authBloc.currentUser.id,
                                _fullNameController.text,
                                _emailController.text,
                                fileUri);
                            _appBloc.authBloc.updateUserAction(result);
                            setState(() {});
                            BotToast.showText(text: "Cập nhật ảnh đại diện thành công");
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Họ và tên (*)',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: TextFormField(
                                    controller: _fullNameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Nhập họ tên',
                                    ),
//                                    autofocus: !_status,
                                    validator: (text) {
                                      return text.isEmpty ? 'Vui lòng nhập họ tên' : null;
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                        hintText: 'Nhập email'),
                                    // enabled: !_status,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: TextFormField(
                                    controller: _phoneController,
//                                  readOnly: true,
                                    enabled: false,
                                    style: TextStyle(color: Colors.grey),
                                    decoration: const InputDecoration(
                                      hintText: 'Nhập số điện thoại',
                                    ),
                                    // enabled: !_status,
                                  ),
                                ),
                              ],
                            )),
                        Align(
                            alignment: Alignment.center,
                            child: _getActionButtons())
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  void uploadImage() async {
    UploadImage().uploadImage(context, (text) async {
      var result = await UserService().updateUser(
          _appBloc.authBloc.currentUser.id,
          _fullNameController.text,
          _emailController.text,
          text);
      _appBloc.authBloc.updateUserAction(result);
      setState(() {});
      BotToast.showText(text: "Cập nhật thông tin thành công");
    });
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                child: RaisedButton(
              child: Text(
                      'CẬP NHẬT',
                      style: ptButton(context).copyWith(color: Colors.white),
                    ),
              textColor: Colors.white,
              color: ptPrimaryColor(context),
              onPressed: () async {
                if (_appBloc.authBloc.getUser.avatar == null || _appBloc.authBloc.getUser.avatar.isEmpty) {
                  showAlertDialog(context, 'Vui lòng chọn ảnh đại diện');
                  return;
                }
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  showWaitingDialog(context);
                  var result = await UserService().updateUser(
                      _appBloc.authBloc.currentUser.id,
                      _fullNameController.text,
                      _emailController.text,
                      _appBloc.authBloc.currentUser.avatar);
                  _appBloc.authBloc.updateUserAction(result);
                  Navigator.pop(context);
                  BotToast.showText(text: "Cập nhật thông tin thành công");

                  if (widget.isLogin) {
                    Routing().navigate2(context, MainScreen(), replace: true);
                  } else {
                    Navigator.pop(context);
                  }
                }
              },
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            )),
            flex: 2,
          ),
        ],
      ),
    );
  }

  String validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contains more then 5 character";
    }
    return null;
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
