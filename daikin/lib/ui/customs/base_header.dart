import 'package:daikin/constants/constants.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/ui/setting/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseHeaderScreen extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isBack;
  final bool hideProfile;

  BaseHeaderScreen({this.title, this.subTitle, this.isBack = false, this.hideProfile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: isBack ? MediaQuery.of(context).padding.top : MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          bottom: 4),
      height: isBack ? 72 : null,
      child: Row(
        children: <Widget>[
          isBack
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: ptPrimaryColor(context),
                    size: 25.0,
                  ),
                )
              : Container(),
          isBack
              ? Expanded(
                  child: Center(
                  child: Text(
                    title ?? "",
                    style: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title ?? "",
                        style: ptHeadline(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subTitle ?? "",
                        style: ptSubtitle(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
          isBack || hideProfile
              ? Icon(
                  Icons.add_circle,
                  color: ptPrimaryColor(context),
                  size: 25.0,
                )
              : GestureDetector(
                  onTap: () {
                    Routing().navigate2(context, ProfileScreen());
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(backgroundImage: AssetImage('assets/images/userImage.png'))),
                )
        ],
      ),
    );
  }
}
