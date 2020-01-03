import 'package:carousel_slider/carousel_slider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/pages/login/login_screen.dart';
import 'package:daikin/ui/pages/main.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/intro/Intro_1.png',
  'assets/intro/Intro_2.png',
  'assets/intro/Intro_3.png',
  'assets/intro/Intro_4.png',
  'assets/intro/Intro_5.png',
];

class IntroductionScreen extends StatefulWidget {
  IntroductionScreen({Key key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

int _current = 0;

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    final basicSlider = CarouselSlider(
      items: map<Widget>(
        imgList,
        (index, i) {
          return Image.asset(
            i,
            fit: BoxFit.cover,
            width: deviceWidth(context),
          );
        },
      ).toList(),
      viewportFraction: 1.2,
      autoPlay: false,
      height: deviceHeight(context),
      enlargeCenterPage: true,
      enableInfiniteScroll: false,
      scrollPhysics: ClampingScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );
    return Container(
      color: HexColor("#44C8F5"),
      child: Stack(
        children: <Widget>[
          basicSlider,
          Positioned(
            bottom: kBottomNavigationBarHeight,
            left: 0,
            right: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(
                  imgList,
                  (index, url) {
                    return Container(
                      width: 5,
                      height: 5,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: _current == index ? HexColor(appColor) : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                    );
                  },
                )),
          ),
          _current == 4
              ? Positioned(
                  bottom: kBottomNavigationBarHeight / 2,
                  child: Container(
                      width: deviceWidth(context),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: RaisedButton(
                          onPressed: () {
                            Routing().navigate2(context, MainScreen());
                          },
                          shape: StadiumBorder(),
                          elevation: 0,
                          color: HexColor(appColor),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                          child:
                              Text("Bắt đầu Ngay".toUpperCase(), style: ptTitle(context).copyWith(color: Colors.white)),
                        ),
                      )),
                )
              : Positioned(
                  bottom: kBottomNavigationBarHeight / 2,
                  child: Container(
                    width: deviceWidth(context),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      GestureDetector(
                          onTap: () {
                            Routing().navigate2(context, LoginScreen());
                          },
                          child: Text("Bỏ qua".toUpperCase(), style: ptTitle(context).copyWith(color: Colors.white))),
                      GestureDetector(
                          onTap: () {
                            basicSlider.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
                          },
                          child: Text("Tiếp tục".toUpperCase(), style: ptTitle(context).copyWith(color: Colors.white))),
                    ]),
                  ),
                ),
        ],
      ),
    );
  }
}
