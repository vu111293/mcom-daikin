import 'dart:async';
import 'dart:math';

import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/ui/customs/RoundSliderTrackShape.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:daikin/ui/customs/action_button.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RgbScreen extends StatefulWidget {
  final Device device;

  RgbScreen({this.device});

  RgbScreenState createState() => RgbScreenState();
}

class RgbScreenState extends State<RgbScreen> {
  Device localDevice;
  bool isOn = true;
  int valueLight = 65;
//  double _progress_red = 230;
//  double _progress_green = 150;
//  double _progress_blue = 100;

  final _redColorSubject = BehaviorSubject.seeded(0);
  final _greenColorSubject = BehaviorSubject.seeded(0);
  final _blueColorSubject = BehaviorSubject.seeded(0);

//  int get _latestRed => _redColorSubject.stream.value;
//  int get _latestGreen => _redColorSubject.stream.value;
//  int get _latestBlue => _redColorSubject.stream.value;
  StreamSubscription _rgbChangedSub;

  Stream<List<int>> get combineRGBChangedEvent => Observable.combineLatest3(
          _redColorSubject.debounceTime(Duration(milliseconds: 500)),
          _greenColorSubject.debounceTime(Duration(milliseconds: 500)),
          _blueColorSubject.debounceTime(Duration(milliseconds: 500)),
          (r, g, b) {
        return [r, g, b];
      });

  @override
  void initState() {
    super.initState();
    _fetchDeviceDetail();
  }

  @override
  void dispose() {
    _redColorSubject.close();
    _greenColorSubject.close();
    _blueColorSubject.close();
    _rgbChangedSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('object $valueLight');
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
                      subTitle:
                          'Màu của đèn là màu đã pha của 3 nút chỉnh RGB'),
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
                            activeColor: isOn
                                ? HexColor('#ff9b31')
                                : HexColor(appBorderColor),
                            inactiveColor: isOn
                                ? HexColor('#E2E5ED')
                                : HexColor(appBorderColor),
                            secondsMarker: SecondsMarker.secondsAndMinute,
                          ),
                        ),
                        StreamBuilder<List<int>>(
                          stream: combineRGBChangedEvent,
                          builder: (context, snapshot) {
                            List<int> rgb =
                                snapshot.hasData ? snapshot.data : [0, 0, 0];
                            return Container(
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
                                            rgb[0],
                                            rgb[1],
                                            rgb[2],
                                            (valueLight / 100) < 0.05
                                                ? 0.05
                                                : valueLight / 100,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: deviceWidth(context) * 0.125,
                                          ),
                                          child: Text(
                                              isOn
                                                  ? 'Độ sáng $valueLight%'
                                                  : 'Đèn tắt',
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
                                      progressBarWidth: 15,
                                      shadowWidth: 15,
                                      trackWidth: 15,
                                      handlerSize: 12),
                                  size: deviceWidth(context) * 0.6,
                                  customColors: CustomSliderColors(
                                    progressBarColors: [
                                      Color.fromRGBO(
                                        rgb[0],
                                        rgb[1],
                                        rgb[2],
                                        1,
                                      ),
                                      Color.fromRGBO(
                                        rgb[0],
                                        rgb[1],
                                        rgb[2],
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
                            );
                          },
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
                                    trackShape:
                                        RoundSliderTrackShape(radius: 10),
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 10.0,
                                        disabledThumbRadius: 10.0),
                                    overlayShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 15.0,
                                        disabledThumbRadius: 15.0),
                                    thumbColor: Colors.red,
                                    overlayColor: Colors.red,
                                    valueIndicatorColor: Colors.red,
                                    activeTickMarkColor: Colors.transparent,
                                    inactiveTickMarkColor: Colors.transparent,
                                  ),
                                  child: StreamBuilder(
                                    stream: _redColorSubject.stream,
                                    builder: (context, snapshot) {
                                      int v =
                                          snapshot.hasData ? snapshot.data : 0;
                                      return Slider(
                                        min: 0,
                                        max: 255,
                                        divisions: 255,
                                        label: '$v',
                                        value: v * 1.0,
                                        onChanged: (value) {
                                          _redColorSubject.sink
                                              .add(value.toInt());
                                        },
                                      );
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
                                    trackShape:
                                        RoundSliderTrackShape(radius: 10),
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 10.0,
                                        disabledThumbRadius: 10.0),
                                    overlayShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 15.0,
                                        disabledThumbRadius: 15.0),
                                    thumbColor: Colors.green,
                                    overlayColor: Colors.green,
                                    valueIndicatorColor: Colors.green,
                                    activeTickMarkColor: Colors.transparent,
                                    inactiveTickMarkColor: Colors.transparent,
                                  ),
                                  child: StreamBuilder(
                                    stream: _greenColorSubject.stream,
                                    builder: (context, snapshot) {
                                      int v =
                                          snapshot.hasData ? snapshot.data : 0;
                                      return Slider(
                                        min: 0,
                                        max: 255,
                                        divisions: 255,
                                        label: '$v',
                                        value: v * 1.0,
                                        onChanged: (value) {
                                          _greenColorSubject.sink
                                              .add(value.toInt());
                                        },
                                      );
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
                                    trackShape:
                                        RoundSliderTrackShape(radius: 10),
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 10.0,
                                        disabledThumbRadius: 10.0),
                                    overlayShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 15.0,
                                        disabledThumbRadius: 15.0),
                                    thumbColor: Colors.blue,
                                    overlayColor: Colors.blue,
                                    valueIndicatorColor: Colors.blue,
                                    activeTickMarkColor: Colors.transparent,
                                    inactiveTickMarkColor: Colors.transparent,
                                  ),
                                  child: StreamBuilder(
                                    stream: _blueColorSubject.stream,
                                    builder: (context, snapshot) {
                                      int v =
                                          snapshot.hasData ? snapshot.data : 0;
                                      return Slider(
                                        min: 0,
                                        max: 255,
                                        divisions: 255,
                                        label: '$v',
                                        value: v * 1.0,
                                        onChanged: (value) {
                                          _blueColorSubject.sink
                                              .add(value.toInt());
                                        },
                                      );
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
                        child: ActionButton(currentStateDevice: isOn),
                        onTap: _turnDevice),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _fetchDeviceDetail() async {
    localDevice = await BusinessService().getDeviceDetail(widget.device.id);

    DeviceProperty properties = localDevice.properties;
    _redColorSubject.sink.add(properties.getRed);
    _greenColorSubject.sink.add(properties.getGreen);
    _blueColorSubject.sink.add(properties.getBlue);
    setState(() {
      isOn = properties.isLightOn;
    });

    _rgbChangedSub = combineRGBChangedEvent.listen((v) {
      if (v.length == 3) {
        // call setcolor api
        if (isOn) {
          BusinessService().setRGBColor(localDevice.id, v[0], v[1], v[2], 255);
        }
      }
    });
  }

  Future _turnDevice() async {
    if (isOn) {
      await BusinessService().turnOffDevice(widget.device.id);
    } else {
      await BusinessService().turnOnDevice(widget.device.id);
      BusinessService().setRGBColor(
          localDevice.id,
          _redColorSubject.stream.value,
          _greenColorSubject.stream.value,
          _blueColorSubject.stream.value,
          255);
    }
    setState(() {
      isOn = !isOn;
    });
    return Future;
  }
}
