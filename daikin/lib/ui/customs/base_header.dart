import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/constants/constants.dart';
import 'package:daikin/models/user.dart';
import 'package:daikin/ui/pages/news/news_page.dart';
import 'package:daikin/ui/route/route/routing.dart';
import 'package:daikin/ui/setting/profile_screen.dart';
import 'package:daikin/utils/formatTextFirstUpCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseHeaderScreen extends StatefulWidget {

  final String title;
  final String subTitle;
  final bool isBack;
  final bool hideProfile;
  final bool isSubHeader;
  final bool isTitleOnly;
  final Function onTitleTap;

  BaseHeaderScreen(
      {this.title = '',
        this.subTitle = '',
        this.isBack = false,
        this.hideProfile = false,
        this.isSubHeader = false,
        this.isTitleOnly = false,
        this.onTitleTap});

  @override
  _BaseHeaderScreenState createState() => _BaseHeaderScreenState();
}

class _BaseHeaderScreenState extends State<BaseHeaderScreen> {

  ApplicationBloc _appBloc;

  @override
  void initState() {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);
    super.initState();
  }

  Widget _buildAvatarWidget() {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Routing().navigate2(context, ProfileScreen());
          },
          child: Container(
              width: 50,
              height: 50,
              child: CircleAvatar(
                  backgroundImage:
                  _appBloc.authBloc.currentUser.avatar != null
                      ? NetworkImage(_appBloc.authBloc.currentUser.avatar)
                      : AssetImage('assets/images/avatar_placeholder.png'))),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: StreamBuilder<LUser>(
            stream: _appBloc.authBloc.userEvent,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data?.unreadNotifyCount == null) return SizedBox();
              if (snapshot.data.unreadNotifyCount == 0) return SizedBox();

              return InkWell(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: Colors.redAccent
                  ),
                  child: Icon(Icons.notifications, color: Colors.white, size: 18),
                ),
                onTap: () {
                  Routing().navigate2(context, NewsPage());
                },
              );
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: widget.isSubHeader
              ? 16
              : widget.isBack
                  ? MediaQuery.of(context).padding.top
                  : MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          bottom: 4),
      height: widget.isBack || widget.isTitleOnly ? 72 : null,
      child: Row(
        children: <Widget>[
          widget.isBack
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
          Expanded(
            child: InkWell(
                child: widget.isBack || widget.isTitleOnly
                    ? Center(
                        child: Text(
                          widget.title ?? '',
                          style: ptTitle(context).copyWith(color: ptPrimaryColor(context)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.title ?? '',
                            style: ptHeadline(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          widget.subTitle?.isNotEmpty == true ? Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              upFirstText(widget.subTitle),
                              style: ptSubtitle(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ) : Container()
                        ],
                      ),
                onTap: widget.onTitleTap),
          ),
          widget.hideProfile
              ? Container(
                  width: widget.isTitleOnly ? 0 : 40,
                  height: 40,
                )
              : _buildAvatarWidget()
        ],
      ),
    );
  }
}
