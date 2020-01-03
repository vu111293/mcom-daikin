import 'package:daikin/ui/customs/base_header.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   _dateController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          BaseHeaderScreen(
            hideProfile: true,
            title: "Nhà",
            subTitle: "Nhà của bạn bây giờ luôn được bảo đảm !",
          ),
        ],
      ),
    );
  }
}
