import 'package:bot_toast/bot_toast.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AirConditionerDevice extends StatefulWidget {
  Device device;
  AirConditionerDevice({this.device});
  _AirConditionerDeviceState createState() => _AirConditionerDeviceState();
}

class _AirConditionerDeviceState extends State<AirConditionerDevice> {
  bool currentStateDevice = false;
  String name = "Motion";
  List<dynamic> listImage = [];
  int indexImage = 0;

  String modeActive = 'Auto';
  int fanSpeed = 1;

  int valueLight = 20;
  double min = 16.0;
  double max = 30.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // logCode(widget.device.properties.rows[0]);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BaseHeaderScreen(
                  isBack: true,
                  title: upFirstText(widget.device.name),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text('Mode',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text(true ? 'Bật' : 'Tắt',
                            style: TextStyle(fontSize: 18.0)),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Wrap(
                    children: <Widget>[
                      UiButton(
                        title: 'Auto',
                        isActive: modeActive == 'Auto',
                        onPress: () {
                          setState(() {
                            modeActive = 'Auto';
                          });
                          BotToast.showText(text: 'Auto click thành công');
                        },
                      ),
                      UiButton(
                        title: 'Cold',
                        isActive: modeActive == 'Cold',
                        onPress: () {
                          setState(() {
                            modeActive = 'Cold';
                          });
                          BotToast.showText(text: 'Cold click thành công');
                        },
                      ),
                      UiButton(
                        title: 'Dry',
                        isActive: modeActive == 'Dry',
                        onPress: () {
                          setState(() {
                            modeActive = 'Dry';
                          });
                          BotToast.showText(text: 'Dry click thành công');
                        },
                      ),
                      UiButton(
                        title: 'Fan',
                        isActive: modeActive == 'Fan',
                        onPress: () {
                          setState(() {
                            modeActive = 'Fan';
                          });
                          BotToast.showText(text: 'Fan click thành công');
                        },
                      ),
                    ],
                  ),
                ),

                ///UI Fan
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Fan speed',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
                Center(
                  child: Wrap(
                    children: <Widget>[
                      Ui3Button(
                        mode: 1,
                        isActive: fanSpeed == 1,
                        onPress: () {
                          setState(() {
                            fanSpeed = 1;
                          });
                          BotToast.showText(text: 'Fan click thành công');
                        },
                      ),
                      Ui3Button(
                        mode: 2,
                        isActive: fanSpeed == 2,
                        onPress: () {
                          setState(() {
                            fanSpeed = 2;
                          });
                          BotToast.showText(text: 'Fan click thành công');
                        },
                      ),
                      Ui3Button(
                        mode: 3,
                        isActive: fanSpeed == 3,
                        onPress: () {
                          setState(() {
                            fanSpeed = 3;
                          });
                          BotToast.showText(text: 'Fan click thành công');
                        },
                      ),
                    ],
                  ),
                ),

                ///Ui Temp
                Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: FlutterGauge(
                          number: Number.none,
                          hand: Hand.none,
                          counterAlign: CounterAlign.none,
                          isCircle: false,
                          isDecimal: false,
                          widthCircle: 0,
                          width: deviceWidth(context) * 0.8,
                          index: 0,
                          // index: (valueLight / 2).toDouble(),
                          start: 0,
                          end: 50,
                          activeColor: currentStateDevice
                              ? HexColor('#ff9b31')
                              : HexColor(appBorderColor),
                          inactiveColor: currentStateDevice
                              ? HexColor('#E2E5ED')
                              : HexColor(appBorderColor),
                          secondsMarker: SecondsMarker.secondsAndMinute,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: deviceWidth(context) * 0.1 + 16,
                        ),
                        alignment: Alignment.center,
                        child: SleekCircularSlider(
                          onChangeStart: (double value) {
                            setState(() {
                              valueLight = value.toInt();
                            });
                          },
                          onChangeEnd: (double value) {
                            setState(() {
                              valueLight = value.toInt();
                            });
                          },
                          appearance: CircularSliderAppearance(
                            infoProperties: InfoProperties(
                                mainLabelStyle: ptDisplay2(context),
                                modifier: (double value) {
                                  final temp = value.toInt();
                                  return '$temp˚C';
                                }),
                            customWidths: CustomSliderWidths(
                                progressBarWidth: 15,
                                shadowWidth: 15,
                                trackWidth: 15,
                                handlerSize: 12),
                            size: deviceWidth(context) * 0.6,
                            customColors: CustomSliderColors(
                              progressBarColors: [
                                Color.fromRGBO(135, 206, 250, 0),
                                Color.fromRGBO(135, 206, 250, 1),
                              ],
                              progressBarColor: Colors.red,
                              shadowColor: Colors.red,
                              trackColor: HexColor('#E2E5ED'),
                              dotColor: HexColor('#80879B'),
                            ),
                          ),
                          min: min,
                          max: max,
                          initialValue: valueLight.toDouble(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {
                                print(valueLight);

                                if (valueLight.toInt() == min) {
                                  return;
                                } else {
                                  print(valueLight);
                                  setState(() {
                                    valueLight = valueLight.toInt() - 1;
                                  });
                                }
                              },
                              child: Icon(
                                Icons.remove,
                                color: HexColor('#80879B'),
                              ),
                              shape: CircleBorder(),
                              fillColor: HexColor('#F4F5F8'),
                              padding: EdgeInsets.all(10.0),
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                if (valueLight.toInt() == max) {
                                  return;
                                } else {
                                  print(valueLight);
                                  setState(() {
                                    valueLight = valueLight.toInt() + 1;
                                  });
                                }
                              },
                              child: Icon(
                                Icons.add,
                                color: HexColor('#80879B'),
                              ),
                              shape: CircleBorder(),
                              fillColor: HexColor('#F4F5F8'),
                              padding: EdgeInsets.all(10.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class UiButton extends StatelessWidget {
  String title;
  bool isActive;
  void Function() onPress;
  UiButton({Key key, this.title = '', this.isActive = false, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context) / 2 - 30,
      margin: EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        elevation: 8,
        shadowColor: Colors.black26,
        color: isActive ? StyleAppTheme.nearlyBlue : StyleAppTheme.nearlyWhite,
        child: InkWell(
          splashColor: Colors.white24,
          onTap: onPress,
          child: Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 16, left: 4, right: 4),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.27,
                    color: isActive
                        ? StyleAppTheme.nearlyWhite
                        : StyleAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Ui3Button extends StatelessWidget {
  int mode;
  bool isActive;

  void Function() onPress;
  Ui3Button({Key key, this.mode = 0, this.isActive = false, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context) / 3 - 24,
      margin: EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        elevation: 8,
        shadowColor: Colors.black26,
        color: isActive ? StyleAppTheme.nearlyBlue : StyleAppTheme.nearlyWhite,
        child: InkWell(
          splashColor: Colors.white24,
          onTap: onPress,
          child: Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 16, left: 4, right: 4),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    mode > 0
                        ? Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Image.asset(
                              'assets/icons/fan.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              color: isActive
                                  ? StyleAppTheme.nearlyWhite
                                  : StyleAppTheme.deactivatedText,
                            ),
                          )
                        : Container(),
                    mode > 1
                        ? Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Image.asset(
                              'assets/icons/fan.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              color: isActive
                                  ? StyleAppTheme.nearlyWhite
                                  : StyleAppTheme.deactivatedText,
                            ),
                          )
                        : Container(),
                    mode > 2
                        ? Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Image.asset(
                              'assets/icons/fan.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              color: isActive
                                  ? StyleAppTheme.nearlyWhite
                                  : StyleAppTheme.deactivatedText,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
