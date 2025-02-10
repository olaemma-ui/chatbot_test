import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/color_manager.dart';

class FontManager {
  // Font Families
  static const String fontFamilyPrimary = 'Outfit';

  // Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // Font Styles
  static const FontStyle normal = FontStyle.normal;
  static const FontStyle italic = FontStyle.italic;

  static TextTheme get getThemeStyle => Theme.of(Get.context!).textTheme;

  // TextStyle helper methods
  static TextStyle getTextStyle({
    String fontFamily = fontFamilyPrimary,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    Color color = ColorManager.black,
    double letterSpacing = 0.0,
    double wordSpacing = 0.0,
    double height = 1.45,
    TextStyle? style,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      overflow: TextOverflow.clip,
      height: height,
    ).merge(style);
  }
}
