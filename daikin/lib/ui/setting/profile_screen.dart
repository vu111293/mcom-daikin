import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daikin/apis/net/user_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/image_picker.dart';
import 'package:daikin/ui/pages/main.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/upload_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  bool isLogin;
  ProfileScreen({Key key, this.isLogin = false}) : super(key: key);
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  ApplicationBloc _appBloc;

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String date;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);

    _fullnameController.text = _appBloc.authBloc.currentUser.fullName;
    _emailController.text = _appBloc.authBloc.currentUser.email;
    _phoneController.text = _appBloc.authBloc.currentUser.phone;

    setState(() {
      _status = !widget.isLogin;
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   _dateController.dispose();
  //   super.dispose();
  // }

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
                          ? "Cập nhật thông tin".toUpperCase()
                          : "Thông tin tài khoản".toUpperCase(),
                      isBack: widget.isLogin ? false : true,
                      hideProfile: true,
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
                                _fullnameController.text,
                                _emailController.text,
                                fileUri);
                            _appBloc.authBloc.updateUserAction(result);
                            setState(() {});
                            BotToast.showText(
                                text: "Cập nhật thông tin thành công");
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
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
                                    'Họ và tên',
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
                                child: TextField(
                                  controller: _fullnameController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                  // enabled: !_status,
                                  autofocus: !_status,
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
                                child: TextField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Email"),
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
                                child: TextField(
                                  controller: _phoneController,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Mobile Number"),
                                  // enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      // Padding(
                      //     padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       children: <Widget>[
                      //         Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: <Widget>[
                      //             Text(
                      //               'Date',
                      //               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     )),
                      // Padding(
                      //     padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       children: <Widget>[
                      //         Flexible(
                      //           child: TextField(
                      //             controller: _dateController,
                      //             onTap: () {
                      //               DatePicker.showDatePicker(
                      //                 context,
                      //                 showTitleActions: true,
                      //                 onChanged: (date) {
                      //                   _dateController.text = formatDate(date, [dd, '-', mm, '-', yyyy]).toString();
                      //                   print('change $date');
                      //                 },
                      //                 onConfirm: (date) {
                      //                   _dateController.text = formatDate(date, [dd, '-', mm, '-', yyyy]).toString();
                      //                   print('confirm $date');
                      //                 },
                      //                 currentTime: DateTime.now(),
                      //                 locale: LocaleType.vi,
                      //               );
                      //             },
                      //             readOnly: true,
                      //             decoration: const InputDecoration(hintText: "Enter Mobile Number"),
                      //             // enabled: !_status,
                      //           ),
                      //         ),
                      //       ],
                      //     )),
                      Align(
                          alignment: Alignment.center,
                          child: _getActionButtons())
                    ],
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
          _fullnameController.text,
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
              child: widget.isLogin
                  ? Text(
                      "Update".toUpperCase(),
                      style: ptButton(context).copyWith(color: Colors.white),
                    )
                  : Text(
                      "Cập nhật".toUpperCase(),
                      style: ptButton(context).copyWith(color: Colors.white),
                    ),
              textColor: Colors.white,
              color: ptPrimaryColor(context),
              onPressed: () async {
                var result = await UserService().updateUser(
                    _appBloc.authBloc.currentUser.id,
                    _fullnameController.text,
                    _emailController.text,
                    _appBloc.authBloc.currentUser.avatar);
                _appBloc.authBloc.updateUserAction(result);
                BotToast.showText(text: "Cập nhật thông tin thành công");
              },
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            )),
            flex: 2,
          ),
          // widget.isLogin
          //     ? SizedBox()
          //     : Expanded(
          //         child: Padding(
          //           padding: EdgeInsets.only(left: 10.0),
          //           child: Container(
          //               child: RaisedButton(
          //             child: Text(
          //               "Cancel".toUpperCase(),
          //               style: ptButton(context).copyWith(color: Colors.white),
          //             ),
          //             textColor: Colors.white,
          //             color: Colors.red,
          //             onPressed: () {
          //               setState(() {
          //                 _status = true;
          //                 FocusScope.of(context).requestFocus(FocusNode());
          //               });
          //             },
          //             padding: EdgeInsets.symmetric(vertical: 16),
          //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          //           )),
          //         ),
          //         flex: 2,
          //       ),
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
