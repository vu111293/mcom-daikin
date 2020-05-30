import 'dart:async';
import 'dart:io';

import 'package:daikin/apis/net/user_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/ui/pages/dashboard/dashboard_screen.dart';
import 'package:daikin/ui/pages/home/home_screen.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/ui/setting/setting_screen.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  ApplicationBloc _appBloc;
  TabController _tabController;
  StreamSubscription _switchPageStreamSub;

  int tabLength = 3;
  @override
  void initState() {
      _appBloc = BlocProvider.of<ApplicationBloc>(context);
      _tabController = TabController(vsync: this, length: tabLength);
      _switchPageStreamSub = _appBloc.mainScreenBloc.requestSwitchPageEvent.listen((pageIndex) {
        _tabController.animateTo(pageIndex);
      });
      _registerFireBaseMessage();
      prepareAppData();
    super.initState();
  }

  prepareAppData() async {
    await Future.delayed(Duration(seconds: 1));
    showWaitingDialog(context);
    try {
      await _appBloc.fetchUserData();
    } catch (e) {
      Navigator.pop(context);
      showAlertDialog(context, 'Không thể lấy dữ liệu từ server. Vui lòng thử lại sau.\nLỗi ${e.toString()}', confirmTap: () {
        exit(0);
      });
    } finally {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _switchPageStreamSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Routing().setContext(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      child: DefaultTabController(
        length: tabLength,
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: TabBarView(
              controller: _tabController,
              children: [
                DashBoardScreen(),
                HomeScreen(),
                SettingScreen(),
                // Container(
                //   color: Colors.red,
                // ),
              ],
            ),
          ),
          bottomNavigationBar: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.settings),
              )
            ],
            labelColor: Colors.white,
            // unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: HexColor(appColor2),
          ),
          backgroundColor: HexColor(appColor),
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

  _registerFireBaseMessage() async {
    String token = await FirebaseMessaging().getToken();
    print('fcm token $token');
    UserService().registerNotify(_appBloc.authBloc.currentUser.id, token);
  }
}
