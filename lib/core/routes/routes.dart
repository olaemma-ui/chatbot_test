import 'package:chatbot_test/view/chat/chat_binding.dart';
import 'package:chatbot_test/view/chat/chat_page.dart';
import 'package:chatbot_test/view/home/home_binding.dart';
import 'package:chatbot_test/view/home/home_view.dart';
import 'package:chatbot_test/view/splash_screen/splash.dart';
import 'package:chatbot_test/view/splash_screen/splash_binding.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_navigation/get_navigation.dart';

part 'pages.dart';

abstract class AppRoutes {
  static final pages = _AppPages.pages;
  // Initial route
  static const String initialRoute = '/';

  // Home page route
  static const String home = '/home';

  // Chat page route
  static const String chat = '/chat_page';
}
