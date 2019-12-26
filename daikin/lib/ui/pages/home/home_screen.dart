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
          body: Container(
              alignment: Alignment.center,
              child: Text('Home page'))
      ),
      onWillPop: () =>
          showDialog<bool>(
            context: context,
            builder: (c) =>
                AlertDialog(
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
