import 'package:flutter/material.dart';

class ValidateUtil {
  static ValidateUtil instance = ValidateUtil();

  static ValidateUtil getInstance() {
    return instance;
  }

  bool isEmail(String em) {
    String p =
        r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.)*[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.[a-zA-Z0-9]{2,}$";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }
}
