

import 'package:daikin/apis/net/business_service.dart';
import 'package:daikin/apis/net/user_service.dart';
import 'package:daikin/blocs/application_bloc.dart';
import 'package:daikin/blocs/bloc_provider.dart';
import 'package:daikin/models/business_models.dart';
import 'package:daikin/models/user.dart';
import 'package:daikin/ui/customs/base_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsModel newsModel;

  NewsDetailPage({this.newsModel});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {

  ApplicationBloc _app;
  final _newsStream = BehaviorSubject<List<NewsModel>>();

  @override
  void initState() {
    _app = BlocProvider.of<ApplicationBloc>(context);
    makeRead();
    loadNotifications();
    super.initState();
  }

  Future makeRead() async {
    if (widget.newsModel.isUnRead) {
      await BusinessService().makeRead(widget.newsModel.id);

      // Updated read counter
      LUser me = await UserService().me();
      _app.authBloc.updateUserAction(me);
    }
    return Future;
  }

  Future loadNotifications() async {
    // Load data here
    List<NewsModel> items = await BusinessService().getNotifications();
    _newsStream.sink.add(items);
    return Future;
  }

  @override
  void dispose() {
    _newsStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BaseHeaderScreen(
            title: widget.newsModel.title,
            isBack: true,
            hideProfile: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(widget.newsModel.body, style: TextStyle(fontSize: 16)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
