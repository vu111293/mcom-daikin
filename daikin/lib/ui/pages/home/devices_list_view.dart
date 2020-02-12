import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import './../../customs/expansion_tile.dart' as expansionTile;

class DevicesListView extends StatefulWidget {
  final Function callBack;
  bool disableScroll;
  DevicesListView({Key key, this.callBack, this.disableScroll = false})
      : super(key: key);

  _DevicesListState createState() => _DevicesListState();
}

class _DevicesListState extends State<DevicesListView> {
  ApplicationBloc _appBloc;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _appBloc.homeBloc.roomDataStream,
      builder: (buildContext, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        } else
          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: widget.disableScroll
                  ? NeverScrollableScrollPhysics()
                  : BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return CustomDeviceList(
                  room: snapshot.data[index],
                );
              },
              itemCount: snapshot.data.length,
            ),
          );
      },
    );

    // Container(
    //   child: ListView.builder(
    //     itemBuilder: (context, index) {
    //       return CustomDeviceList(
    //         callback: widget.callBack,
    //         data: DeviceDataTest.deviceDataList[index],
    //       );
    //     },
    //     itemCount: DeviceDataTest.deviceDataList.length,
    //   ),
    // );
  }
}

class CustomDeviceList extends StatefulWidget {
  final Room room;
  CustomDeviceList({this.room});

  @override
  _CustomDeviceListState createState() => _CustomDeviceListState();
}

class _CustomDeviceListState extends State<CustomDeviceList> {
  ApplicationBloc _appBloc;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(widget.room);
  }

  Widget _buildTiles(Room root) {
    // if (root.devices.isEmpty)
    //   return ListTile(title: Text('Chưa có dữ liệu room device!'));
    return expansionTile.ExpansionTile(
        hideLeading: false,
        trailing: Container(
          height: 24,
          width: 24,
          child: CircleAvatar(
            backgroundColor: StyleAppTheme.nearlyBlue,
            child: Text(
              '${root.devices.length}',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        key: PageStorageKey<Room>(root),
        title: Text(
          root.name,
          style: TextStyle(color: StyleAppTheme.nearlyBlue),
        ),
        children: root.devices.map((item) => buildDevice(item)).toList());
  }

  Widget buildDevice(Device device) {
    if (device.type == "com.fibaro.binarySwitch") {
      return Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
        child: ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text(device.name),
          trailing: Switch(
            value: device.properties.value == 'true' ? true : false,
            onChanged: (val) {
              onSwitchDevice(val, device);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: Colors.white,
            activeTrackColor: HexColor(appColor),
            inactiveThumbColor: HexColor(appBorderColor),
            inactiveTrackColor: HexColor(appBorderColor),
          ),
        ),
      );
    } else if (device.type == "com.fibaro.FGRGBW441M") {
      return Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
        child: ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text(device.name),
          trailing: Switch(
            value: device.properties.value == '1' ? true : false,
            onChanged: (val) {
              onSwitchRGBDevice(val, device);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: Colors.white,
            activeTrackColor: HexColor(appColor),
            inactiveThumbColor: HexColor(appBorderColor),
            inactiveTrackColor: HexColor(appBorderColor),
          ),
        ),
      );
    } else if (device.type == "com.fibaro.FGD212") {
      return Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
        child: ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text(device.name),
          trailing: Switch(
            value: int.parse(device.properties.value) > 0 ? true : false,
            onChanged: (val) {
              onMultiSwitchDevice(val, device);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: Colors.white,
            activeTrackColor: HexColor(appColor),
            inactiveThumbColor: HexColor(appBorderColor),
            inactiveTrackColor: HexColor(appBorderColor),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: ListTile(
        leading: Icon(Icons.ac_unit),
        title: Text(device.name),
        // trailing: Switch(
        //   value: true,
        //   onChanged: (val) {
        //     print(val);
        //   },
        //   activeColor: Colors.green,
        //   inactiveThumbColor: Colors.pink,
        // ),
      ),
    );
  }

  onSwitchRGBDevice(bool val, Device device) {
    //BotToast.showText(text: 'Đổi sang trạng thái ' + device.properties.value);
    setState(() {
      if (val) {
        device.properties.value = '1';
      } else {
        device.properties.value = '0';
      }
    });

    if (!val) {
      BusinessService().turnOffDevice(device.id);
      BotToast.showText(text: "Tắt thiết bị thành công");
    } else {
      BusinessService().turnOnDevice(device.id);
      BotToast.showText(text: "Bật thiết bị thành công");
    }
    _appBloc.homeBloc.updateActiveDevice();
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

  onMultiSwitchDevice(bool val, Device device) {
    if (val) {
      device.properties.value = 99.toString();
    } else {
      device.properties.value = 0.toString();
    }
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
}

// class CustomDeviceList extends StatelessWidget {
//   final Room data;
//   final Function callback;
//   const CustomDeviceList({@required this.data, @required this.callback});
//   @override
//   Widget build(BuildContext context) {
//     return _buildTiles(data);
//   }

//   Widget _buildTiles(Room root) {
//     // if (root.devices.isEmpty)
//     //   return ListTile(title: Text('Chưa có dữ liệu room device!'));
//     return expansionTile.ExpansionTile(
//         trailing: Container(
//           height: 24,
//           width: 24,
//           child: CircleAvatar(
//             backgroundColor: StyleAppTheme.nearlyBlue,
//             child: Text(
//               '${root.devices.length}',
//               style: TextStyle(fontSize: 14),
//             ),
//           ),
//         ),
//         key: PageStorageKey<Room>(root),
//         title: Text(
//           root.name,
//           style: TextStyle(color: StyleAppTheme.nearlyBlue),
//         ),
//         children: root.devices.map((item) => buildDevice(item)).toList());
//   }

//   Widget buildDevice(Device device) {
//     if (device.type == "com.fibaro.binarySwitch") {
//       return Container(
//         padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
//         child: ListTile(
//           leading: Icon(Icons.ac_unit),
//           title: Text(device.name),
//           trailing: Switch(
//             value: device.properties.value == 'true' ? true: false,
//             onChanged: (val) {
//               device.properties.value = 'false';
//             },
//             activeColor: Colors.green,
//             inactiveThumbColor: Colors.pink,
//           ),
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
//       child: ListTile(
//         leading: Icon(Icons.ac_unit),
//         title: Text(device.name),
//         trailing: Switch(
//           value: true,
//           onChanged: (val) {
//             print(val);
//           },
//           activeColor: Colors.green,
//           inactiveThumbColor: Colors.pink,
//         ),
//       ),
//     );
//   }
// }
