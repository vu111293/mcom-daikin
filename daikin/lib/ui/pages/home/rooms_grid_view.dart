import 'package:daikin/apis/local/room_local_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/dialog.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

import 'course_info_device_screen.dart';

class RoomsGridView extends StatefulWidget {
  const RoomsGridView({Key key, this.callBack}) : super(key: key);

  final Function(String title) callBack;
  @override
  _RoomsGridViewState createState() => _RoomsGridViewState();
}

class _RoomsGridViewState extends State<RoomsGridView> with TickerProviderStateMixin {
  // AnimationController animationController;
  ApplicationBloc _appBloc;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);

    // animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // animationController.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: StreamBuilder<List<Room>>(
            stream: _appBloc.homeBloc.roomDataStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox();
              } else {
                // Todo Please get room models from snapshot.data

                return Container(
                  height: deviceHeight(context) * 0.6,
                  child: GridView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: List<Widget>.generate(
                      snapshot.data.length,
                      (int index) {
                        // final int count = snapshot.data.length;
                        // final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                        //   CurvedAnimation(
                        //     parent: animationController,
                        //     curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                        //   ),
                        // );
                        // animationController.forward();

                        Room room = snapshot.data[index];

                        return CategoryView(
                          callback: () {
                            widget.callBack(room.getName);
                          },
                          room: room,
                          onIconTap: () {
                            RoomConfig conf = RoomLocalService.instance.getConfig(room.id);
                            showChangeIconDialog(context, conf.icon, onSave: (w) {
                              conf.icon = w.id;
                              RoomLocalService.instance.updateRoomConfig(conf);
                              setState(() {});
                            });
                          },
                          // animation: animation,
                          // animationController: animationController,
                        );
                      },
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.35,
                    ),
                  ),
                );
              }
            }));
  }
}

class CategoryView extends StatelessWidget {


  final VoidCallback callback;
  final Room room;
  final Function onIconTap;

  CategoryView({Key key, this.room, this.callback, this.onIconTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        elevation: 8,
        shadowColor: Colors.black26,
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Routing().navigate2(context, CourseInfoDeviceScreen(room: room));
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 InkWell(child: Image.asset(
                      room.getIconAssetPath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                ), onTap: onIconTap),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        upFirstText(room.getName),
                        textAlign: TextAlign.left,
                        style: ptTitle(context).copyWith(color: HexColor(appText)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          room.devices.length.toString() + ' thiết bị',
                          textAlign: TextAlign.left,
                          style: ptCaption(context).copyWith(color: HexColor(appColor2)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
