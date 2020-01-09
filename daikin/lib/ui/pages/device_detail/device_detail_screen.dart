import 'package:daikin/constants/styleAppTheme.dart';
import 'package:flutter/material.dart';

class DeviceDetailScreen extends StatefulWidget {
  _DeviceDetailState createState() => _DeviceDetailState();
}

class _DeviceDetailState extends State<DeviceDetailScreen> {
  bool currentStateDevice;

  @override
  void initState() {
    super.initState();

    currentStateDevice = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getAppBarUI(),

              // describe of device
              getDescribeDeviceUI(),

              /// GIF icon
              Expanded(
                child: Container(
                  color: Colors.yellowAccent,
                ),
              ),

              /// Power control button
              getPowerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDescribeDeviceUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /// title of device
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Thiết bị tưới cây',
            textAlign: TextAlign.left,
            style: StyleAppTheme.headline,
          ),
        ),

        /// subtitle of device
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            currentStateDevice ? 'Thiết bị tưới cây đang hoạt động' : 'Nhấn để tắt và mở thiết bị',
            style: StyleAppTheme.title.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget getPowerButton() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.blue,
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              currentStateDevice = !currentStateDevice;
            });
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: currentStateDevice ? Colors.blue : Colors.grey[400],
            ),
            child: Icon(
              Icons.power_settings_new,
              color: StyleAppTheme.notWhite,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      child: Row(
        children: <Widget>[
          /// leading button
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          /// Title
          Expanded(
            child: Text(
              'THIẾT BỊ TƯỚI CÂY',
              style: StyleAppTheme.title.copyWith(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),

          /// Avatar user
          Container(
            width: 56,
            height: 56,
            child: Image.asset('assets/images/userImage.png'),
          )
        ],
      ),
    );
  }
}
