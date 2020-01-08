import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/core/auth_service.dart';
import 'package:daikin/app.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/ui/pages/login/confirm_number_phone_screen.dart';
import 'package:daikin/ui/pages/login/login_screen.dart';
import 'package:daikin/ui/pages/main.dart';
import 'package:daikin/ui/pages/splash/introduction_screen.dart';
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
//    await _cacheDeviceId();
    _setupStateStream = _appBloc.setupStateEvent.listen(
      (s) async {
        if (s == 'done') {
          print("@@@@@@@@@@@@@@@@@@@@@@@");
          // Routing().navigate2(context, IntroductionScreen());
          // Routing().navigate2(context, MainScreen());
          try {
            // make auto login or show login page
            AccessStatus tokenState = await LoopBackAuth().loadAccessToken();

            print(tokenState);

            if (tokenState != AccessStatus.TOKEN_VALID) {
              _openLoginScreen();
            } else {
              // LUser user =
              //     await UserService().getProfile(LoopBackAuth().userId);
              // _appBloc.authBloc.updateUserAction(user);

              Routing().navigate2(context, MainScreen());

              // if (user.isClientFilledInfo) {
              //   Routing().navigate2(context, HomeScreen());
              // } else {
              //   Routing()
              //       .navigate2(context, UpdateInfoLoginScreen(), replace: true);
              // }
              _setupStateStream.cancel();
            }
          } catch (e) {
            LoopBackAuth().clear();
            _openLoginScreen();
          }
        } else {
          showAlertDialog(
              context, 'Xãy ra lỗi khi giao tiếp với server. Vui lòng thử lại');
        }
      },
    );

    _appBloc.loadBaseData();
    _cacheDeviceId();
    return Future;
  }

  _cacheDeviceId() async {
    String deviceId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      deviceId = androidInfo.androidId;
    } else {
      IosDeviceInfo iOSInfo = await DeviceInfoPlugin().iosInfo;
      deviceId = iOSInfo.identifierForVendor;
    }
    _appBloc.setDeviceIdAction(deviceId);
  }

  _openLoginScreen() {
    Routing().navigate2(context, LoginScreen(), replace: true);
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
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(image: AssetImage('assets/images/bg_splash.png'), fit: BoxFit.cover),
          //   ),
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          //     child: Container(
          //       decoration: BoxDecoration(color: ptPrimaryColor(context).withOpacity(0.1)),
          //     ),
          //   ),
          // ),
          Container(
            width: deviceWidth(context),
            height: deviceHeight(context),
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/app_logo2.png',
                    fit: BoxFit.contain,
                    width: deviceWidth(context) * 0.7,
                  ),
                  isConnect
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: FlatButton(
                            onPressed: () async {
                              bool online = await _connectivity.check();
                              if (online) {
                                await prepareData();
                              } else {
                                BotToast.showText(
                                    text: 'Không có kết nối internet');
                              }
                            },
                            child: Text(
                              "Thử kết nối lại".toUpperCase(),
                              style: ptBody1(context).copyWith(),
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
