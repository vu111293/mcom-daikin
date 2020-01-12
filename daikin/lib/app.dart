import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/pages/splash/splash_screen.dart';
import 'package:daikin/utils/hex_color.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/application_bloc.dart';
import 'blocs/bloc_provider.dart';
import 'constants/styleAppTheme.dart';

class MyApp extends StatefulWidget {
  final AppConfig appConf;

  MyApp({Key key, this.appConf}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  ApplicationBloc _appBloc;
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  var _primaryColor = HexColor(appColor); // This will hold the value of the app main color
  double fontSize = 15.0;

  @override
  void initState() {
//    getValuesSF();
    _appBloc = ApplicationBloc();
    PaintingBinding.instance.imageCache.maximumSizeBytes = 10485760 * 20; // 2
    super.initState();
    WidgetsBinding.instance.addObserver(this);
//    initFCM();
  }

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.resumed:
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    _appBloc.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
      bloc: _appBloc,
      child: BotToastInit(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [BotToastNavigatorObserver()],
          home: SplashScreen(appType: widget.appConf.appType),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en'), // English
            const Locale('vi'), // VietNam
          ],
          title: widget.appConf.appName,
          theme: ThemeData(
            // primarySwatch: Colors.blue,
            primaryColor: HexColor(appColor),
            textTheme: StyleAppTheme.textTheme,
            platform: TargetPlatform.iOS,
          ),
//          theme: _theme(),
        ),
      ),
    );
  }

  // Logic methods

  // FCM session

//  void initFCM() async {
//    await _firebaseMessaging.subscribeToTopic("main");
//
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("bambi FCM onMessage: $message");
//        _handleMessageOnLaunch(message, AppStartMode.LIVE);
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print("phat onLaunch: $message");
//        _handleMessageOnLaunch(message, AppStartMode.LAUNCH);
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print("bambi FCM onResume: $message");
//        _handleMessageOnLaunch(message, AppStartMode.RESUME);
//      },
//    );
//
//    _firebaseMessaging
//        .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
//    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
//      print("bambi FCM Settings registered: $settings");
//    });
//  }
//
//  _handleMessageOnLaunch(Map<String, dynamic> message, AppStartMode startMode) {
//    String type = Platform.isAndroid ? message['data']['type'] : message['type'];
//    print('type $type ');
//    String dataId = Platform.isAndroid ? message['data']['id'] : message['id'];
//    String id = dataId != null && dataId != '' ? dataId : null;
//    print('dataId $id ');
//
//    if (type != null) {
//      switch (type.toLowerCase()) {
//        case 'post':
//          if (startMode == AppStartMode.LAUNCH) {
//            _appBloc.addNotifyActionWhenOpen(NotifyAction(id: id, type: NotifyType.POST));
//          } else if (startMode == AppStartMode.RESUME) {
//            if (id != null) {
//              Future.delayed(Duration(milliseconds: 500), () {
//                Routing().navigate2(Routing().latestContext, DocumentDetailScreen(postId: id));
//              });
//            }
//          } else if (startMode == AppStartMode.LIVE) {
//            String msg = getMessageFromNotify(message);
//            if (msg != null) {
//              var cancelToastFuc;
//              cancelToastFuc = BotToast.showSimpleNotification(
//                  title: 'Thông báo',
//                  subTitle: msg,
//                  duration: Duration(seconds: 5),
//                  onTap: () async {
//                    Future.delayed(Duration(milliseconds: 500), () {
//                      Routing().navigate2(Routing().latestContext, DocumentDetailScreen(postId: id));
//                    });
//                    cancelToastFuc();
//                  });
//            }
//          }
//          break;
//        case 'issue':
//          if (startMode == AppStartMode.LAUNCH) {
//            _appBloc.addNotifyActionWhenOpen(NotifyAction(id: id, type: NotifyType.ISSUE));
//          } else if (startMode == AppStartMode.RESUME) {
//            _openQuestion(id);
//
//            // Refresh question data
//            _appBloc.loadUserData();
//            _appBloc.pushNotiUpdateQuestionAction("");
//          } else if (startMode == AppStartMode.LIVE) {
//            String msg = getMessageFromNotify(message);
//            if (msg != null) {
//              var cancelToastFuc;
//              cancelToastFuc = BotToast.showSimpleNotification(
//                  title: 'Thông báo',
//                  subTitle: msg,
//                  duration: Duration(seconds: 5),
//                  onTap: () async {
//                    _openQuestion(id);
//                    cancelToastFuc();
//                  });
//            }
//
//            // Refresh question data
//            _appBloc.loadUserData();
//            _appBloc.pushNotiUpdateQuestionAction(""); // Todo please insert noti question here
//          }
//          break;
//        case 'news':
//          if (startMode == AppStartMode.LAUNCH) {
//            _appBloc.addNotifyActionWhenOpen(NotifyAction(type: NotifyType.NEWS));
//          } else if (startMode == AppStartMode.RESUME) {
//            Routing().navigate2(Routing().latestContext, NotificationScreen());
//          } else if (startMode == AppStartMode.LIVE) {
//            String msg = getMessageFromNotify(message);
//            if (msg != null) {
//              var cancelToastFuc;
//              cancelToastFuc = BotToast.showSimpleNotification(
//                  title: 'Thông báo',
//                  subTitle: msg,
//                  duration: Duration(seconds: 5),
//                  onTap: () async {
//                    Routing().navigate2(Routing().latestContext, NotificationScreen());
//                    cancelToastFuc();
//                  });
//            }
//          }
//          break;
//        default:
//          break;
//      }
//    }
//  }
//
//  String getMessageFromNotify(Map<String, dynamic> message) {
//    String title = Platform.isAndroid ? message['notification']['title'] : message['aps']['alert']['title'];
//    String content = Platform.isAndroid ? message['notification']['body'] : message['aps']['alert']['body'];
//    if (title != null && title.isNotEmpty && content != null && content.isNotEmpty) {
//      return '$title: $content';
//    }
//    if (title != null && title.isNotEmpty) {
//      return title;
//    }
//    if (content != null && content.isNotEmpty) {
//      return content;
//    }
//    return null;
//  }
//
//  String getQuestionIdFromMessage(Map<String, dynamic> message) {
//    return Platform.isAndroid ? message['data']['id'] : message['id'];
//  }
//
//  Future _openQuestion(String id) async {
//    LQuestionResponse q = _appBloc.allQuestionList.firstWhere((item) => item.id == id, orElse: () => null);
//    if (q != null) {
//      await Future.delayed(Duration(milliseconds: 500), () {
//        Routing().navigate2(Routing().latestContext, QuestionDetailScreen(question: q));
//      });
//    } else {
//      if (mounted) {
//        Toast.show('Câu hỏi đã bị thay đổi hoặc không tồn tại', Routing().latestContext);
//      }
//    }
//    return Future;
//  }

//  getValuesSF() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    //Return String
//    if (prefs.containsKey('primariColor')) {
//      String primariColor = prefs.getString('primariColor');
//      String valueString = primariColor.split('(0x')[1].split(')')[0];
//      int value = int.parse(valueString, radix: 16);
//      Color otherColor = new Color(value);
//      setState(() {
//        _primaryColor = otherColor;
//      });
//    }
//  }
}

enum AppStartMode { RESUME, LAUNCH, LIVE }

enum AppType { PRODUCTION, STAGING }

class AppConfig {
  final String appName;
  final AppType appType;

  AppConfig({this.appName, this.appType});
}
