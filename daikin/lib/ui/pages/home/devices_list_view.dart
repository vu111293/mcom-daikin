import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/models/business_models.dart';
import 'package:flutter/material.dart';
import './../../customs/expansion_tile.dart' as expansionTile;

class DevicesListView extends StatefulWidget {
  final Function callBack;

  const DevicesListView({Key key, this.callBack}) : super(key: key);

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
              itemBuilder: (context, index) {
                return CustomDeviceList(
                  callback: widget.callBack,
                  data: snapshot.data[index],
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

class CustomDeviceList extends StatelessWidget {
  final Room data;
  final Function callback;
  const CustomDeviceList({@required this.data, @required this.callback});
  @override
  Widget build(BuildContext context) {
    return _buildTiles(data);
  }

  Widget _buildTiles(Room root) {
    // if (root.devices.isEmpty)
    //   return ListTile(title: Text('Chưa có dữ liệu room device!'));
    return expansionTile.ExpansionTile(
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
        children: root.devices
            .map((item) => Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: ListTile(
                    leading: Icon(Icons.ac_unit),
                    title: Text(item.name),
                    trailing: Switch(
                      value: true,
                      onChanged: (val) => callback ?? {},
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.pink,
                    ),
                  ),
                ))
            .toList());
  }
}
