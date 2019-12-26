import 'dart:async';

import 'package:flutter/material.dart';

class Routing {
  static final Routing _instance = new Routing._internal();
  BuildContext latestContext;

  factory Routing() {
    return _instance;
  }

  Routing._internal();

  setContext(BuildContext context) {
    if (latestContext != context) {
      latestContext = context;
    }
  }

  Future<T> navigate2<T>(BuildContext context, Widget screen, {bool replace = false, String routeName}) {
    if (replace != null && replace) {
      return Navigator.pushReplacement(
          context,
          new MaterialPageRoute<T>(
              settings: RouteSettings(name: routeName),
              builder: (BuildContext context) {
                latestContext = context;
                return screen;
              }));
    }

    return Navigator.push(
        context,
        new MaterialPageRoute<T>(
            settings: RouteSettings(name: routeName),
            builder: (BuildContext context) {
              latestContext = context;
              return screen;
            }));
  }

  void popToRoot(BuildContext context) {
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void openDialog(BuildContext context, Widget dialog, {bool fullscreen}) {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => dialog,
          fullscreenDialog: fullscreen != null ? fullscreen : false,
        ));
  }
}
