import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle getTextStyle(
    double fontsize,
    Color color,
    FontWeight fontWeight,
  ) {
    // String fontFamily = 'Geist';
    // String fontFamily = 'Merriweather';

    return TextStyle(
      fontSize: fontsize,
      color: color,
      fontWeight: fontWeight,
      // height: fontFamily == 'Merriweather' ? 1.7 : 1.5,
      // fontFamily: fontFamily,
    );
  }
}
