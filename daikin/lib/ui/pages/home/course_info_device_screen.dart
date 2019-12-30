import 'dart:math';

import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/ui/pages/home/device_list_view.dart';
import 'package:daikin/ui/pages/home/rooms_list_view.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

class CourseInfoDeviceScreen extends StatefulWidget {
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
        body: Stack(
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
              top: (MediaQuery.of(context).size.width / 1.2) - 120 - 70,
              right: 0,
              left: 0,
              child: FadeTransition(
                opacity: animationController,
                // alignment: Alignment.center,
                // scale: CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
                child: Container(
                    width: deviceWidth(context),
                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // scrollDirection: Axis.horizontal,
                      // padding: EdgeInsets.symmetric(horizontal: 20),
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.favorite,
                                  color: StyleAppTheme.nearlyWhite,
                                  size: ptBody1(context).fontSize * 1.5,
                                ),
                              ),
                              Text('22.5 °', style: ptBody1(context).copyWith(color: Colors.white))
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.favorite,
                                  color: StyleAppTheme.nearlyWhite,
                                  size: ptBody1(context).fontSize * 1.5,
                                ),
                              ),
                              Text('52 %', style: ptBody1(context).copyWith(color: Colors.white))
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.favorite,
                                  color: StyleAppTheme.nearlyWhite,
                                  size: ptBody1(context).fontSize * 1.5,
                                ),
                              ),
                              Text('269 w', style: ptBody1(context).copyWith(color: Colors.white))
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.favorite,
                                  color: StyleAppTheme.nearlyWhite,
                                  size: ptBody1(context).fontSize * 1.5,
                                ),
                              ),
                              Text('200 lm', style: ptBody1(context).copyWith(color: Colors.white))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 120,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: StyleAppTheme.nearlyWhite,
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: StyleAppTheme.grey.withOpacity(0.2), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: FadeTransition(
                  opacity: animationController,
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight, maxHeight: tempHeight > infoHeight ? tempHeight : infoHeight),
                      child: DeviceListView(
                        callBack: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: StyleAppTheme.nearlyBlack,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
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
