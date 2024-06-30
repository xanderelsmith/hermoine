library text_style;

import 'package:flutter/material.dart';

//
mixin Font implements FontWeight {
  static FontWeight get l => FontWeight.w300;
  static FontWeight get n => FontWeight.w400;
  static FontWeight get sb => FontWeight.w500;
  static FontWeight get b => FontWeight.w700;
}

//
class AppTextStyle extends TextStyle {
  static TextStyle get titlename => TextStyle(
        fontWeight: Font.sb,
        color: Colors.black,
        fontSize: 12,
      );
  static TextStyle get mediumTitlename => TextStyle(
        fontWeight: Font.sb,
        color: Colors.black,
        fontSize: 15,
      );
  static TextStyle get largeTitlename => TextStyle(
        fontWeight: Font.sb,
        color: Colors.black,
        fontSize: 20,
      );
  static TextStyle get extralargeTitlename => TextStyle(
        fontWeight: Font.sb,
        color: Colors.black,
        fontSize: 25,
      );
  static TextStyle get tinyTitlename => TextStyle(
        fontWeight: Font.l,
        color: Colors.black,
        fontSize: 10,
      );
  static TextStyle get header => const TextStyle();
}
