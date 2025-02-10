import 'package:flutter/material.dart';

extension ScreenUtils on BuildContext {
  // Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  // Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  // Get screen orientation (portrait or landscape)
  Orientation get screenOrientation => MediaQuery.of(this).orientation;

  // Get status bar height
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  // Get bottom navigation bar height (if present)
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;

  // Get width percentage (usage: context.widthPercentage(50))
  double widthPercentage(double percentage) {
    return screenWidth * (percentage / 100);
  }

  // Get height percentage (usage: context.heightPercentage(50))
  double heightPercentage(double percentage) {
    return screenHeight * (percentage / 100);
  }

  // Scale text size based on screen width (for responsive text)
  double scaleText(double size) {
    return size * (screenWidth / 375); // 375 is the base width for scaling
  }

  // Check if the screen is in landscape mode
  bool get isLandscape => screenOrientation == Orientation.landscape;

  // Check if the screen is in portrait mode
  bool get isPortrait => screenOrientation == Orientation.portrait;
}
