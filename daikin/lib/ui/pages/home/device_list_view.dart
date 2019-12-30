import 'dart:math';

import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/constants/styleAppTheme.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

class DeviceListView extends StatefulWidget {
  const DeviceListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  DeviceListViewState createState() => DeviceListViewState();
}

class DeviceListViewState extends State<DeviceListView> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox();
          } else {
            return Container(
              height: deviceHeight(context) * 0.7,
              child: GridView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                children: List<Widget>.generate(
                  Category.categoryDevices.length,
                  (int index) {
                    final int count = Category.categoryDevices.length;
                    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    );
                    animationController.forward();
                    return CategoryView(
                      callback: () {
                        widget.callBack();
                      },
                      category: Category.categoryDevices[index],
                      animation: animation,
                      animationController: animationController,
                    );
                  },
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  // childAspectRatio: MediaQuery.of(context).size.height / 600,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({Key key, this.category, this.animationController, this.animation, this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Category category;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    bool isSwitched = Random().nextBool();

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
            child: Material(
              elevation: 5,
              shadowColor: Colors.black26,
              color: isSwitched ? HexColor("#44C8F5") : Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: HexColor(appBorderColor2).withOpacity(0.1), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  callback();
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            category.imagePath,
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                            color: isSwitched ? Colors.white : HexColor(appColor),
                          ),
                          Text(
                            '${category.temperature.toStringAsFixed(1)}°C',
                            textAlign: TextAlign.left,
                            style: ptOverline(context).copyWith(color: isSwitched ? Colors.white : Colors.black87),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        category.title,
                        textAlign: TextAlign.left,
                        style: ptBody1(context).copyWith(color: isSwitched ? Colors.white : HexColor(appColor)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                          height: 30,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: -10,
                                left: -15,
                                child: Transform.scale(
                                  scale: 0.7,
                                  child: Switch(
                                    value: isSwitched,
                                    onChanged: (value) {
                                      isSwitched = value;
                                    },
                                    activeTrackColor: Colors.greenAccent,
                                    inactiveTrackColor: HexColor(appColor2),
                                    activeColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
