import 'package:flutter/material.dart';
import 'package:chatbot_test/core/theme/color_manager.dart';
import 'package:chatbot_test/core/utils/font_manager.dart';

abstract class AppTheme {
  static ThemeData get themeData => ThemeData(
        primaryColor: ColorManager.primary,
        primarySwatch: ColorManager.primarySwatch,
        // primarySwatch: ,
        scaffoldBackgroundColor: ColorManager.background,
        textTheme: _textTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme(),
        cardColor: ColorManager.black50,
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorManager.background,
          centerTitle: true,
          toolbarHeight: 40,
          scrolledUnderElevation: 0,
        ),
      );

  // Application TextTheme
  static TextTheme get _textTheme {
    return TextTheme(
      labelSmall: FontManager.getTextStyle(
        fontSize: 12,
      ),
      labelMedium: FontManager.getTextStyle(
        fontSize: 14,
      ),
      labelLarge: FontManager.getTextStyle(
        fontSize: 16,
        fontWeight: FontManager.bold,
      ),
      bodySmall: FontManager.getTextStyle(
        fontSize: 16,
      ),
      bodyMedium: FontManager.getTextStyle(
        fontSize: 18,
      ),
      bodyLarge: FontManager.getTextStyle(
        fontSize: 20,
        fontWeight: FontManager.bold,
      ),
      titleSmall: FontManager.getTextStyle(
        fontSize: 20,
      ),
      titleMedium: FontManager.getTextStyle(
        fontSize: 22,
      ),
      titleLarge: FontManager.getTextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Application TextButtonTheme
  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: ColorManager.primary,
        minimumSize: const Size(1000, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: FontManager.getTextStyle(
          fontSize: 14,
        ),
        overlayColor: ColorManager.background,
        // side: const BorderSide(
        //   color: ColorManager.primary,
        //   width: 1.5,
        // ),
      ),
    );
  }

  // static Input field decorartor
  static InputDecorationTheme _inputDecorationTheme() {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 0),
    );
    return InputDecorationTheme(
      labelStyle: FontManager.getTextStyle(
        fontSize: 14,
        color: ColorManager.textHint,
      ),
      hintStyle: FontManager.getTextStyle(
        fontSize: 14,
        color: ColorManager.textHint,
      ),
      alignLabelWithHint: true,
      fillColor: ColorManager.grey,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      errorBorder: outlineInputBorder,
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
    );
  }
}
