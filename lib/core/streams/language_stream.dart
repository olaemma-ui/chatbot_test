import 'dart:async';

import 'package:flutter/material.dart';

class LanguageStream {
  const LanguageStream._();

  /// Create localization laguage as a broadcast stream
  static StreamController<Locale> languageStream = StreamController.broadcast();

  /// [languageCode] This is the current language on the app
  /// This method add a new language [Locale] to the stream and updates the app
  /// application current visible language
  static void changeLanguage(String languageCode) async {
    languageStream.add(
      Locale.fromSubtags(languageCode: languageCode),
    );
  }

  /// [languageCode] This is the current language on the app
  /// This method add a new language [Locale] to the stream and updates the app
  /// application current visible language
  // static String get currentLanguage =>
}
