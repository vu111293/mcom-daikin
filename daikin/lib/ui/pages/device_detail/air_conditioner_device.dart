import 'dart:async';

import 'package:daikin/apis/net/business_service.dart';
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
  final Device device;
  AirConditionerDevice({this.device});
  _AirConditionerDeviceState createState() => _AirConditionerDeviceState();
}

class _AirConditionerDeviceState extends State<AirConditionerDevice> {
  bool currentStateDevice = false;
  String name = "Máy Lạnh";
  List<dynamic> listImage = [];
  int indexImage = 0;

  String modeActive = 'Auto';
  int fanSpeed = 1;
  bool powerStatus = false;
  bool swingStatus = false;

  int valueTemp = 20;
  double min = 16.0;
  double max = 31.0;

  Device _device;
  Timer _timer;

  @override
  void initState() {
    _device = widget.device;
    _autoRefreshDevice();
    super.initState();
  }

  _autoRefreshDevice() async {
    _timer = Timer.periodic(Duration(seconds: 5), (t) async {
      Device d = await BusinessService().getDeviceDetail(_device.id);
      setState(() {
        _device = d;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // logCode(_device.properties);

    ///mode
    var isMode = _device?.properties?.rows?.firstWhere(
        (x) => x?.elements[0]?.name
            ?.toLowerCase()
            ?.contains('lblMode'?.toLowerCase()),
        orElse: () => null);
    var isModeStatus = _device?.properties?.rows?.firstWhere((x) =>
        x?.elements[0]?.name?.toLowerCase()?.contains('btnOn'?.toLowerCase()));

    var isOptionMode = _device?.properties?.rows?.firstWhere((x) => x
        ?.elements[0]?.name
        ?.toLowerCase()
        ?.contains('btnAuto'?.toLowerCase()));

    ///fan
    var isFan = _device?.properties?.rows?.firstWhere(
        (x) => x?.elements[0]?.name
            ?.toLowerCase()
            ?.contains('lblFanMode'?.toLowerCase()),
        orElse: () => null);

    var isOptionFan = _device?.properties?.rows?.firstWhere((x) =>
        x?.elements[0]?.name?.toLowerCase()?.contains('btnLow'?.toLowerCase()));

    ///Swing
    var isSwing = _device?.properties?.rows?.firstWhere(
        (x) => x?.elements[0]?.name
            ?.toLowerCase()
            ?.contains('btnSwingOn'?.toLowerCase()),
        orElse: () => null);

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
                  title: upFirstText(_device.getName),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Text('Actual',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                child: Text(_device.properties.lblActual ?? '',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 18.0)))
                          ]),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Text('Status',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold))),
                                Expanded(
                                    child: Text(
                                        _device.properties.lblStatus ?? '',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(fontSize: 18.0)))
                              ])),
                    ],
                  ),
                ),
                Center(
                  child: Wrap(
                    children: <Widget>[
                      UiButton(
                        title: isModeStatus?.elements[0]?.caption ?? 'On',
                        isActive: powerStatus,
                        onPress: () {
                          setState(() {
                            powerStatus = true;
                          });
                          onClickButton(isModeStatus?.elements[0]?.id);
                        },
                      ),
                      UiButton(
                        title: isModeStatus?.elements[1]?.caption ?? 'Off',
                        isActive: !powerStatus,
                        onPress: () {
                          setState(() {
                            powerStatus = false;
                          });
                          onClickButton(isModeStatus?.elements[1]?.id);
                        },
                      ),
                    ],
                  ),
                ),
                isMode != null
                    ? Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                      isMode.elements[0].caption ?? 'Mode',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     if (isMode.elements[0].main) {
                                //       onClickButton(
                                //           isModeStatus?.elements[1]?.id);
                                //     } else {
                                //       onClickButton(
                                //           isModeStatus?.elements[0]?.id);
                                //     }
                                //   },
                                //   child: Container(
                                //     padding: EdgeInsets.only(right: 16.0),
                                //     child: Text(
                                //       isMode.elements[0].main ? 'Tắt' : 'Bật',
                                //       style: TextStyle(
                                //           fontSize: 18.0,
                                //           color: isMode.elements[0].main
                                //               ? Colors.red
                                //               : Colors.green),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Center(
                            child: Wrap(
                              children: <Widget>[
                                UiButton(
                                  title: isOptionMode?.elements[0]?.caption ??
                                      'Auto',
                                  isActive: modeActive ==
                                          isOptionMode?.elements[0]?.caption ??
                                      'Auto',
                                  onPress: () {
                                    setState(() {
                                      modeActive =
                                          isOptionMode?.elements[0]?.caption ??
                                              'Auto';
                                    });
                                    onClickButton(
                                        isOptionMode?.elements[0]?.id);
                                  },
                                ),
                                UiButton(
                                  title: isOptionMode?.elements[1]?.caption ??
                                      'Cold',
                                  isActive: modeActive ==
                                          isOptionMode?.elements[1]?.caption ??
                                      'Cold',
                                  onPress: () {
                                    setState(() {
                                      modeActive =
                                          isOptionMode?.elements[1]?.caption ??
                                              'Cold';
                                    });
                                    onClickButton(
                                        isOptionMode?.elements[1]?.id);
                                  },
                                ),
                                UiButton(
                                  title: isOptionMode?.elements[2]?.caption ??
                                      'Dry',
                                  isActive: modeActive ==
                                          isOptionMode?.elements[2]?.caption ??
                                      'Dry',
                                  onPress: () {
                                    setState(() {
                                      modeActive =
                                          isOptionMode?.elements[2]?.caption ??
                                              'Dry';
                                    });
                                    onClickButton(
                                        isOptionMode?.elements[2]?.id);
                                  },
                                ),
                                UiButton(
                                  title: isOptionMode?.elements[3]?.caption ??
                                      'Fan',
                                  isActive: modeActive ==
                                          isOptionMode?.elements[3]?.caption ??
                                      'Fan',
                                  onPress: () {
                                    setState(() {
                                      modeActive =
                                          isOptionMode?.elements[3]?.caption ??
                                              'Fan';
                                    });
                                    onClickButton(
                                        isOptionMode?.elements[3]?.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),

                ///UI Fan
                isFan != null
                    ? Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                      isFan?.elements[0]?.caption ??
                                          'Fan speed',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (fanSpeed == 0) {
                                      setState(() {
                                        fanSpeed = 1;
                                      });
                                      onClickButton(
                                          isOptionFan?.elements[2]?.id);
                                    } else {
                                      setState(() {
                                        fanSpeed = 0;
                                      });
                                      onClickButton(
                                          isOptionFan?.elements[3]?.id);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 16.0),
                                    child: Text(
                                      fanSpeed == 0
                                          ? 'Tắt tự động'
                                          : 'Bật tự động',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: fanSpeed == 0
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                    onClickButton(isOptionFan?.elements[0]?.id);
                                  },
                                ),
                                Ui3Button(
                                  mode: 2,
                                  isActive: fanSpeed == 2,
                                  onPress: () {
                                    setState(() {
                                      fanSpeed = 2;
                                    });
                                    onClickButton(isOptionFan?.elements[1]?.id);
                                  },
                                ),
                                Ui3Button(
                                  mode: 3,
                                  isActive: fanSpeed == 3,
                                  onPress: () {
                                    setState(() {
                                      fanSpeed = 3;
                                    });
                                    onClickButton(isOptionFan?.elements[2]?.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
                isSwing != null
                    ? Center(
                        child: Wrap(
                          children: <Widget>[
                            UiButton(
                              title:
                                  isSwing?.elements[0]?.caption ?? 'Swing On',
                              isActive: swingStatus,
                              onPress: () {
                                setState(() {
                                  swingStatus = true;
                                });
                                onClickButton(isSwing?.elements[0]?.id);
                              },
                            ),
                            UiButton(
                              title:
                                  isSwing?.elements[1]?.caption ?? 'Swing Off',
                              isActive: !swingStatus,
                              onPress: () {
                                setState(() {
                                  swingStatus = false;
                                });
                                onClickButton(isSwing?.elements[1]?.id);
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),

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
                          // index: (valueTemp / 2).toDouble(),
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
                            onClickButtonTemp(value.toInt());
                            setState(() {
                              valueTemp = value.toInt();
                            });
                          },
                          onChangeEnd: (double value) {
                            onClickButtonTemp(value.toInt());
                            setState(() {
                              valueTemp = value.toInt();
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
                          initialValue: valueTemp.toDouble(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () {
                                if (valueTemp.toInt() == min) {
                                  return;
                                } else {
                                  setState(() {
                                    valueTemp = valueTemp.toInt() - 1;
                                  });
                                  onClickButtonTemp(valueTemp.toInt());
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
                                if (valueTemp.toInt() == max) {
                                  return;
                                } else {
                                  setState(() {
                                    valueTemp = valueTemp.toInt() + 1;
                                  });
                                  onClickButtonTemp(valueTemp.toInt());
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

  void onClickButtonTemp(int value) {
    if (value < 20) {
      var idTemp = _device?.properties?.rows
          ?.firstWhere((x) => x?.elements[0]?.name
              ?.toLowerCase()
              ?.contains('btn16'?.toLowerCase()))
          ?.elements
          ?.firstWhere((test) => test.caption == value.toString())
          ?.id;
      BusinessService().pressButton(_device.id, idTemp);
    } else {
      if (value < 24) {
        var idTemp = _device?.properties?.rows
            ?.firstWhere((x) => x?.elements[0]?.name
                ?.toLowerCase()
                ?.contains('btn20'?.toLowerCase()))
            ?.elements
            ?.firstWhere((test) => test.caption == value.toString())
            ?.id;
        BusinessService().pressButton(_device.id, idTemp);
      } else {
        if (value < 28) {
          var idTemp = _device?.properties?.rows
              ?.firstWhere((x) => x?.elements[0]?.name
                  ?.toLowerCase()
                  ?.contains('btn24'?.toLowerCase()))
              ?.elements
              ?.firstWhere((test) => test.caption == value.toString())
              ?.id;
          BusinessService().pressButton(_device.id, idTemp);
        } else {
          if (value < 32) {
            var idTemp = _device?.properties?.rows
                ?.firstWhere((x) => x?.elements[0]?.name
                    ?.toLowerCase()
                    ?.contains('btn28'?.toLowerCase()))
                ?.elements
                ?.firstWhere((test) => test.caption == value.toString())
                ?.id;
            BusinessService().pressButton(_device.id, idTemp);
          } else {}
        }
      }
    }
  }

  void onClickButton(int value) {
    BusinessService().pressButton(_device.id, value);
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
