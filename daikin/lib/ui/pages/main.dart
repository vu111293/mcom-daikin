import 'dart:io';

import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/pages/dashboard/dashboard_screen.dart';
import 'package:daikin/ui/pages/home/home_screen.dart';
import 'package:daikin/ui/setting/profile_screen.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: TabBarView(
              children: [
                DashBoardScreen(),
                HomeScreen(),
                Container(
                  color: Colors.lightGreen,
                ),
                ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.format_align_right),
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
}
