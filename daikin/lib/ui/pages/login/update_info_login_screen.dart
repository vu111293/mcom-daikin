//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:loctroi/apis/net/user_service.dart';
//import 'package:loctroi/blocs/application_bloc.dart';
//import 'package:loctroi/blocs/bloc_provider.dart';
//import 'package:loctroi/constants/constants.dart';
//import 'package:loctroi/models/user.dart';
//import 'package:loctroi/ui/customs/base_screen.dart';
//import 'package:loctroi/ui/customs/dialog.dart';
//import 'package:loctroi/ui/pages/home_screen.dart';
//import 'package:loctroi/ui/route/routing.dart';
//import 'package:loctroi/utils/hex_color.dart';
//import 'package:loctroi/utils/scale_util.dart';
//
//class UpdateInfoLoginScreen extends StatefulWidget {
//  UpdateInfoLoginScreenState createState() => UpdateInfoLoginScreenState();
//}
//
//class UpdateInfoLoginScreenState extends State<UpdateInfoLoginScreen> {
//  final _formKey = GlobalKey<FormState>();
//  ApplicationBloc _appBloc;
//  TextEditingController nameController;
//  TextEditingController addressController;
//  TextEditingController areaController;
//  TextEditingController phoneController;
//
//  String dropdownValue = 'One';
//  LUser me;
//
//  @override
//  void initState() {
//    _appBloc = BlocProvider.of<ApplicationBloc>(context);
//
//    me = _appBloc.getAuthBloc().getUser;
//    nameController = TextEditingController(text: me?.fullName ?? '');
//    phoneController = TextEditingController(text: me?.phone ?? '');
//    addressController = TextEditingController(text: me?.address ?? '');
//    areaController = TextEditingController(text: '${me?.area ?? ""}');
//
//    super.initState();
//  }
//
//  SizedBox sizeBox() {
//    return SizedBox(
//      height: 10.0,
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ScaleUtil.instance = ScaleUtil.getInstance()..init(context);
//    return Container(
//      color: Colors.white,
//      child: BaseScreen(
//        body: Form(
//          key: _formKey,
//          child: Container(
//            color: Colors.white,
//            child: Column(
//              children: <Widget>[
//                Image.asset(
//                  "assets/images/bg_login.jpeg",
//                  fit: BoxFit.fitWidth,
//                  // alignment: Alignment.bottomCenter,
//                  width: deviceWidth(context),
//                  // height: ScaleUtil.getInstance().setHeight(350),
//                ),
//                Container(
//                  color: Colors.white,
//                  // padding: EdgeInsets.only(bottom: 130.0),
//                  // constraints: BoxConstraints(
//                  //   minHeight: deviceHeight(context) - ScaleUtil.getInstance().setHeight(120),
//                  // ),
//                  // margin: EdgeInsets.only(top: ScaleUtil.getInstance().setHeight(250)),
//                  child: Padding(
//                      padding: EdgeInsets.symmetric(horizontal: ScaleUtil.getInstance().setWidth(30)),
//                      child: Column(
//                        // crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          // CircleAvatar(
//                          //   backgroundColor: Colors.white,
//                          //   radius: ScaleUtil.getInstance().setWidth(80),
//                          //   child: Image.asset(
//                          //     "assets/images/logo2.png",
//                          //     width: ScaleUtil.getInstance().setWidth(150),
//                          //     fit: BoxFit.contain,
//                          //   ),
//                          // ),
//                          // Text('Bệnh viện cây ăn quả'.toUpperCase(),
//                          //     style: ptHeadline(context)
//                          //         .copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.bold)),
//                          // Padding(
//                          //   padding: EdgeInsets.only(
//                          //       top: ScaleUtil.getInstance().setHeight(8), bottom: ScaleUtil.getInstance().setHeight(20)),
//                          //   child: Text(
//                          //     'Hệ thống Bệnh viện Cây ăn quả được thành lập bởi sự hợp tác giữa Viện Cây Ăn Quả Miền Nam & Tập Đoàn Lộc Trời',
//                          //     style: ptSubtitle(context),
//                          //     textAlign: TextAlign.center,
//                          //   ),
//                          // ),
//                          // Padding(
//                          //   padding: EdgeInsets.only(bottom: ScaleUtil.getInstance().setHeight(30)),
//                          //   child: Text('www.benhviencayanqua.vn',
//                          //       style: ptSubtitle(context).copyWith(color: ptPrimaryColor(context))),
//                          // ),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: ScaleUtil.getInstance().setHeight(10)),
//                            child: Text('ĐĂNG KÝ THÔNG TIN', style: ptHeadline(context).copyWith()),
//                          ),
//                          Column(
//                            children: <Widget>[
//                              TextFormField(
//                                controller: nameController,
//                                maxLines: 1,
//                                style: ptTitle(context),
//                                inputFormatters: [BlacklistingTextInputFormatter(RegExp(r"\s\s"))],
//                                keyboardType: TextInputType.text,
//                                decoration: InputDecoration(
//                                  prefixIcon: Padding(
//                                    padding: EdgeInsets.only(right: 20.0),
//                                    child: Icon(
//                                      Icons.person,
//                                      color: HexColor(appText60),
//                                      size: 30.0,
//                                    ),
//                                  ),
//                                  hintText: 'Họ và tên',
//                                  hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                                  fillColor: ptPrimaryColor(context),
//                                  border: InputBorder.none,
//                                  enabledBorder: InputBorder.none,
//                                  disabledBorder: InputBorder.none,
//                                  focusedBorder: InputBorder.none,
//                                ),
//                                validator: (text) {
//                                  return text.isEmpty || text.trim() == '' ? 'Vui lòng nhập họ tên' : null;
//                                },
//                              ),
//                              sizeBox(),
//                              TextFormField(
//                                controller: phoneController,
//                                enabled: false,
//                                maxLines: 1,
//                                style: ptTitle(context),
//                                keyboardType: TextInputType.text,
//                                decoration: InputDecoration(
//                                  prefixIcon: Padding(
//                                    padding: EdgeInsets.only(right: 20.0),
//                                    child: Icon(
//                                      Icons.phone,
//                                      color: HexColor(appText60),
//                                      size: 30.0,
//                                    ),
//                                  ),
//                                  hintText: 'Số điện thoại',
//                                  hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                                  fillColor: ptPrimaryColor(context),
//                                  border: InputBorder.none,
//                                  enabledBorder: InputBorder.none,
//                                  disabledBorder: InputBorder.none,
//                                  focusedBorder: InputBorder.none,
//                                ),
//                              ),
//                              sizeBox(),
//                              TextFormField(
//                                controller: addressController,
//                                maxLines: 1,
//                                style: ptTitle(context),
//                                keyboardType: TextInputType.text,
//                                decoration: InputDecoration(
//                                  prefixIcon: Padding(
//                                    padding: EdgeInsets.only(right: 20.0),
//                                    child: Icon(
//                                      Icons.pin_drop,
//                                      color: HexColor(appText60),
//                                      size: 30.0,
//                                    ),
//                                  ),
//                                  hintText: 'Địa chỉ liên hệ',
//                                  hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                                  fillColor: ptPrimaryColor(context),
//                                  border: InputBorder.none,
//                                  enabledBorder: InputBorder.none,
//                                  disabledBorder: InputBorder.none,
//                                  focusedBorder: InputBorder.none,
//                                ),
//                                validator: (text) {
//                                  return text.isEmpty || text.trim() == '' ? 'Vui lòng nhập địa chỉ' : null;
//                                },
//                              ),
//                              sizeBox(),
//                              TextFormField(
//                                controller: areaController,
//                                maxLines: 1,
//                                style: ptTitle(context),
//                                keyboardType: TextInputType.number,
//                                decoration: InputDecoration(
//                                  prefixIcon: Padding(
//                                    padding: EdgeInsets.only(right: 20.0),
//                                    child: Icon(
//                                      Icons.spa,
//                                      color: HexColor(appText60),
//                                      size: 30.0,
//                                    ),
//                                  ),
//                                  hintText: 'Diện tích canh tác',
//                                  hintStyle: ptTitle(context).copyWith(color: HexColor(appText60)),
//                                  fillColor: ptPrimaryColor(context),
//                                  border: InputBorder.none,
//                                  enabledBorder: InputBorder.none,
//                                  disabledBorder: InputBorder.none,
//                                  focusedBorder: InputBorder.none,
//                                  suffixText: 'ha',
//                                ),
//                                inputFormatters: [
//                                  WhitelistingTextInputFormatter(RegExp(r'^[0-9]*(\.[0-9]*)?')),
//                                ],
//                                validator: (text) {
//                                  if (text.isEmpty) return 'Vui lòng nhập diện tích canh tác';
//                                  try {
//                                    double.parse(text);
//                                  } catch (e) {
//                                    return 'Giá trị không hợp lệ';
//                                  }
//                                  return null;
//                                },
//                              ),
//                            ],
//                          ),
//                          Container(
//                            alignment: Alignment.bottomRight,
//                            padding: EdgeInsets.only(top: 18.0),
//                            child: RaisedButton(
//                              onPressed: _handleUpdate,
//                              shape: RoundedRectangleBorder(
//                                  side: BorderSide(color: ptPrimaryColor(context), width: 4, style: BorderStyle.solid),
//                                  borderRadius: BorderRadius.circular(10)),
//                              padding: EdgeInsets.symmetric(
//                                  horizontal: ScaleUtil.getInstance().setWidth(20),
//                                  vertical: ScaleUtil.getInstance().setHeight(15)),
//                              child: Text(
//                                "Tiếp tục".toUpperCase(),
//                                style: ptTitle(context).copyWith(color: Colors.white),
//                              ),
//                            ),
//                          )
//                        ],
//                      )),
//                ),
//                Image.asset(
//                  "assets/images/home_bottom.png",
//                  width: deviceWidth(context),
//                  fit: BoxFit.cover,
//                  alignment: Alignment.bottomCenter,
//                  // height: 130,
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  bool _isLoading = false;
//  _handleUpdate() async {
//    if (_formKey.currentState.validate()) {
//      _formKey.currentState.save();
//
//      String name = nameController.text;
//      String address = addressController.text;
//      String area = areaController.text;
//
//      _isLoading = true;
//      showWaitingDialog(context);
//      await UserService()
//          .update(me.copyWith(
//              fullName: name?.trim(),
//              address: address?.trim(),
//              area: area == null || area.isEmpty ? 0 : double.parse(area)))
//          .then((me) {
//        Navigator.pop(context);
//        _appBloc.getAuthBloc().updateUserAction(me);
//        Routing().navigate2(context, HomeScreen(), replace: true);
//      }).catchError((e) {
//        Navigator.pop(context);
//        Routing().navigate2(context, HomeScreen(), replace: true);
//        return;
//      });
//    }
//  }
//}
