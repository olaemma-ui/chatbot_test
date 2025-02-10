import 'package:chatbot_test/core/theme/color_manager.dart';
import 'package:chatbot_test/core/utils/asset_manager/asset_manager.dart';
import 'package:chatbot_test/core/utils/font_manager.dart';
import 'package:chatbot_test/data/repository/bots_data.dart';
import 'package:chatbot_test/view/widgets/bots_suggestion.dart';
import 'package:chatbot_test/view/widgets/message_box.dart';
import 'package:chatbot_test/view/widgets/warning-_barnner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      initState: (_) {},
      builder: (controller) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: controller.userInteractionDetected,
          onPanDown: (_) {
            controller.userInteractionDetected();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorManager.background,
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: AssetManager.hambugger,
              ),
              // leadingWidth: 20,
              title: Text(
                'Live Chat',
                style: FontManager.getTextStyle(
                  fontSize: 16,
                  fontWeight: FontManager.medium,
                ),
              ),
              actions: [AssetManager.group],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...controller.chats.map(
                        (message) => Align(
                          alignment: message.sender == 'bot'
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: message.sender == 'bot'
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (message.sender == 'bot')
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: ColorManager.primary,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  width: 30,
                                  height: 30,
                                  child: AssetManager.logo,
                                  margin: EdgeInsets.only(left: 8),
                                ).animate().scale(
                                      curve: Curves.ease,
                                      duration: 750.ms,
                                    ),
                              MessageBox(
                                message: message.message,
                                sender: message.sender,
                              )
                                  .animate()
                                  .scale(
                                    curve: Curves.ease,
                                    duration: 750.ms,
                                  )
                                  .marginSymmetric(horizontal: 8, vertical: 4)
                                  .paddingOnly(bottom: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                Obx(
                  () => controller.hasInteracted.value
                      ? SizedBox()
                      : WarningBanner(
                          title: "You will be logged out in ${controller.sec} "
                              "seconds due to inactivity.",
                        ).paddingAll(16),
                ),
                if (controller.isLoadingLiveAgent || controller.isLoading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorManager.primary,
                        ),
                        padding: EdgeInsets.all(6),
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.only(left: 16),
                        child: AssetManager.logo,
                      )
                          .animate()
                          .scale(
                            curve: Curves.ease,
                            duration: 750.ms,
                          )
                          .marginOnly(right: 8),
                      Expanded(
                        child: Text(
                          controller.isLoading
                              ? "Ppleas wait..."
                              : "Pleas hold on, i'm getting you a livev agent support",
                          style: FontManager.getTextStyle(
                            fontSize: 14,
                            color: ColorManager.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(left: 16, bottom: 16, top: 16),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 12,
                    children: data
                        .map(
                          (item) => BotsSuggestion(
                            title: item['title'],
                            message: item['body'],
                            onClick: () {
                              controller.messageController.text = item['body'];
                              controller.sendMessage();
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.grey.withOpacity(.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    style: FontManager.getTextStyle(
                      fontSize: 12,
                    ),
                    controller: controller.messageController,
                    textInputAction: TextInputAction.send,
                    readOnly: controller.isLoading,
                    onSubmitted: (value) {
                      controller.sendMessage();
                    },
                    decoration: InputDecoration(
                      hintText: "Message",
                      contentPadding: EdgeInsets.all(12),
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
