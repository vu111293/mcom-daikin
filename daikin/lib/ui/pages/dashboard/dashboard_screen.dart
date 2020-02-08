import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/pages/dashboard/category_list_view.dart';
import 'package:daikin/ui/pages/dashboard/camera_screen.dart';
import 'package:daikin/ui/pages/dashboard/camera_list_view.dart';
import 'package:daikin/ui/pages/home/home_screen.dart';
import 'package:daikin/ui/pages/main.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<String> imgList = [
  "https://tmshotel.vn/uploads/images/5_1.jpg",
  "https://nhadatmientrung24h.com/upload/1/products/l_1473106134_couplesuite.jpg",
  "https://q-ec.bstatic.com/images/hotel/max1024x768/449/44952708.jpg",
  "https://sites.google.com/site/hyattdanangresort/_/rsrc/1538973313583/phong/three-bedroom-ocean-villa/Hyatt-Regency-Danang-Resort-and-Spa-P031-Ocean-Villa-Living-Area.adapt.16x9.1280.720.jpg",
  "https://q-ec.bstatic.com/images/hotel/max1024x768/133/133782872.jpg",
  "https://r-cf.bstatic.com/images/hotel/max1024x768/157/157746542.jpg",
];

enum CategoryType { ui, coding, basic, game, chill }

class DashBoardScreen extends StatefulWidget {
  final TabController tabController;
  DashBoardScreen({this.tabController});
  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int _current = 0;
  ApplicationBloc _appBloc;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Routing().setContext(context);
    return WillPopScope(
      child: Container(
        color: StyleAppTheme.nearlyWhite,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              BaseHeaderScreen(
                title: "Chào Bạn !",
                subTitle: "Chào mừng bạn đến,",
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.only(bottom: 24.0),
                children: <Widget>[
                  CarouselSlider(
                    items: map<Widget>(
                      imgList,
                      (index, i) {
                        return Opacity(
//                          opacity: _current == index ? 1 : 0.3,
                          opacity: 1.0,
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              child: Image.network(
                                i,
                                fit: BoxFit.cover,
                                width: deviceWidth(context) * 0.8,
                                cacheHeight: 180,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    autoPlay: true,
                    height: 180,
                    enlargeCenterPage: true,
                    // aspectRatio: 1,
                    pauseAutoPlayOnTouch: Duration(milliseconds: 150),
                    onPageChanged: (index) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(
                      imgList,
                      (index, url) {
                        return Container(
                          width: 16.0,
                          height: 3.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: _current == index
                                ? HexColor(appColor).withOpacity(0.9)
                                : Color.fromRGBO(0, 0, 0, 0.2),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                        );
                      },
                    ),
                  ),
                  getSceneUI(),
                  getCategoryUI(),
                  getPopularCourseUI(),
                ],
              )),
            ],
          ),
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

  Widget getSceneUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
              child: Text('Scenes',
                  textAlign: TextAlign.left, style: ptTitle(context)),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
            //   child: Text('All',
            //       textAlign: TextAlign.left, style: ptSubtitle(context)),
            // ),
          ],
        ),
        Container(
          height: 72,
          child: StreamBuilder(
            stream: _appBloc.homeBloc.scenesDataStream,
            builder: (context, snapshot) {
              print("@@@@@@@@@@@@@@@@@@@@@@@2");

              if (!snapshot.hasData) {
                return SizedBox();
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return getButtonUI(snapshot.data[index], false);
                    });
                //           ListView(
                //   scrollDirection: Axis.horizontal,
                //   shrinkWrap: true,
                //   padding: EdgeInsets.all(16),
                //   children: <Widget>[

                //     // getButtonUI(CategoryType.ui, false),
                //     // getButtonUI(CategoryType.coding, false),
                //     // getButtonUI(CategoryType.basic, false),
                //     // getButtonUI(CategoryType.game, false),
                //     // getButtonUI(CategoryType.chill, false),
                //   ],
                // );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget getButtonUI(Scene scene, bool isSelected) {
    String txt = scene.name;

    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        elevation: 8,
        shadowColor: Colors.black26,
        color:
            isSelected ? StyleAppTheme.nearlyBlue : StyleAppTheme.nearlyWhite,
        child: InkWell(
          splashColor: Colors.white24,
          onTap: () {
            setState(() {
              showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                  title: Text('Thông báo'),
                  content: Text('Bạn có muốn bật scene này ?'),
                  actions: [
                    FlatButton(
                      child: Text('Đồng ý'),
                      onPressed: () {
                        BusinessService().callSceneAction(scene.id.toString());
                        Navigator.pop(c, false);
                      },
                    ),
                    FlatButton(
                      child: Text('Hủy'),
                      onPressed: () => Navigator.pop(c, false),
                    ),
                  ],
                ),
              );
              //categoryType = categoryTypeData;
            });
          },
          child: Container(
            height: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? StyleAppTheme.nearlyWhite
                        : StyleAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
              child: Text('Running Devices',
                  textAlign: TextAlign.left, style: ptTitle(context)),
            ),
            GestureDetector(
              onTap: () {
                widget.tabController.animateTo(1);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                child: Text('All',
                    textAlign: TextAlign.left, style: ptSubtitle(context)),
              ),
            ),
          ],
        ),
        CategoryListView(
          callBack: () {},
        ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 0, right: 16),
                child: Text('Cameras',
                    textAlign: TextAlign.left, style: ptTitle(context)),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
              //   child: Text('All',
              //       textAlign: TextAlign.left, style: ptSubtitle(context)),
              // ),
            ],
          ),
          CameraListView(
            callBack: (Device item) {
              moveTo(item);
            },
          ),
        ],
      ),
    );
  }

  void moveTo(item) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CameraScreen(item: item),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: StyleAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for course',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}
