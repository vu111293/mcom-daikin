import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/ui/pages/dashboard/course_info_screen.dart';
import 'package:daikin/ui/pages/home/rooms_list_view.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // initialise it here
  }

  @override
  Widget build(BuildContext context) {
    Routing().setContext(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          getAppBarUI(),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: HexColor(appColor2),
              indicatorWeight: 3,
              labelColor: HexColor(appColor),
              tabs: [
                Tab(text: "Rooms"),
                Tab(text: "Devices"),
              ],
            ),
          ),
          Container(
            height: contentScreen(context) - 60,
            child: TabBarView(
              children: <Widget>[
                RoomsListView(
                  callBack: () {
                    moveTo();
                  },
                ),
                RoomsListView(
                  callBack: () {
                    moveTo();
                  },
                ),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(),
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18, bottom: 2),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Home',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: StyleAppTheme.darkerText,
                  ),
                ),
                Text(
                  'Your home is now unsecured!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: StyleAppTheme.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 56,
            height: 56,
            child: Image.asset('assets/images/userImage.png'),
          )
        ],
      ),
    );
  }
}
