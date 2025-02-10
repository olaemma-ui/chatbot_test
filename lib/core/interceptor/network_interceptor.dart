import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:chatbot_test/core/constants/api_declartion.dart';
import 'package:chatbot_test/core/service/localstorage_service/localstorage_manager/localstorage_manager.dart';
// Access AuthRepoImpl

class NetworkInterceptor extends Interceptor {
  final Dio _dio = Dio(); // Directly using Dio

  int trialCount = 0;

  NetworkInterceptor() {
    _dio.interceptors.addAll([this]);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final cookies = await LocalStorageManager.cookie;
    final token = await LocalStorageManager.accessToken;
    if (token != null &&
        !options.path.contains('public') &&
        !options.path.contains('logout')) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    if (cookies != null && options.path.contains('logout')) {
      options.headers['Cookie'] = cookies;
    }

    log('options = ${options.headers}');

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final cookies = await LocalStorageManager.cookie;
      // log('cookies = $cookies');
      log('trialCount = $trialCount');

      if (trialCount < 3) {
        trialCount++;
        try {
          final response = await _dio.postUri(
            ApiUri.refreshToken,
            options: Options(headers: {'Cookie': cookies}),
          );

          final newToken = response.data['data']['token'];
          await LocalStorageManager.setAccessToken(newToken);

          // Retry the original request with the new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          // log('requestOptions method = ${err.requestOptions.method}');
          // log('requestOptions path = ${err.requestOptions.path}');
          final retryResponse = await _dio.fetch(err.requestOptions);
          // log('trialCount = $trialCount');
          handler.resolve(retryResponse);
        } catch (refreshError) {
          // If refreshing fails, reject the error
          // Get.offAllNamed(AppRoutes.login);
          log('trialCount 1 = $trialCount');
          handler.reject(err);
        }
      } else {
        // No refresh token available, reject the error
        // Get.offAllNamed(AppRoutes.login);
        log('trialCount 2 = $trialCount');
        handler.reject(err);
      }
    } else {
      // Handle other errors
      // Get.offAllNamed(AppRoutes.login);
      log('trialCount 3 = $trialCount');
      super.onError(err, handler);
    }
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    String? cookies; // Variable to store the cookies

    if (response.requestOptions.path.contains('sign-in')) {
      if (response.headers['set-cookie'] != null) {
        cookies = response.headers['set-cookie']!.join('; ');
      }
      await LocalStorageManager.setCookie(cookies);
    }

    // log('response = ${response.data}');
    handler.next(response);
  }
}
