import 'dart:async';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/app.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/ui/pages/home/home_screen.dart';
import 'package:daikin/ui/pages/main.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/network_check.dart';
import 'package:daikin/utils/scale_util.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final AppType appType;

  SplashScreen({this.appType});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ApplicationBloc _appBloc;
  StreamSubscription _setupStateStream;
  NetworkCheck _connectivity = NetworkCheck.instance;
  bool isConnect = false;
  StreamSubscription _netStreamSub;

  @override
  void initState() {
    _connectivity.initialise();

    // Listen network change
    _netStreamSub = _connectivity.networkChangedEvent.listen((online) async {
      setState(() {
        this.isConnect = online;
      });
      if (online) {
        await prepareData();
      }
    });
    super.initState();
  }

  Future prepareData() async {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    await _appBloc.loadBaseData();
//    await _cacheDeviceId();
    _setupStateStream = _appBloc.setupStateEvent.listen(
      (s) async {
        if (s == 'done') {
          Routing().navigate2(context, MainScreen());
//          try {
//            // make auto login or show login page
//            AccessStatus tokenState = await LoopBackAuth().loadAccessToken();
//            if (tokenState != AccessStatus.TOKEN_VALID) {
//              _openLoginScreen();
//            } else {
////              LUser user = await UserService().getProfile(LoopBackAuth().userId);
////              _appBloc.authBloc.updateUserAction(user);
//
////              Routing().navigate2(context, HomeScreen());
//
////              if (widget.appType == AppType.DOCTOR) {
////                Routing().navigate2(context, AdvisoryScreen(), replace: true);
////              } else {
////                if (user.isClientFilledInfo) {
////                  Routing().navigate2(context, HomeScreen());
////                } else {
////                  Routing().navigate2(context, UpdateInfoLoginScreen(), replace: true);
////                }
////              }
//              _setupStateStream.cancel();
//            }
//          } catch (e) {
//            LoopBackAuth().clear();
//            _openLoginScreen();
//          }
        } else {
          showAlertDialog(context, 'Xãy ra lỗi khi giao tiếp với server. Vui lòng thử lại');
        }
      },
    );
    return Future;
  }

//  _cacheDeviceId() async {
//    String deviceId;
//    if (Platform.isAndroid) {
//      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
//      deviceId = androidInfo.androidId;
//    } else {
//      IosDeviceInfo iOSInfo = await DeviceInfoPlugin().iosInfo;
//      deviceId = iOSInfo.identifierForVendor;
//    }
//    _appBloc.setDeviceIdAction(deviceId);
//  }

  _openLoginScreen() {
//    Routing().navigate2(context, widget.appType == AppType.DOCTOR ? LoginDoctorScreen() : LoginScreen(), replace: true);
  }

  @override
  void dispose() {
    _netStreamSub.cancel();
    _connectivity.disposeStream();
    _setupStateStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScaleUtil.instance = ScaleUtil(width: 375, height: 667)..init(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/bg_splash.png'), fit: BoxFit.cover),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                decoration: BoxDecoration(color: ptPrimaryColor(context).withOpacity(0.1)),
              ),
            ),
          ),
          Center(
            child: Container(
              width: deviceWidth(context) * 0.8,
              height: deviceWidth(context) * 0.8,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo2.png',
                    fit: BoxFit.contain,
                    width: deviceWidth(context) * 0.6,
                    height: deviceWidth(context) * 0.6,
                  ),
                  isConnect
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: RaisedButton(
                            onPressed: () async {
                              bool online = await _connectivity.check();
                              if (online) {
                                await prepareData();
                              } else {
                                BotToast.showText(text: 'Không có kết nối internet');
                              }
                            },
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: ptPrimaryColor(context), width: 4, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            child: Text(
                              "Thử kết nối lại".toUpperCase(),
                              style: ptBody1(context).copyWith(color: Colors.white),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
