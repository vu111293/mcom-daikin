import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:daikin/ui/customs/base_screen.dart';
import 'package:daikin/utils/hex_color.dart';
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
          showAlertDialog(context, 'Xãy ra lỗi khi giao tiếp với server. Vui lòng thử lại');
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
              flex: 2,
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
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/home.png',
                    fit: BoxFit.contain,
                    width: deviceWidth(context) * 0.35,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScaleUtil.getInstance().setHeight(16), bottom: ScaleUtil.getInstance().setHeight(8)),
                    child: Text('Smart home', style: ptHeadline(context).copyWith(fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: ScaleUtil.getInstance().setHeight(16),
                        left: ScaleUtil.getInstance().setWidth(16),
                        right: ScaleUtil.getInstance().setWidth(16)),
                    child: Text(
                      'Tận hưởng cuộc sống thoải mái vượt trội và đem lại cảm giác mát lạnh sảng khoái tối ưu.',
                      style: ptSubtitle(context),
                      textAlign: TextAlign.center,
                    ),
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
                                BotToast.showText(text: 'Không có kết nối internet');
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
            Expanded(child: Container())
          ],
        ),
      ),
    ));
  }
}
