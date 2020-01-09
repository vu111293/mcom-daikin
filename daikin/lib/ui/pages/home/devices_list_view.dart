import 'package:daikin/constants/styleAppTheme.dart';
import 'package:flutter/material.dart';
import './../../../constants/deviceDataTest.dart';
import './../../customs/expansion_tile.dart' as expansionTile;

class DevicesListView extends StatefulWidget {
  final Function callBack;

  const DevicesListView({Key key, this.callBack}) : super(key: key);

  _DevicesListState createState() => _DevicesListState();
}

class _DevicesListState extends State<DevicesListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return CustomDeviceList(
            callback: widget.callBack,
            data: DeviceDataTest.deviceDataList[index],
          );
        },
        itemCount: DeviceDataTest.deviceDataList.length,
      ),
    );
  }
}

class CustomDeviceList extends StatelessWidget {
  final DeviceDataTest data;
  final Function callback;
  const CustomDeviceList({@required this.data, @required this.callback});
  @override
  Widget build(BuildContext context) {
    return _buildTiles(data);
  }

  Widget _buildTiles(DeviceDataTest root) {
    if (root.subDevices.isEmpty)
      return ListTile(title: Text('Chưa có dữ liệu room device!'));
    return expansionTile.ExpansionTile(
        trailing: Container(
          height: 24,
          width: 24,
          child: CircleAvatar(
            backgroundColor: StyleAppTheme.nearlyBlue,
            child: Text(
              '${root.subDevices.length}',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        key: PageStorageKey<DeviceDataTest>(root),
        title: Text(
          root.title,
          style: TextStyle(color: StyleAppTheme.nearlyBlue),
        ),
        children: root.subDevices
            .map((item) => Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: ListTile(
                    leading: Icon(Icons.ac_unit),
                    title: Text(item.name),
                    trailing: Switch(
                      value: item.deviceState,
                      onChanged: (val) => callback ?? {},
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.pink,
                    ),
                  ),
                ))
            .toList());
  }
}
