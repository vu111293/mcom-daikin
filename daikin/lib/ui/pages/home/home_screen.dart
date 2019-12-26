import 'dart:io';

import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/base_screen.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:daikin/utils/scale_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ApplicationBloc _appBloc;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
//    _appBloc.loadUserData().then((v) {
//      _checkQuestionDetailInNoti();
//    }).catchError((e) {
//      print(e);
//    });

    super.initState();
//    _registerFirebaseMessage();
  }

//  _checkQuestionDetailInNoti() async {
//    if (_appBloc.actionInNoti != null) {
//      NotifyAction action = _appBloc.actionInNoti;
//      _appBloc.addNotifyActionWhenOpen(null);
//      if (action.type == NotifyType.ISSUE) {
//        LQuestionResponse q = _appBloc.allQuestionList.firstWhere((item) => item.id == action.id, orElse: () => null);
//        if (q != null) {
//          await Future.delayed(Duration(milliseconds: 500), () {
//            Routing().navigate2(context, QuestionDetailScreen(question: q));
//          });
//        } else {
//          if (mounted) {
//            Toast.show('Câu hỏi đã bị thay đổi hoặc không tồn tại', context);
//          }
//        }
//      } else if (action.type == NotifyType.NEWS) {
//        Future.delayed(Duration(milliseconds: 500), () {
//          Routing().navigate2(context, NotificationScreen());
//        });
//      } else if (action.type == NotifyType.POST) {
//        Future.delayed(Duration(milliseconds: 500), () {
//          Routing().navigate2(Routing().latestContext, DocumentDetailScreen(postId: action.id));
//        });
//      }
//    } else {
//      print('can not get id');
//    }
//  }
//
//  _registerFirebaseMessage() async {
//    String token = await FirebaseMessaging().getToken();
//    print('device id ${_appBloc.deviceId}');
//    print('fcm token $token');
//    NotiService().registerFcm(_appBloc.deviceId, token);
//  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Routing().setContext(context);
    return WillPopScope(
      child: BaseScreen(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: ScaleUtil.getInstance().setHeight(30), bottom: ScaleUtil.getInstance().setHeight(8)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: ptPrimaryColor(context),
                        width: ScaleUtil.getInstance().setHeight(8),
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo2.png",
                        width: ScaleUtil.getInstance().setWidth(130),
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScaleUtil.getInstance().setWidth(16), vertical: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Bệnh viện cây ăn quả'.toUpperCase(),
                              style: ptHeadline(context)
                                  .copyWith(color: ptPrimaryColor(context), fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScaleUtil.getInstance().setHeight(8),
                                  bottom: ScaleUtil.getInstance().setHeight(10)),
                              child: Text(
                                'Hệ thống Bệnh viện Cây ăn quả được thành lập bởi sự hợp tác giữa Viện Cây Ăn Quả Miền Nam & Tập Đoàn Lộc Trời',
                                style: ptSubtitle(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: ScaleUtil.getInstance().setHeight(10)),
                              child: Text('www.benhviencayanqua.vn',
                                  style: ptSubtitle(context).copyWith(color: ptPrimaryColor(context))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: ptPrimaryColor(context),
                        width: ScaleUtil.getInstance().setHeight(8),
                      ),
                      bottom: BorderSide(
                        color: ptPrimaryColor(context),
                        width: ScaleUtil.getInstance().setHeight(8),
                      ),
                    ),
                  ),
                  child: Container(
                    height: ScaleUtil.getInstance().setHeight(40),
                    width: deviceWidth(context),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [ptPrimaryColor(context), HexColor('#3FB424')])),
                  ),
                ),
                Container(
                  // color: ptPrimaryColor(context),
                  padding: EdgeInsets.only(
                      top: ScaleUtil.getInstance().setHeight(10), bottom: ScaleUtil.getInstance().setHeight(10)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(color: ptPrimaryColor(context), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                splashColor: ptPrimaryColor(context).withOpacity(0.2),
                                highlightColor: ptPrimaryColor(context).withOpacity(0.2),
                                onTap: () {
//                                  Routing().navigate2(context, IntroduceScreen());
                                },
                                child: Container(
                                    padding: EdgeInsets.all(deviceWidth(context) * 0.03),
                                    width: deviceWidth(context) * 0.45,
                                    height: ScaleUtil.getInstance().setWidth(100),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            // padding: ,
                                            child: Text(
                                              'Giới thiệu',
                                              style: ptButton(context),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                            "assets/icons/dashboard/1.png",
                                            width: ScaleUtil.getInstance().setWidth(44),
                                            height: ScaleUtil.getInstance().setWidth(44),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(color: ptPrimaryColor(context), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                splashColor: ptPrimaryColor(context).withOpacity(0.2),
                                highlightColor: ptPrimaryColor(context).withOpacity(0.2),
                                onTap: () {
//                                  Routing().navigate2(
//                                      context,
//                                      IntroTeamScreen(
//                                        isMap: true,
//                                      ));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(deviceWidth(context) * 0.03),
                                    width: deviceWidth(context) * 0.45,
                                    height: ScaleUtil.getInstance().setWidth(100),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            // padding: ,
                                            child: Text(
                                              'Hệ thống bệnh viện',
                                              style: ptButton(context),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                            "assets/icons/dashboard/2.png",
                                            width: ScaleUtil.getInstance().setWidth(44),
                                            height: ScaleUtil.getInstance().setWidth(44),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(color: ptPrimaryColor(context), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                splashColor: ptPrimaryColor(context).withOpacity(0.2),
                                highlightColor: ptPrimaryColor(context).withOpacity(0.2),
                                onTap: () {
//                                  Routing().navigate2(
//                                      context,
//                                      DocumentList(
//                                        titleHeader: "Tin tức - kinh nghiệm nhà nông",
//                                        type: DocumentType.TINTUC,
//                                      ));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(deviceWidth(context) * 0.03),
                                    width: deviceWidth(context) * 0.45,
                                    height: ScaleUtil.getInstance().setWidth(100),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            // padding: ,
                                            child: Text(
                                              'Tin tức - kinh nghiệm nhà nông',
                                              style: ptButton(context),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                            "assets/icons/dashboard/3.png",
                                            width: ScaleUtil.getInstance().setWidth(44),
                                            height: ScaleUtil.getInstance().setWidth(44),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(color: ptPrimaryColor(context), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                splashColor: ptPrimaryColor(context).withOpacity(0.2),
                                highlightColor: ptPrimaryColor(context).withOpacity(0.2),
                                onTap: () {
//                                  Routing().navigate2(context, DocumentScreen());
                                },
                                child: Container(
                                    padding: EdgeInsets.all(deviceWidth(context) * 0.03),
                                    width: deviceWidth(context) * 0.45,
                                    height: ScaleUtil.getInstance().setWidth(100),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            // padding: ,
                                            child: Text(
                                              'Tài liệu kỹ thuật',
                                              style: ptButton(context),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                            "assets/icons/dashboard/4.png",
                                            width: ScaleUtil.getInstance().setWidth(44),
                                            height: ScaleUtil.getInstance().setWidth(44),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(color: ptPrimaryColor(context), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                splashColor: ptPrimaryColor(context).withOpacity(0.2),
                                highlightColor: ptPrimaryColor(context).withOpacity(0.2),
                                onTap: () {
//                                  Routing().navigate2(context, VideoScreen());
                                },
                                child: Container(
                                    padding: EdgeInsets.all(deviceWidth(context) * 0.03),
                                    width: deviceWidth(context) * 0.45,
                                    height: ScaleUtil.getInstance().setWidth(100),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            // padding: ,
                                            child: Text(
                                              'Video',
                                              style: ptButton(context),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                            "assets/icons/dashboard/5.png",
                                            width: ScaleUtil.getInstance().setWidth(44),
                                            height: ScaleUtil.getInstance().setWidth(44),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(color: ptPrimaryColor(context), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                splashColor: ptPrimaryColor(context).withOpacity(0.2),
                                highlightColor: ptPrimaryColor(context).withOpacity(0.2),
                                onTap: () {
//                                  Routing().navigate2(
//                                      context,
//                                      DocumentList(
//                                        titleHeader: "Phác đồ điều trị",
//                                        type: DocumentType.PHACDODIEUTRI,
//                                      ));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(deviceWidth(context) * 0.03),
                                    width: deviceWidth(context) * 0.45,
                                    height: ScaleUtil.getInstance().setWidth(100),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            // padding: ,
                                            child: Text(
                                              'Phác đồ điều trị',
                                              style: ptButton(context),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                            "assets/icons/dashboard/6.png",
                                            width: ScaleUtil.getInstance().setWidth(44),
                                            height: ScaleUtil.getInstance().setWidth(44),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(color: ptPrimaryColor(context), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                splashColor: ptPrimaryColor(context).withOpacity(0.2),
                                highlightColor: ptPrimaryColor(context).withOpacity(0.2),
                                onTap: () {
//                                  Routing().navigate2(context, QuestionScreen());
                                },
                                child: Container(
                                    padding: EdgeInsets.all(deviceWidth(context) * 0.03),
                                    width: deviceWidth(context) * 0.45,
                                    height: ScaleUtil.getInstance().setWidth(100),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            // padding: ,
                                            child: Text(
                                              'Hỏi & đáp',
                                              style: ptButton(context),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                            "assets/icons/dashboard/7.png",
                                            width: ScaleUtil.getInstance().setWidth(44),
                                            height: ScaleUtil.getInstance().setWidth(44),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: new BorderSide(color: ptPrimaryColor(context), width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                splashColor: ptPrimaryColor(context).withOpacity(0.2),
                                highlightColor: ptPrimaryColor(context).withOpacity(0.2),
                                onTap: () {
//                                  Routing().navigate2(context, GoogleMapScreen());
                                  // openWebBrowerhURL('http://www.loctroi.vn/lien-he');
                                },
                                child: Container(
                                    padding: EdgeInsets.all(deviceWidth(context) * 0.03),
                                    width: deviceWidth(context) * 0.45,
                                    height: ScaleUtil.getInstance().setWidth(100),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            // padding: ,
                                            child: Text(
                                              'Liên hệ',
                                              style: ptButton(context),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                            "assets/icons/dashboard/8.png",
                                            width: ScaleUtil.getInstance().setWidth(44),
                                            height: ScaleUtil.getInstance().setWidth(44),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: deviceWidth(context) * 0.1,
                      // ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/home_bottom.png",
                  width: deviceWidth(context),
                  fit: BoxFit.contain,
                ),
              ],
            ),
            Positioned(
              child: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                    alignment: Alignment.topCenter,
                    icon: ImageIcon(
                      AssetImage("assets/icons/notification.png"),
                      color: Colors.black,
                    ),
                    color: Colors.black87,
                    onPressed: () {
//                      Routing().navigate2(context, NotificationScreen());
                    },
                    tooltip: 'Thông báo',
                  ),
                  IconButton(
                    alignment: Alignment.topCenter,
                    icon: ImageIcon(
                      AssetImage("assets/icons/ic_setting.png"),
                      color: Colors.black,
                    ),
                    color: Colors.black87,
                    onPressed: () {
//                      Routing().navigate2(context, MenuScreen());
                    },
                    tooltip: 'Cài đặt',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Thông báo'),
          content: Text('Bạn có muốn thoát ứng dụng'),
          actions: [
            FlatButton(
              child: Text('Đồng ý'),
              onPressed: () => Platform.isIOS ? exit(0) : SystemNavigator.pop(),
            ),
            FlatButton(
              child: Text('Hủy'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
    );
  }
}
