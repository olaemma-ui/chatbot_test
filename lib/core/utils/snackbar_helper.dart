import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatbot_test/core/theme/color_manager.dart';
import 'package:chatbot_test/core/utils/font_manager.dart';

class SnackbarHelper {
  //
  static closeAllSnackbars() => Get.closeAllSnackbars();

  static showSnackbar({required String message}) {
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        leftBarIndicatorColor: ColorManager.primary,
        messageText: Text(
          message,
          style: FontManager.getTextStyle(fontSize: 12),
        ),
        padding: const EdgeInsets.all(8),
        borderRadius: 8,
        backgroundColor: ColorManager.white,
        // borderColor: ColorManager.primaryAcent.withOpacity(.5),
        margin: const EdgeInsets.all(16),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        borderWidth: 2,
        icon: const Icon(
          CupertinoIcons.info,
          size: 20,
        ),
        isDismissible: true,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static showSnackbarSuccess({required String message}) {
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        boxShadows: [
          BoxShadow(
            color: ColorManager.black50.withOpacity(.1),
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
        messageText: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Success",
              style: FontManager.getTextStyle(
                  fontSize: 14,
                  fontWeight: FontManager.medium,
                  color: ColorManager.primary),
            ),
            Text(
              message,
              style: FontManager.getTextStyle(
                fontSize: 12,
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
        leftBarIndicatorColor: ColorManager.primary,
        padding: const EdgeInsets.all(8),
        borderRadius: 8,
        backgroundColor: ColorManager.white,
        borderColor: ColorManager.white,
        margin: const EdgeInsets.all(16),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        borderWidth: 2,
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          size: 20,
          color: ColorManager.primary,
        ),
        isDismissible: true,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
