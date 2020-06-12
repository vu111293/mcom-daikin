import 'dart:convert';
import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:daikin/apis/local/local_setting.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class MyCenterScreen extends StatefulWidget {
  final bool isUpdate;
  MyCenterScreen({Key key, this.isUpdate = false}) : super(key: key);
  @override
  MyCenterScreenState createState() => MyCenterScreenState();
}

const DEBUG_MY_CENTER = false;

class MyCenterScreenState extends State<MyCenterScreen> with SingleTickerProviderStateMixin, AfterLayoutMixin<MyCenterScreen> {
  ApplicationBloc _appBloc;
  final FocusNode myFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _ipController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String date;
  String name = '';
  String ip = '';
  String username = '';
  String password = '';

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    _appBloc.centerBloc.getCenter();
    super.initState();
  }


  @override
  void afterFirstLayout(BuildContext context) {
    if (_appBloc.mainScreenBloc.needToShowAddCenterDevice) {
      _appBloc.mainScreenBloc.disableAddCenterDeviceRequest();
      _settingModalBottomSheet(context);
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: SingleChildScrollView(
//            autoScroll: false,
                child: Container(
//              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: HexColor(appBorderColor))),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Thiết bị',
                              style: ptTitle(context),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                Icons.close,
                                color: HexColor(appBorderColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Image.asset(
                              "assets/devices/sun.png",
                              fit: BoxFit.contain,
                              width: 45,
                              color: HexColor(appColor),
                            ),
                          ),
                          TitleField(
                            title: 'Tên thiết bị',
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      onChanged: (text) {
                                        setState(() {
                                          name = text;
                                        });
                                      },
                                      // enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          TitleField(
                            title: 'IP',
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      onChanged: (text) {
                                        setState(() {
                                          ip = text;
                                        });
                                      },
                                      // enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          TitleField(
                            title: 'Tài khoản',
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      onChanged: (text) {
                                        setState(() {
                                          username = text;
                                        });
                                      },
                                      // enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          TitleField(
                            title: 'Mật khẩu',
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      obscureText: true,
                                      onChanged: (text) {
                                        setState(() {
                                          password = text;
                                        });
                                      },
                                      // enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Align(alignment: Alignment.center, child: _getActionButtons()),
                          Container(
                            height: max(300, MediaQuery.of(context).viewInsets.bottom),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  void _settingModalBottomSheetEdit(context, dynamic data) {
    _nameController.text = data["name"];
    _ipController.text = data["ip"];
    _usernameController.text = data["username"];
    _passwordController.text = data["password"];

    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        isScrollControlled: true,
        builder: (BuildContext bc) {
          bool isDemoDevice = data["id"] == DEFAULT_CENTER_ID;
          bool enable = !isDemoDevice;
          return Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: HexColor(appBorderColor))),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Thiết bị',
                          style: ptTitle(context),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.close,
                            color: HexColor(appBorderColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Image.asset(
                          "assets/devices/sun.png",
                          fit: BoxFit.contain,
                          width: 45,
                          color: HexColor(appColor),
                        ),
                      ),
                      TitleField(
                        title: 'Tên thiết bị',
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextFormField(
                                  enabled: enable,
                                  controller: _nameController,
                                  // onChanged: (text) {
                                  //   setState(() {
                                  //     _formEdit.name = text;
                                  //     name = text;
                                  //   });
                                  // },
                                  // enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      TitleField(
                        title: 'IP',
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextFormField(
                                  enabled: enable,
                                  controller: _ipController,
                                ),
                              ),
                            ],
                          )),
                      TitleField(
                        title: 'Tài khoản',
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextFormField(
                                  enabled: enable,
                                  controller: _usernameController,
                                ),
                              ),
                            ],
                          )),
                      TitleField(
                        title: 'Mật khẩu',
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextFormField(
                                  obscureText: true,
                                  enabled: enable,
                                  controller: _passwordController,
                                ),
                              ),
                            ],
                          )),
                      Align(alignment: Alignment.center, child: _getActionButtonEdit(data)),
                      Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextFormField(
                                  enabled: false,
                                  obscureText: true,
                                  controller: _passwordController,
                                  readOnly: true,
                                  style: TextStyle(backgroundColor: Colors.transparent, color: Colors.transparent),
                                  cursorColor: Colors.transparent,
                                  decoration: InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        height: max(300, MediaQuery.of(context).viewInsets.bottom),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            _settingModalBottomSheet(context);
          },
          child: new Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            BaseHeaderScreen(
              title: "Thiết bị trung tâm",
              isBack: true,
            ),
            BaseHeaderScreen(
              hideProfile: true,
              isSubHeader: true,
              title: "Thiết bị trung tâm",
              subTitle: "Thêm hoặc chỉnh sửa thông thiết bị",
            ),
            Padding(
              padding: EdgeInsets.only(top: 36, left: 16, right: 16, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Danh sách thiết bị trung tâm",
                    style: ptBody1(context).copyWith(color: ptPrimaryColor(context)),
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: ptPrimaryColor(context),
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    child: Center(
                        child: StreamBuilder<List<dynamic>>(
                            stream: _appBloc.centerBloc.centerDataStream,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text(
                                  "0",
                                  style: ptCaption(context).copyWith(color: Colors.white, fontSize: ptCaption(context).fontSize - 2),
                                );
                              } else
                                return Text(
                                  snapshot.data.length.toString(),
                                  style: ptCaption(context).copyWith(color: Colors.white, fontSize: ptCaption(context).fontSize - 2),
                                );
                            })),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: _appBloc.centerBloc.centerDataStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  } else
                    return ListView.builder(
                      // padding: EdgeInsets.only(top: 58, left: 16, right: 16, bottom: 4),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var centerDevice = snapshot.data[index];

                        return GestureDetector(
                            onTap: () {
                              _settingModalBottomSheetEdit(context, centerDevice);
                            },
                            child: ListTile(
                              leading: Container(
                                width: 40, // can be whatever value you want
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/devices/sun.png",
                                  width: 20,
                                  height: 20,
                                  color: HexColor(appColor),
                                ),
                              ),
                              title: Text(
                                upFirstText(centerDevice["name"]),
                                style: ptSubtitle(context),
                              ),
                              subtitle: Text(
                                'IP: ' + centerDevice["ip"],
                                style: ptCaption(context),
                              ),
                              trailing: Icon(Icons.edit),
                            ));
                      },
                    );
                },
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _ipController.dispose();

    super.dispose();
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
                padding: EdgeInsets.only(right: 8.0),
                child: RaisedButton(
                  child: Text(
                    "xác nhận".toUpperCase(),
                    style: ptButton(context).copyWith(color: Colors.white),
                  ),
                  textColor: Colors.white,
                  color: ptPrimaryColor(context),
                  onPressed: () {
                    if (DEBUG_MY_CENTER) {
//                      name = 'SHOWROOM';
//                      ip = 'http://mhome-showroom.ddns.net';
//                      username = 'kythuat@kimsontien.com';
//                      password = 'Chotronniemvui1';

                      name = 'NHA MAU';
                      ip = 'http://mhome-nhamau.ddns.net';
                      username = 'Kythuat@kimsontien.com';
                      password = 'Chotronniemvui1';
                    }

                    _appBloc.centerBloc.setCenter({"name": name, "ip": ip, "username": username, "password": password});
                    Navigator.pop(context);
                    // FocusScope.of(context).requestFocus(FocusNode());
                    // setState(() {
                    //   _status = true;
                    //   FocusScope.of(context).requestFocus(FocusNode());
                    // });
                  },
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                )),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getActionButtonEdit(dynamic data) {
    bool isDemoDevice = data["id"] == DEFAULT_CENTER_ID;
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.only(right: 8.0),
                child: RaisedButton(
                  child: Text(
                    'XÓA THIẾT BỊ',
                    style: ptButton(context).copyWith(color: Colors.white),
                  ),
                  textColor: Colors.white,
                  color:  Colors.redAccent,
                  onPressed: isDemoDevice ? null : () {
                    showConfirmDialog(context, "Bạn có muốn xóa thiết bị này ?", confirmTap: () {
                      _appBloc.centerBloc.removeCenter(data["id"]);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                    // FocusScope.of(context).requestFocus(FocusNode());
                    // setState(() {
                    //   _status = true;
                    //   FocusScope.of(context).requestFocus(FocusNode());
                    // });
                  },
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                )),
            flex: 2,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: 8.0),
                child: RaisedButton(
                  child: Text(
                    'LƯU LẠI',
                    style: ptButton(context).copyWith(color: Colors.white),
                  ),
                  textColor: Colors.white,
                  color: ptPrimaryColor(context),
                  onPressed: isDemoDevice ? null : () {
                    _appBloc.centerBloc.updateCenter(data["id"], {"id": data["id"], "name": _nameController.text, "ip": _ipController.text, "username": _usernameController.text, "password": _passwordController.text});
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                )),
            flex: 2,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: 8.0),
                child: RaisedButton(
                  child: Text(
                    'KÍCH HOẠT',
                    style: ptButton(context).copyWith(color: Colors.white),
                  ),
                  textColor: Colors.white,
                  color: ptPrimaryColor(context),
                  onPressed: () async {
                    try {
                      showWaitingDialog(context);
                      await _appBloc.setCurrentCenter(data);
                      if (await _appBloc.centerBloc.isDemoCenterDevice) {
                        LocalSetting().setRequireAddDevice(true);
                      }
                      Navigator.pop(context);
                      showAlertDialog(context, "Kích hoạt thiết bị thành công!", confirmTap: () {
                        Navigator.popUntil(context, ModalRoute.withName('/mycenterscreen'));
                      });
                    } catch(e) {
                      print(e.toString());
                      Navigator.pop(context);
                      showAlertWithTitleDialog(context, "Xãy ra lỗi", "Kích hoạt thiết bị thất bại! \nVui lòng kiểm tra lại thông tin truy cập hoặc thử lại sau.", firstTap: () {
                        Navigator.pop(context);
                      });
                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                )),
            flex: 2,
          )
        ],
      ),
    );
  }
}

class TitleField extends StatelessWidget {
  String title;
  TitleField({
    Key key,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}
