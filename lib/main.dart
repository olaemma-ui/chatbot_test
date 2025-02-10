import 'package:chatbot_test/core/routes/routes.dart';
import 'package:chatbot_test/core/theme/light_theme.dart';
import 'package:chatbot_test/view/home/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HelpSync',
      theme: AppTheme.themeData,
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.initialRoute,
      initialBinding: BindingsBuilder.put(
        () => HomeBinding(),
      ),
    );
  }
}
