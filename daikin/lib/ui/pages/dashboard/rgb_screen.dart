import 'dart:math';

import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/customs/RoundSliderTrackShape.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/power_button.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RgbScreen extends StatefulWidget {
  RgbScreenState createState() => RgbScreenState();
}

class RgbScreenState extends State<RgbScreen> {
  bool currentStateDevice = true;
  int valueLight = 65;
  double _progress_red = 230;
  double _progress_green = 150;
  double _progress_blue = 100;

  @override
  void initState() {
    super.initState();
    currentStateDevice = Random().nextBool();
  }

  @override
  Widget build(BuildContext context) {
    print('object $valueLight');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BaseHeaderScreen(
            isBack: true,
            title: 'Đèn RGB'.toUpperCase(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  BaseHeaderScreen(
                      hideProfile: true,
                      isSubHeader: true,
                      title: 'Đèn RGB đổi màu',
                      subTitle: 'Màu của icon đèn là màu dẵ pha của 3 nút chỉnh RGB'),
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
                            activeColor: currentStateDevice ? HexColor('#ff9b31') : HexColor(appBorderColor),
                            inactiveColor: currentStateDevice ? HexColor('#E2E5ED') : HexColor(appBorderColor),
                            secondsMarker: SecondsMarker.secondsAndMinute,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: deviceWidth(context) * 0.1 + 16,
                          ),
                          alignment: Alignment.center,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/devices/rgb.png',
                                      width: deviceWidth(context) * 0.25,
                                      fit: BoxFit.contain,
                                      color: Color.fromRGBO(
                                        _progress_red.toInt(),
                                        _progress_green.toInt(),
                                        _progress_blue.toInt(),
                                        (valueLight / 100) < 0.05 ? 0.05 : valueLight / 100,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: deviceWidth(context) * 0.125,
                                      ),
                                      child: Text(currentStateDevice ? 'Độ sáng $valueLight%' : 'Đèn tắt',
                                          style: ptTitle(context)),
                                    ),
                                  ],
                                ),
                              );
                            },
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
                              customWidths: CustomSliderWidths(
                                  progressBarWidth: 15, shadowWidth: 15, trackWidth: 15, handlerSize: 12),
                              size: deviceWidth(context) * 0.6,
                              customColors: CustomSliderColors(
                                progressBarColors: [
                                  Color.fromRGBO(
                                    _progress_red.toInt(),
                                    _progress_green.toInt(),
                                    _progress_blue.toInt(),
                                    1,
                                  ),
                                  Color.fromRGBO(
                                    _progress_red.toInt(),
                                    _progress_green.toInt(),
                                    _progress_blue.toInt(),
                                    0,
                                  )
                                ],
                                progressBarColor: Colors.red,
                                shadowColor: Colors.red,
                                trackColor: HexColor('#E2E5ED'),
                                dotColor: Colors.grey,
                              ),
                            ),
                            min: 0,
                            max: 100,
                            initialValue: valueLight.toDouble(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: deviceWidth(context) * 0.8,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 32),
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.red,
                                    inactiveTrackColor: HexColor(appNotWhite),
                                    trackHeight: 10.0,
                                    trackShape: RoundSliderTrackShape(radius: 10),
                                    thumbShape:
                                        RoundSliderThumbShape(enabledThumbRadius: 10.0, disabledThumbRadius: 10.0),
                                    overlayShape:
                                        RoundSliderThumbShape(enabledThumbRadius: 15.0, disabledThumbRadius: 15.0),
                                    thumbColor: Colors.red,
                                    overlayColor: Colors.red,
                                    valueIndicatorColor: Colors.red,
                                    activeTickMarkColor: Colors.transparent,
                                    inactiveTickMarkColor: Colors.transparent,
                                  ),
                                  child: Slider(
                                    min: 0,
                                    max: 255,
                                    divisions: 255,
                                    label: _progress_red.toInt().toString(),
                                    value: _progress_red,
                                    onChanged: (value) {
                                      setState(() {
                                        _progress_red = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 32),
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.green,
                                    inactiveTrackColor: HexColor(appNotWhite),
                                    trackHeight: 10.0,
                                    trackShape: RoundSliderTrackShape(radius: 10),
                                    thumbShape:
                                        RoundSliderThumbShape(enabledThumbRadius: 10.0, disabledThumbRadius: 10.0),
                                    overlayShape:
                                        RoundSliderThumbShape(enabledThumbRadius: 15.0, disabledThumbRadius: 15.0),
                                    thumbColor: Colors.green,
                                    overlayColor: Colors.green,
                                    valueIndicatorColor: Colors.green,
                                    activeTickMarkColor: Colors.transparent,
                                    inactiveTickMarkColor: Colors.transparent,
                                  ),
                                  child: Slider(
                                    min: 0,
                                    max: 255,
                                    divisions: 255,
                                    label: _progress_green.toInt().toString(),
                                    value: _progress_green,
                                    onChanged: (value) {
                                      setState(() {
                                        _progress_green = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 32),
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.blue,
                                    inactiveTrackColor: HexColor(appNotWhite),
                                    trackHeight: 10.0,
                                    trackShape: RoundSliderTrackShape(radius: 10),
                                    thumbShape:
                                        RoundSliderThumbShape(enabledThumbRadius: 10.0, disabledThumbRadius: 10.0),
                                    overlayShape:
                                        RoundSliderThumbShape(enabledThumbRadius: 15.0, disabledThumbRadius: 15.0),
                                    thumbColor: Colors.blue,
                                    overlayColor: Colors.blue,
                                    valueIndicatorColor: Colors.blue,
                                    activeTickMarkColor: Colors.transparent,
                                    inactiveTickMarkColor: Colors.transparent,
                                  ),
                                  child: Slider(
                                    min: 0,
                                    max: 255,
                                    divisions: 255,
                                    label: _progress_blue.toInt().toString(),
                                    value: _progress_blue,
                                    onChanged: (value) {
                                      setState(() {
                                        _progress_blue = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
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

                                  if (valueLight.toInt() == 0) {
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
                                  color: HexColor('##80879B'),
                                ),
                                shape: CircleBorder(),
                                fillColor: HexColor('##F4F5F8'),
                                padding: EdgeInsets.all(10.0),
                              ),
                              RawMaterialButton(
                                onPressed: () {
                                  if (valueLight.toInt() == 100) {
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
                                  color: HexColor('##80879B'),
                                ),
                                shape: CircleBorder(),
                                fillColor: HexColor('##F4F5F8'),
                                padding: EdgeInsets.all(10.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: GestureDetector(
                      child: PowerButton(currentStateDevice: currentStateDevice),
                      onTap: () {
                        setState(() {
                          currentStateDevice = !currentStateDevice;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
