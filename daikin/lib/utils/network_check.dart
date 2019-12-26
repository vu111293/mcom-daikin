import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

class NetworkCheck {
  NetworkCheck._internal();

  static final NetworkCheck _instance = NetworkCheck._internal();

  static NetworkCheck get instance => _instance;

  Connectivity connectivity = Connectivity();
  final _networkChangeBehavior = BehaviorSubject<bool>();
  Stream get networkChangedEvent => _networkChangeBehavior.stream.distinct((a,b) => a == b);

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }

    _networkChangeBehavior.sink.add(isOnline);
  }

  void disposeStream() {
    _networkChangeBehavior.close();
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
