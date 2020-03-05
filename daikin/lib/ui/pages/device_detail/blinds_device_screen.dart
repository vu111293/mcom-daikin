import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/action_button.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:flutter/material.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/utils/hex_color.dart';

const rem = [
  "assets/devices/rem_0.png",
  "assets/devices/rem_1.png",
  "assets/devices/rem_2.png",
  "assets/devices/rem_3.png",
];

class BlindsDeviceScreen extends StatefulWidget {
  Device device;
  BlindsDeviceScreen({this.device});
  _BlindsDeviceScreenState createState() => _BlindsDeviceScreenState();
}

class _BlindsDeviceScreenState extends State<BlindsDeviceScreen> {
  var _progress = 0.0;
  double percentage = 0;
  double initial = 0.0;
  int indexImage = 1;
  List listImage = [];
  @override
  void initState() {
    super.initState();
    _progress = double.parse(widget.device.properties.value) / 25;
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
              title: upFirstText(widget.device.name),
            ),
            BaseHeaderScreen(
              hideProfile: true,
              isSubHeader: true,
              title: upFirstText(widget.device.name),
              // subTitle: currentStateDevice
              //     ? "Thiết bị của bạn đang hoạt động"
              //     : "Thiết bị chưa hoạt động" //: widget.item.subTitle,
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // if (indexImage + 1 == listImage.length) {
                  //   setState(() {
                  //     indexImage = 0;
                  //     currentStateDevice = false;
                  //   });
                  // } else {
                  //   setState(() {
                  //     indexImage++;
                  //   });
                  // }
                },
                child: Container(
                  child: Center(
                    child: Image.asset(
                      rem[indexImage],
                      fit: BoxFit.contain,
                      width: deviceWidth(context) * 0.3,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: ptPrimaryColor(context),
                  inactiveTrackColor: HexColor(appBorderColor),
                  trackHeight: 20.0,
                  thumbColor: ptPrimaryColor(context),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                  overlayColor: HexColor(appBorderColor),
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent,
                ),
                child: Slider(
                    min: 0,
                    max: rem.length.toDouble(),
                    divisions: 10,
                    // activeColor: ptPrimaryColor(context),
                    value: _progress,
                    onChanged: (value) async {
                      print(value);
                      print((value * 25).toInt());
                      _progress = value;

                      widget.device.properties.value =
                          (value * 25).toInt().toString();
                      if (value <= 1.0) {
                        indexImage = 1;
                      } else if (value <= 2.0) {
                        indexImage = 2;
                      } else if (value < 4.0) {
                        indexImage = 3;
                      } else if (value == 4.0) {
                        indexImage = 0;
                      }

                      setState(() {});

                      await BusinessService()
                          .setValue(widget.device.id, (value * 25).toInt());
                    }),
              ),
            ),
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
