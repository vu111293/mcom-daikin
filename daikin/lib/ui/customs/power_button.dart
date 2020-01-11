import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/ui/setting/profile_screen.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PowerButton extends StatelessWidget {
  bool currentStateDevice;

  PowerButton({this.currentStateDevice = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: currentStateDevice ? ptPrimaryColor(context) : HexColor(appBorderColor),
        ),
        child: Icon(
          Icons.power_settings_new,
          color: currentStateDevice ? HexColor(appWhite) : HexColor(appNotWhite),
          size: 40,
        ),
      ),
    );
  }
}
