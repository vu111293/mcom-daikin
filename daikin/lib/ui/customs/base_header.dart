import 'package:daikin/constants/constants.dart';
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
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 4),
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
                  Icons.notifications,
                  color: Colors.transparent,
                  size: 25.0,
                )
              : Container(
                  width: 56,
                  height: 56,
                  child: Image.asset('assets/images/userImage.png'),
                )
        ],
      ),
    );
  }
}
