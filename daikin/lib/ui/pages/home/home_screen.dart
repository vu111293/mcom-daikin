import 'package:daikin/apis/net/user_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/pages/home/course_info_device_screen.dart';
import 'package:daikin/ui/pages/home/rooms_grid_view.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:daikin/ui/pages/home/devices_list_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  ApplicationBloc _appBloc;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    _tabController = TabController(length: 2, vsync: this); // initialise it here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          BaseHeaderScreen(
            title: "Nhà",
            subTitle: "Nhà của bạn bây giờ luôn được bảo đảm !",
          ),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: HexColor(appColor2),
              indicatorWeight: 3,
              labelColor: HexColor(appColor),
              unselectedLabelColor: HexColor(appColor),
              tabs: [
                Tab(text: "Danh sách phòng"),
                Tab(text: "Danh sách thiết bị"),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            children: <Widget>[
              RoomsGridView(),
              DeviceListView(),
            ],
            controller: _tabController,
          )),
        ],
      ),
    );
  }
}
