import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/power_button.dart';
import 'package:flutter/material.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/utils/hex_color.dart';

class SwitchMultiDevice extends StatefulWidget {
  Function setValue;
  Function onClick;
  Device device;
  SwitchMultiDevice({this.device, this.setValue, this.onClick});
  _SwitchMultiDeviceState createState() => _SwitchMultiDeviceState();
}

class _SwitchMultiDeviceState extends State<SwitchMultiDevice> {
  bool currentStateDevice = false;
  var _progress = 0.0;
  double percentage = 0;
  double initial = 0.0;
  @override
  void initState() {
    super.initState();
    currentStateDevice = int.parse(widget.device.properties.value) > 0;
    percentage = double.parse(widget.device.properties.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BaseHeaderScreen(
              isBack: true,
              title: widget.device.name.toUpperCase(),
            ),
            BaseHeaderScreen(
              hideProfile: true,
              isSubHeader: true,
              title: widget.device.name,
              subTitle: currentStateDevice
                  ? "Thiết bị của bạn đang hoạt động"
                  : "Thiết bị chưa hoạt động" //: widget.item.subTitle,
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Container(
                width: deviceWidth(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/devices/sun.png",
                      fit: BoxFit.contain,
                      width: 32,
                      color: currentStateDevice
                          ? Colors.yellow
                          : HexColor(appBorderColor),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        '${percentage.round()}% Brightness',
                        style: ptTitle(context).copyWith(
                          color: currentStateDevice
                              ? HexColor(appText)
                              : HexColor(appBorderColor),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onPanStart: (DragStartDetails details) {
                        initial = details.globalPosition.dy;
                      },
                      onPanUpdate: (DragUpdateDetails details) {
                        double distance = initial - details.globalPosition.dy;
                        double percentageAddition = distance / 100;
                        // print('percentage ' +
                        //     (percentage + percentageAddition).clamp(0.0, 100.0).round().toString());
                        setState(() {
                          percentage = (percentage + percentageAddition)
                              .clamp(0.0, 100.0);
                        });

                        print("UPDATE");

                        print(percentage);
                      },
                      onPanEnd: (DragEndDetails details) {
                        initial = 0.0;
                        if (percentage.toInt() == 0) {
                          setState(() {
                            currentStateDevice = false;
                          });
                        }
                        print("END");
                        widget.setValue(percentage.toInt());
                      },
                      child: Container(
                        height: 250,
                        width: 130,
                        decoration: BoxDecoration(
                          color: HexColor("#ECECEC"),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: currentStateDevice
                                    ? HexColor(appColor)
                                    : HexColor(appBorderColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              width: 130,
                              height: (percentage / 100) * 250,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: PowerButton(currentStateDevice: currentStateDevice),
              onTap: () {
                if (currentStateDevice) {
                  percentage = 0;
                } else {
                  percentage = 99;
                }

                setState(() {
                  currentStateDevice = !currentStateDevice;
                });
                widget.onClick(currentStateDevice);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
