import 'package:after_layout/after_layout.dart';
import 'package:daikin/apis/local/local_setting.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/ui/pages/home/rooms_grid_view.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/ui/setting/my_center_screen.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:daikin/ui/pages/home/devices_list_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, AfterLayoutMixin<HomeScreen> {

  ApplicationBloc _appBloc;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    _tabController = TabController(length: 2, vsync: this); // initialise it here
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    bool isDemo = await _appBloc.centerBloc.isDemoCenterDevice;
    bool askRecommend = await LocalSetting().getRequireAddDevice();
    if (isDemo && askRecommend) {
      showAlertWithTitleDialog(
          context,
          'THÔNG BÁO',
          'Bạn đang sử dụng thiết bị trung tâm demo, vui lòng thêm thiết bị trung tâm.',
          secondAction: 'ĐỂ SAU',
          secondTap: () {
            LocalSetting().setRequireAddDevice(false);
            Navigator.pop(context);
          },
          firstAction: 'THÊM THIẾT BỊ',
          firstTap: () {
            Navigator.pop(context);
            _appBloc.mainScreenBloc.requestNeedToAddCenterDevice();
            Routing().navigate2(context, MyCenterScreen(), routeName: '/mycenterscreen');
          }
      );
    }
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
