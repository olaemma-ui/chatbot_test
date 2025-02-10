import 'package:flutter/material.dart';
extension ContextExtension on BuildContext {

  Locale get currentLanguage => const Locale.fromSubtags(languageCode: 'en');
}
