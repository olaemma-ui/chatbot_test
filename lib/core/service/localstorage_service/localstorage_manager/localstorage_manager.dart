import 'package:chatbot_test/app/app.dart';
import 'package:chatbot_test/core/enums/enums.dart';
import '../local_storage_service.dart';

/// [LocalStorageManager] this class manages
/// most of the localstorage request.
abstract class LocalStorageManager {
  static final _localstorageService = locator<LocalStorageService>();

  /// [clearAll]
  /// This method clears the entire application data
  /// stored on the device local storage
  static Future<void> clearAll() async {
    LocalStorageBox.values.forEach((box) async {
      if (box != LocalStorageBox.APP_DATA) {
        await _localstorageService.clearAll(box: box);
      }
    });
  }

  /// [isLoggedIn]
  /// Checks if the app is just launched for the first time on the device
  static Future<bool> get isLoggedIn async =>
      (await _localstorageService.findByKey<bool?>(
        box: LocalStorageBox.USER_DATA,
        key: LocalStorageKey.IS_LOGGEDIN,
      )) ??
      true;

  /// [setIsLoggedIn]
  /// Sets the current device first time status to false
  /// the method and store locally
  static Future<void> setIsLoggedIn() async {
    await _localstorageService.storeByKey<bool?>(
      box: LocalStorageBox.USER_DATA,
      key: LocalStorageKey.IS_LOGGEDIN,
      data: true,
    );
  }

  /// [isFirstTime]
  /// Checks if the app is just launched for the first time on the device
  static Future<bool> get isFirstTime async =>
      (await _localstorageService.findByKey<bool?>(
        box: LocalStorageBox.APP_DATA,
        key: LocalStorageKey.FIRST_TIME,
      )) ??
      true;

  /// [setIsFirstTime]
  /// Sets the current device first time status to false
  /// the method and store locally
  static Future<void> setIsFirstTime() async {
    await _localstorageService.storeByKey<bool?>(
      box: LocalStorageBox.APP_DATA,
      key: LocalStorageKey.FIRST_TIME,
      data: false,
    );
  }

  /// [accessToken]
  /// Checks if the app is just launched for the first time on the device
  static Future<String?> get cookie async =>
      (await _localstorageService.findByKey<String?>(
        box: LocalStorageBox.USER_DATA,
        key: LocalStorageKey.COOKIE,
      )) ??
      '';

  /// [setAccessToken]
  /// Sets the current logged in user acces token on the device
  static Future<void> setCookie(String? cookie) async {
    await _localstorageService.storeByKey<String?>(
      box: LocalStorageBox.USER_DATA,
      key: LocalStorageKey.COOKIE,
      data: cookie,
    );
  }

  /// [accessToken]
  /// Checks if the app is just launched for the first time on the device
  static Future<String?> get accessToken async =>
      (await _localstorageService.findByKey<String?>(
        box: LocalStorageBox.USER_DATA,
        key: LocalStorageKey.ACCESS_TOKEN,
      )) ??
      '';

  /// [setAccessToken]
  /// Sets the current logged in user acces token on the device
  static Future<void> setAccessToken(String token) async {
    await _localstorageService.storeByKey<String?>(
      box: LocalStorageBox.USER_DATA,
      key: LocalStorageKey.ACCESS_TOKEN,
      data: token,
    );
  }
}
