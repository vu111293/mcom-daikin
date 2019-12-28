import 'package:flutter/material.dart';

class StyleAppTheme {
  StyleAppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2); //#EDF0F2
  static const Color nearlyWhite = Color(0xFFFFFFFF); //#FFFFFF
  static const Color nearlyBlue = Color(0xFF00A1E4); //#00A1E4
  static const Color nearlyBlack = Color(0xFF213333); //#213333
  static const Color grey = Color(0xFF3A5160); //#3A5160
  static const Color dark_grey = Color(0xFF313A44); //#313A44

  static const Color darkText = Color(0xFF253840); //#253840
  static const Color darkerText = Color(0xFF17262A); //#17262A
  static const Color lightText = Color(0xFF4A6572); //#4A6572
  static const Color deactivatedText = Color(0xFF767676); //#767676
  static const Color dismissibleBackground = Color(0xFF364A54); //#364A54
  static const Color chipBackground = Color(0xFFEEF1F3); //#EEF1F3
  static const Color spacer = Color(0xFFF2F2F2); //#F2F2F2

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}

//  ThemeData _theme() {
//    return Theme.of(context).copyWith(
//      primaryIconTheme: IconThemeData(color: HexColor(appText)),
//      iconTheme: IconThemeData(color: HexColor(appText)),
//      // Define the default Brightness and Colors
//      brightness: Brightness.light,
//      primaryColor: _primaryColor,
//      accentColor: HexColor(appWhite),
//      inputDecorationTheme: InputDecorationTheme(
//        labelStyle: Theme.of(context).textTheme.subtitle,
//        fillColor: _primaryColor,
//        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: _primaryColor)),
//      ),
//      // Define the default buttonTheme. Use this to specify the default
//      buttonTheme: ButtonThemeData(
//        buttonColor: _primaryColor,
//        textTheme: ButtonTextTheme.accent,
//        shape: StadiumBorder(),
//        // splashColor: HexColor("#2D8D4715"),
//        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//      ),
//    );
//  }
