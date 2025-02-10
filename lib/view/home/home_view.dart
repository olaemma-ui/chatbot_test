import 'package:chatbot_test/core/routes/routes.dart';
import 'package:chatbot_test/core/theme/color_manager.dart';
import 'package:chatbot_test/core/utils/asset_manager/asset_manager.dart';
import 'package:chatbot_test/core/utils/font_manager.dart';
import 'package:chatbot_test/view/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.background,
            leading: AssetManager.logo,
            title: Row(
              children: [],
            ),
            actions: [
              AssetManager.group,
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorManager.grey,
                    ),
                    padding: EdgeInsets.all(12),
                    child: AssetManager.logo,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.grey.withOpacity(.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Divider(
                        color: ColorManager.grey,
                        height: 2,
                        thickness: 3,
                      ).marginOnly(bottom: 8),
                    ),
                    Text(
                      "Start a new chat with advanced live agent",
                      style: FontManager.getTextStyle(
                        fontSize: 24,
                        fontWeight: FontManager.semiBold,
                        color: Color(0XFF333333),
                      ),
                      textAlign: TextAlign.center,
                    ).marginOnly(bottom: 16),
                    Text(
                      "Your current chat has content that advanced live agent can’t handle just yet. ",
                      style: FontManager.getTextStyle(
                        fontSize: 14,
                        fontWeight: FontManager.medium,
                        color: Color(0XFF767676),
                      ),
                      textAlign: TextAlign.center,
                    ).marginOnly(bottom: 16),
                    SizedBox(
                      height: 45,
                      width: 150,
                      child: TextButton(
                        onPressed: () {
                          Get.offAndToNamed(AppRoutes.chat);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0XFF1A1A1A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          "New chat",
                          style: FontManager.getTextStyle(
                            color: ColorManager.background,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                )
                    .paddingSymmetric(horizontal: 16, vertical: 8)
                    .paddingOnly(bottom: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
