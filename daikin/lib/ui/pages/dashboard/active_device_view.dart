import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/pages/dashboard/rgb_screen.dart';
import 'package:daikin/ui/pages/device_detail/device_view_item.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

class ActiveDeviceListView extends StatefulWidget {
  const ActiveDeviceListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _ActiveDeviceListViewState createState() => _ActiveDeviceListViewState();
}

class _ActiveDeviceListViewState extends State<ActiveDeviceListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  ApplicationBloc _appBloc;
  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 134,
        width: double.infinity,
        child: StreamBuilder(
          stream: _appBloc.homeBloc.activeDeviceStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Không có thiết bị nào đang hoạt đông"),
              );
            } else {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text("Không có thiết bị nào đang hoạt đông"),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: snapshot.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  int length = snapshot.data.length;
                  if (length == 0) {
                    return Center(
                      child: Text("Không có thiết bị nào đang hoạt đông"),
                    );
                  } else {
                    final int count = length > 10 ? 10 : length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    animationController.forward();

                    return DeviceView(
                      device: snapshot.data[index],
                      animation: animation,
                      animationController: animationController,
                      callback: () {},
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DeviceView extends StatelessWidget {
  const DeviceView(
      {Key key,
      this.device,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Device device;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Text(
                                              device.name,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: StyleAppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 24, bottom: 24, left: 16),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 0.9,
                                  child: Image.asset(
                                    'assets/devices/rgb.png',
                                  )),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
