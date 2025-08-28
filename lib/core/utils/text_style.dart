import 'package:flutter/material.dart';

class TextStyles {
  getHeadline({
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 24,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  static TextStyle getTitle({
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 18,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  static TextStyle getBody({
    double fontSize = 16,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  static TextStyle getSmall({
    double fontSize = 14,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }
}
