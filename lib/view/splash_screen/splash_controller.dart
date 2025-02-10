import 'package:chatbot_test/core/routes/routes.dart';
import 'package:get/get.dart';
import 'package:chatbot_test/core/enums/enums.dart';
import 'package:chatbot_test/core/routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3), () {
      _goNext();
    });

    super.onInit();
  }

  ///[_goNext] This method allows you
  ///to navigate to the next page of the onboarding
  ///also it sets the [LocalStorageKey.FIRST_TIME] to false
  _goNext() async {
    // final isFirstTime = await LocalStorageManager.isFirstTime;
    // final isLoggedIn = await LocalStorageManager.isLoggedIn;
    // final token = await LocalStorageManager.accessToken;

    // await LocalStorageManager.setIsFirstTime();

    // if (!isFirstTime) {
    return Get.offAllNamed(AppRoutes.home);
    // }

    // return Get.offAllNamed(AppRoutes.onboarding);
  }
}
