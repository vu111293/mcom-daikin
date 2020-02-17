import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
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
  final bool isSubHeader;
  ApplicationBloc _appBloc;

  BaseHeaderScreen(
      {this.title = '',
      this.subTitle = '',
      this.isBack = false,
      this.hideProfile = false,
      this.isSubHeader = false}) {}

  @override
  Widget build(BuildContext context) {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);

    return Container(
      padding: EdgeInsets.only(
          top: isSubHeader
              ? 16
              : isBack
                  ? MediaQuery.of(context).padding.top
                  : MediaQuery.of(context).padding.top + 8,
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
                    size: 36.0,
                  ),
                )
              : Container(),
          isBack
              ? Expanded(
                  child: Center(
                  child: Text(
                    title ?? "",
                    style: ptTitle(context)
                        .copyWith(color: ptPrimaryColor(context)),
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
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          subTitle ?? "",
                          style: ptSubtitle(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
          hideProfile
              ? Container()
              : isBack
                  ? GestureDetector(
                      onTap: () {
                        Routing().navigate2(context, ProfileScreen());
                      },
                      child: Container(
                          width: 40,
                          height: 40,
                          child: CircleAvatar(
                              backgroundImage:
                                  _appBloc.authBloc.currentUser.avatar != null
                                      ? NetworkImage(
                                          _appBloc.authBloc.currentUser.avatar)
                                      : AssetImage(
                                          'assets/images/userImage2.png'))),
                    )
                  : GestureDetector(
                      onTap: () {
                        Routing().navigate2(context, ProfileScreen());
                      },
                      child: Container(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                              backgroundImage:
                                  _appBloc.authBloc.currentUser.avatar != null
                                      ? NetworkImage(
                                          _appBloc.authBloc.currentUser.avatar)
                                      : AssetImage(
                                          'assets/images/userImage2.png'))),
                    )
        ],
      ),
    );
  }
}
