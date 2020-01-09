import 'dart:math';

import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/pages/dashboard/dashboard_screen.dart';
import 'package:daikin/ui/pages/home/device_list_view.dart';
import 'package:daikin/ui/pages/home/rooms_list_view.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum CategoryType { ui, coding, basic, game, chill }

class CourseInfoDeviceScreen extends StatefulWidget {
  String title;
  CourseInfoDeviceScreen({this.title = ''});
  @override
  _CourseInfoDeviceScreenState createState() => _CourseInfoDeviceScreenState();
}

class _CourseInfoDeviceScreenState extends State<CourseInfoDeviceScreen> with TickerProviderStateMixin {
  final double infoHeight = 400.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  CategoryType categoryType = CategoryType.ui;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: animationController, curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height - (MediaQuery.of(context).size.width / 1.2) + 120.0;

    return Container(
      color: StyleAppTheme.nearlyWhite,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              BaseHeaderScreen(
                isBack: true,
                title: widget.title.toUpperCase(),
              ),
              Container(
                height: contentScreen(context),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          FadeTransition(
                            opacity: animationController,
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/hotel/hotel_${Random().nextInt(7)}.png',
                                  fit: BoxFit.cover,
                                  height: 220,
                                  width: deviceWidth(context),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 120,
                            right: 0,
                            left: 0,
                            child: FadeTransition(
                              opacity: animationController,
                              // alignment: Alignment.center,
                              // scale: CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
                              child: Container(
                                  width: deviceWidth(context),
                                  height: 100,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      // colors: [Colors.red, Colors.blue],
                                      colors: [
                                        HexColor('#161F47').withOpacity(1),
                                        HexColor('#161F47').withOpacity(0.8),
                                        HexColor('#161F47').withOpacity(0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        width: deviceWidth(context) / 4,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 4),
                                              child: Image.asset(
                                                'assets/icons/Nhiet_ke_02.png',
                                                fit: BoxFit.cover,
                                                height: ptBody1(context).fontSize * 1.5,
                                                width: ptBody1(context).fontSize * 1.5,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text('22.5 °', style: ptBody2(context).copyWith(color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: deviceWidth(context) / 4,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 4),
                                              child: Image.asset(
                                                'assets/icons/Giot_nuoc_02.png',
                                                fit: BoxFit.cover,
                                                height: ptBody1(context).fontSize * 1.5,
                                                width: ptBody1(context).fontSize * 1.5,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text('52 %', style: ptBody2(context).copyWith(color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: deviceWidth(context) / 4,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 4),
                                              child: Image.asset(
                                                'assets/icons/Sam_set.png',
                                                fit: BoxFit.cover,
                                                height: ptBody1(context).fontSize * 1.5,
                                                width: ptBody1(context).fontSize * 1.5,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text('${NumberFormat.compact().format(2000)} w',
                                                style: ptBody2(context).copyWith(color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: deviceWidth(context) / 4,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 4),
                                              child: Image.asset(
                                                'assets/icons/Mat_troi_02.png',
                                                fit: BoxFit.cover,
                                                height: ptBody1(context).fontSize * 1.5,
                                                width: ptBody1(context).fontSize * 1.5,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(
                                              '${NumberFormat.compact().format(123456789)} lm',
                                              style: ptBody2(context).copyWith(color: Colors.white),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      FadeTransition(
                        opacity: animationController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                                  child: Text('Category', textAlign: TextAlign.left, style: ptTitle(context)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                                  child: Text('All', textAlign: TextAlign.left, style: ptSubtitle(context)),
                                ),
                              ],
                            ),
                            Container(
                              height: 72,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(16),
                                children: <Widget>[
                                  getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
                                  getButtonUI(CategoryType.coding, categoryType == CategoryType.coding),
                                  getButtonUI(CategoryType.basic, categoryType == CategoryType.basic),
                                  getButtonUI(CategoryType.game, categoryType == CategoryType.game),
                                  getButtonUI(CategoryType.chill, categoryType == CategoryType.chill),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                              child: Text('Running Devices', textAlign: TextAlign.left, style: ptTitle(context)),
                            ),
                            DeviceListView(
                              callBack: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Play Music';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Turn Light';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Alert';
    } else if (CategoryType.game == categoryTypeData) {
      txt = 'Games';
    } else if (CategoryType.chill == categoryTypeData) {
      txt = 'Chill';
    }
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        elevation: 8,
        shadowColor: Colors.black26,
        color: isSelected ? StyleAppTheme.nearlyBlue : StyleAppTheme.nearlyWhite,
        child: InkWell(
          splashColor: Colors.white24,
          onTap: () {
            setState(() {
              categoryType = categoryTypeData;
            });
          },
          child: Container(
            height: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected ? StyleAppTheme.nearlyWhite : StyleAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: StyleAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: StyleAppTheme.grey.withOpacity(0.2), offset: const Offset(1.1, 1.1), blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: StyleAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: StyleAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
