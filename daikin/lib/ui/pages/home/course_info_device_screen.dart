import 'dart:math';

import 'package:daikin/apis/local/room_local_service.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/ui/pages/home/devices_grid_view.dart';
import 'package:daikin/utils/device_util.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

enum CategoryType { ui, coding, basic, game, chill }

class CourseInfoDeviceScreen extends StatefulWidget {
  Room room;

  CourseInfoDeviceScreen({this.room});

  @override
  _CourseInfoDeviceScreenState createState() => _CourseInfoDeviceScreenState();
}

class _CourseInfoDeviceScreenState extends State<CourseInfoDeviceScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 400.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  bool isSwitched = false;

  CategoryType categoryType = CategoryType.ui;
  RoomConfig _roomConfig;

  @override
  void initState() {
    isSwitched = widget.room.devices.firstWhere((d) => DeviceUtil.isTurnOn(d) == false, orElse: ()=>null) == null;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    _roomConfig = RoomLocalService.instance.getConfig(widget.room.id);
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
    String roomName = upFirstText(widget.room.getName);
    return Container(
      color: StyleAppTheme.nearlyWhite,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              BaseHeaderScreen(
                isBack: true,
                title: upFirstText(roomName),
                onTitleTap: () {
                  showChangeRoomNameDialog(context, roomName, onSave: (name) {
                    _roomConfig.name = name;
                    RoomLocalService.instance.updateRoomConfig(_roomConfig);
                    setState(() {});
                  });
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ImageBackdrop(
                        animationController: animationController,
                        room: widget.room,
                        config: _roomConfig,
                        onConvertTap: () {
                          showChangeCoverDialog(context, _roomConfig.cover, onSave: (w) {
                            _roomConfig.cover = w.id;
                            RoomLocalService.instance.updateRoomConfig(_roomConfig);
                            setState(() {});
                          });
                        },
                      ),
                      FadeTransition(
                        opacity: animationController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            widget.room.scenes.length > 0
                                ? Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 16,
                                                  right: 16),
                                              child: Text('Danh sách kịch bản',
                                                  textAlign: TextAlign.left,
                                                  style: ptTitle(context)),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       top: 8.0, left: 16, right: 16),
                                            //   child: Text('All',
                                            //       textAlign: TextAlign.left,
                                            //       style: ptSubtitle(context)),
                                            // ),
                                          ],
                                        ),
                                        //widget.room.scenes.length > 0 ?
                                        Container(
                                            height: 72,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.all(16),
                                                itemCount: widget.room.scenes.length,
                                                itemBuilder: (BuildContext ctxt, int index) {
                                                  return getButtonUI(widget.room.scenes[index]);
                                                })

                                            // ListView(
                                            //   scrollDirection: Axis.horizontal,
                                            //   shrinkWrap: true,
                                            //   padding: EdgeInsets.all(16),
                                            //   children: <Widget>[],
                                            // ),
                                            ) //: SizedBox(),
                                      ],
                                    ),
                                  )
                                : Container(),
                            widget.room.devices.length > 0
                                ? Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 16,
                                                  right: 16),
                                              child: Text('Danh sách thiết bị',
                                                  textAlign: TextAlign.left,
                                                  style: ptTitle(context)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(right: 8),
                                              child: Transform.scale(
                                                scale: 1.0,
                                                child: Switch(
                                                  value: isSwitched,
                                                  onChanged: (value) async {
                                                    for (int i = 0; i < widget.room.devices.length; ++i) {
                                                      Device d = widget.room.devices[i];
                                                      await DeviceUtil.turnDevice(d, value);
                                                    }
                                                    setState(() {
                                                      isSwitched = value;
                                                    });
                                                  },
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .padded,
                                                  activeColor: Colors.white,
                                                  activeTrackColor:
                                                      HexColor(appColor),
                                                  inactiveThumbColor:
                                                      HexColor(appBorderColor),
                                                  inactiveTrackColor:
                                                      HexColor(appBorderColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        DeviceGridView(
                                          devices: widget.room.devices,
                                          isAlarm: widget.room.isAlarmRoom
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget getButtonUI(Scene scene) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        elevation: 8,
        shadowColor: Colors.black26,
        color: StyleAppTheme.nearlyWhite,
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
                  upFirstText(scene.getName),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: StyleAppTheme.nearlyBlue,
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
            BoxShadow(
                color: StyleAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
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

class ImageBackdrop extends StatelessWidget {
  final Room room;
  final RoomConfig config;
  final Function onConvertTap;
  final AnimationController animationController;

  ImageBackdrop({
    Key key,
    this.room,
    this.config,
    this.onConvertTap,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String coverPath = config.getCoverPathAsset();
    return Stack(
      children: <Widget>[
        FadeTransition(
          opacity: animationController,
          child: Column(
            children: <Widget>[
              InkWell(
                  child: coverPath.startsWith('http')
                      ? Image.network(coverPath , fit: BoxFit.cover, height: 220, width: deviceWidth(context))
                      : Image.asset(coverPath , fit: BoxFit.cover, height: 220, width: deviceWidth(context)),
                  onTap: onConvertTap),
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
                    room.temperature != null ? Container(
                      width: deviceWidth(context) / 3,
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
                          Text(
                              room.temperature.properties.value + ' °C',
                              style: ptBody2(context).copyWith(color: Colors.white))
                        ],
                      ),
                    ) : Container(),
//                    room.humidity != null ? Container(
//                      width: deviceWidth(context) / 3,
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.only(right: 4),
//                            child: Image.asset(
//                              'assets/icons/Giot_nuoc_02.png',
//                              fit: BoxFit.cover,
//                              height: ptBody1(context).fontSize * 1.5,
//                              width: ptBody1(context).fontSize * 1.5,
//                              color: Colors.white,
//                            ),
//                          ),
//                          Text(room.humidity.properties.value + ' %',
//                              style: ptBody2(context)
//                                  .copyWith(color: Colors.white))
//                        ],
//                      ),
//                    ) : Container(),
                    room.light != null ? Container(
                      width: deviceWidth(context) / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Image.asset(
                              'assets/icons/Den_tran.png',
                              fit: BoxFit.cover,
                              height: ptBody1(context).fontSize * 1.5,
                              width: ptBody1(context).fontSize * 1.5,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                              '${room.light.properties.value} lux',
                              style: ptBody2(context)
                                  .copyWith(color: Colors.white))
                        ],
                      ),
                    ) : Container(),
                    // Container(
                    //   width: deviceWidth(context) / 4,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 4),
                    //         child: Image.asset(
                    //           'assets/icons/Mat_troi_02.png',
                    //           fit: BoxFit.cover,
                    //           height: ptBody1(context).fontSize * 1.5,
                    //           width: ptBody1(context).fontSize * 1.5,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       Expanded(
                    //           child: Text(
                    //         '${NumberFormat.compact().format(123456789)} lm',
                    //         style:
                    //             ptBody2(context).copyWith(color: Colors.white),
                    //         maxLines: 1,
                    //         overflow: TextOverflow.ellipsis,
                    //       ))
                    //     ],
                    //   ),
                    // ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
