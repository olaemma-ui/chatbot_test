import 'package:flutter/material.dart';

/// A utility class that manages the color palette for the application.
///
/// This class provides a set of predefined colors that can be used throughout
/// the application to maintain a consistent color scheme. It includes primary,
/// neutral, background, and error colors. Additionally, it provides a method
/// to generate a [MaterialColor] swatch based on the primary color.
///
/// Example usage:
/// ```dart
/// Color primaryColor = ColorManager.primary;
/// Color backgroundColor = ColorManager.background;
/// MaterialColor primarySwatch = ColorManager.primarySwatch;
/// ```
///
/// The colors are defined as static constants, making them easily accessible
/// without the need to instantiate the class.
class ColorManager {
  // Primary Colors
  static const Color primary = Color(0XFF229EFF);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static Color grey = const Color(0xFF86929E).withOpacity(.25);

  // Background Colors
  static const Color background = Color(0xFFFAFFFF);
  static Color black50 = const Color(0xFF000000).withOpacity(.5);

  // Error Colors
  static const Color error = Color(0xFFFF6259);
  static const Color errorBorder = Color(0xFFFFDCDB);
  static Color errorAccent = const Color(0xFFFFF5F5);

  // Text Colors
  static Color textHint = Color(0XFFD1D1D1);

  static MaterialColor get primarySwatch => _createMaterialColor();

  /// Creates a [MaterialColor] based on the primary color.
  ///
  /// This method generates a swatch of colors with varying strengths
  /// from the primary color. The strengths are defined in the `strengths`
  /// list, and for each strength, a color is calculated by interpolating
  /// between the primary color and white.
  ///
  /// Returns:
  ///   A [MaterialColor] object that contains a swatch of colors.
  static MaterialColor _createMaterialColor() {
    List<double> strengths = [.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
    Map<int, Color> swatch = {};

    for (int i = 0; i < strengths.length; i++) {
      final double strength = strengths[i];
      final int r = primary.red, g = primary.green, b = primary.blue;

      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((255 - r) * strength).round(),
        g + ((255 - g) * strength).round(),
        b + ((255 - b) * strength).round(),
        1,
      );
    }

    return MaterialColor(primary.value, swatch);
  }
}
