import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/pages/dashboard/rgb_screen.dart';
import 'package:daikin/ui/pages/device_detail/blinds_device_screen.dart';
import 'package:daikin/ui/pages/device_detail/device_on_off_detail_screen.dart';
import 'package:daikin/ui/pages/device_detail/device_view_item.dart';
import 'package:daikin/ui/pages/device_detail/switch_multi_device.dart';
import 'package:daikin/ui/pages/device_detail/virtual_device_screen.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

class ActiveDeviceListView extends StatefulWidget {
  const ActiveDeviceListView({Key key, this.callBack})
      : super(key: key);

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
                      callbackParent: () {
                        routingToDevicePage(snapshot.data[index]);
                      },
                      callback: (value) {
                        BusinessService()
                            .turnOffDevice(snapshot.data[index].id);
                        BotToast.showText(text: "Tắt thiết bị thành công");
                        snapshot.data[index].properties.value =
                            value.toString();
                        _appBloc.homeBloc.updateActiveDevice();
                        setState(() {});
                      },
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

  onSwitchDevice(bool val, Device device) {
    device.properties.value = val.toString();
    //BotToast.showText(text: 'Đổi sang trạng thái ' + device.properties.value);
    setState(() {});

    if (!val) {
      BusinessService().turnOffDevice(device.id);
      BotToast.showText(text: "Tắt thiết bị thành công");
    } else {
      BusinessService().turnOnDevice(device.id);
      BotToast.showText(text: "Bật thiết bị thành công");
    }
    _appBloc.homeBloc.updateActiveDevice();
  }

  void _refreshDeviceInfo(Device d) async {
    Device device = await BusinessService().getDeviceDetail(d.id);
    _appBloc.homeBloc.updateDevice(device);
    setState(() {
      d = device;
    });
  }

  onSwitchMultiDevice(int val, Device device) {
    //BotToast.showText(text: 'Đổi sang trạng thái ' + device.properties.value);
    setState(() {
      device.properties.value = val.toString();
    });

    if (val == 0) {
      BusinessService().setValue(device.id, val);
      BotToast.showText(text: "Tắt thiết bị thành công");
    } else {
      BusinessService().setValue(device.id, val);
      BotToast.showText(text: "Thay đổi độ sáng thành công");
    }

    // if (!val) {
    //   BusinessService().turnOffDevice(device.id);
    //   BotToast.showText(text: "Tắt thiết bị thành công");
    // } else {
    //   BusinessService().turnOnDevice(device.id);
    //   BotToast.showText(text: "Bật thiết bị thành công");
    // }
  }

  onClickMultiDevice(bool val, Device device) {
    if (!val) {
      setState(() {
        device.properties.value = 0.toString();
      });

      BusinessService().turnOffDevice(device.id);
      BotToast.showText(text: "Tắt thiết bị thành công");
    } else {
      setState(() {
        device.properties.value = 99.toString();
      });

      BusinessService().turnOnDevice(device.id);
      BotToast.showText(text: "Bật thiết bị thành công");
    }
    _appBloc.homeBloc.updateActiveDevice();
  }

  void routingToDevicePage(Device device) {
    if (device.type == "com.fibaro.binarySwitch") {
      bool isSwitched = device.properties.value == 'true' ? true : false;

      Routing().navigate2(
          context,
          DeviceOnOffDetailScreen(
            item: device,
            status: isSwitched,
            callback: (value) {
              onSwitchDevice(value, device);
            },
          ));
    } else if (device.type == "com.fibaro.FGRGBW441M") {
      Routing().navigate2(context, RgbScreen(device: device)).then((d) {
        _refreshDeviceInfo(device);
      });
    } else if (device.type == "com.fibaro.FGD212") {
      Routing().navigate2(
          context,
          SwitchMultiDevice(
            device: device,
            setValue: (value) {
              onSwitchMultiDevice(value, device);
            },
            onClick: (value) {
              onClickMultiDevice(value, device);
            },
          ));
    } else if (device.type == "virtual_device") {
      Routing().navigate2(context, VirtualDeviceScreen(device: device));
    } else if (device.type == "com.fibaro.FGRM222") {
      Routing().navigate2(
          context,
          BlindsDeviceScreen(
            device: device,
          ));
    } else {
      bool isSwitched = device.properties.value == 'true' ? true : false;

      Routing().navigate2(
          context,
          DeviceOnOffDetailScreen(
            item: device,
            status: isSwitched,
            callback: () {},
          ));
    }
  }
}

class DeviceView extends StatelessWidget {
  const DeviceView({Key key, this.device, this.callback, this.callbackParent})
      : super(key: key);

  final Function callback;
  final Function callbackParent;
  final Device device;
  final bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        callbackParent();
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48 + 24.0,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text(
                                      upFirstText(device.name),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        letterSpacing: 0.27,
                                        color: StyleAppTheme.darkerText,
                                      ),
                                    ),
                                  ),
                                  // const Expanded(
                                  //   child: SizedBox(),
                                  // ),
                                  Container(
                                      height: 30,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: -5,
                                            left: -10,
                                            child: Transform.scale(
                                              scale: 1.0,
                                              child: Switch(
                                                value: isSwitched,
                                                onChanged: (value) {
                                                  callback(value);
                                                  //callback(value);
                                                  // setState(() {
                                                  //   isSwitched = value;
                                                  // });
                                                  BusinessService().turnOffDevice(device.id);
                                                  BotToast.showText(text: "Tắt thiết bị thành công");
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
                                      )),
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
                  padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
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
                          child: Image.network(device.getDeviceIconURL, fit: BoxFit.contain)
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
