import 'dart:math';

import 'package:daikin/constants/constants.dart';
import 'package:daikin/constants/dataTest.dart';
import 'package:daikin/ui/pages/device_detail/device_on_off_detail_screen.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/utils/hex_color.dart';
import 'package:flutter/material.dart';

class DeviceViewItem extends StatefulWidget {
  const DeviceViewItem({Key key, this.category, this.animationController, this.animation}) : super(key: key);

  final Category category;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  _DeviceViewItemState createState() => _DeviceViewItemState();
}

class _DeviceViewItemState extends State<DeviceViewItem> {
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    isSwitched = widget.category.status;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child: Material(
              elevation: 5,
              shadowColor: Colors.black26,
              color: isSwitched ? Colors.white : HexColor("#f3f3f3"),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: HexColor(appBorderColor2).withOpacity(0.1), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Routing().navigate2(
                      context,
                      DeviceOnOffDetailScreen(
                        item: widget.category,
                        status: isSwitched,
                      ));
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
                            widget.category.imagePath,
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                            color: isSwitched ? HexColor(appColor) : HexColor(appBorderColor),
                          ),
                          Text(
                            '${widget.category.deviceState}',
                            textAlign: TextAlign.left,
                            style: ptOverline(context)
                                .copyWith(color: isSwitched ? Colors.black87 : HexColor(appBorderColor)),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        widget.category.title,
                        textAlign: TextAlign.left,
                        style: ptBody1(context)
                            .copyWith(color: isSwitched ? HexColor(appColor) : HexColor(appBorderColor)),
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
                                      setState(() {
                                        isSwitched = value;
                                      });
                                    },
                                    materialTapTargetSize: MaterialTapTargetSize.padded,
                                    activeColor: Colors.white,
                                    activeTrackColor: HexColor(appColor),
                                    inactiveThumbColor: HexColor(appBorderColor),
                                    inactiveTrackColor: HexColor(appBorderColor),
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
