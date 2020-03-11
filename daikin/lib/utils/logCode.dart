import 'dart:convert';
import 'package:flutter/material.dart';

logCode(log) {
  debugPrint("phat: log json " +
      log?.toString() +
      "----" +
      jsonEncode(log?.toJson())?.toString());
}
