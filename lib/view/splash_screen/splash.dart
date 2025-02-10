import 'package:chatbot_test/core/theme/color_manager.dart';
import 'package:chatbot_test/core/utils/asset_manager/asset_manager.dart';
import 'package:chatbot_test/core/utils/font_manager.dart';
import 'package:chatbot_test/core/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'splash_controller.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: ColorManager.grey,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorManager.grey,
                      ),
                      padding: EdgeInsets.all(12),
                      child: AssetManager.logo,
                    ).animate().scale(curve: Curves.ease, duration: 750.ms),
                    Text(
                      " HelpSync ",
                      style: FontManager.getTextStyle(
                        color: ColorManager.white,
                        fontWeight: FontManager.bold,
                        fontSize: context.scaleText(38),
                      ),
                    ).animate().fadeIn(curve: Curves.ease, duration: 1000.ms),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
