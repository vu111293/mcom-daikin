import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget bottomBar;
  final Widget body;

  BaseScreen({this.bottomBar, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(child: SingleChildScrollView(child: body ?? Container())),
      bottomBar ?? Container()
    ]));
  }
}
