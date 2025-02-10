import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'exception.dart';
import 'exception_message.dart';

class ExceptionHandler {
  static Failure handleException(DioException e) {
    log('err = $e ${e.requestOptions.uri} ${e.response?.requestOptions.baseUrl}');
    // if (e.response?.data != null && e.response?.data != '') {
    //   final resp = (e.response?.data as Map<String, dynamic>);
    //   return DefaultException(
    //     prettyMessage: resp['message'] ?? 'Sorry an error occurred',
    //     devMessage: e.message ?? '',
    //     statusCode: e.response?.statusCode,
    //     error: resp['message'],
    //     status: '',
    //   );
    // }

    // Parse error response if it's in the expected format
    if (e.response != null && e.response?.data is Map<String, dynamic>) {
      final responseData = e.response?.data as Map<String, dynamic>;
      final responseInfo = responseData['responseInfo'];
      final data = responseData['data'];

      if (responseInfo != null && responseInfo is Map<String, dynamic>) {
        final httpCode = responseInfo['httpCode'] ?? 500;
        final errorMessage = _getErrorMessage(responseInfo['message']);
        final description = responseInfo['description'] ?? '';

        // Log the detailed error message for debugging
        log('HTTP Error: $httpCode - $errorMessage, Description: $description, Path: ${responseData['path']}');

        // Return DefaultException based on the HTTP code
        return _handleHttpCode(
          httpCode: httpCode,
          message: errorMessage,
          description: description,
          devMessage: '${e.message} - ${e.stackTrace}',
          stackTrace: e.stackTrace,
          data: data,
        );
      }
    }

    if (e.error is SocketException) {
      return NoInternetException(
        prettyMessage: ErrorMessages.noInternet,
        devMessage: '${e.message} - ${e.stackTrace}',
        stackTrace: e.stackTrace,
      );
    }
    if (e.error is FormatException) {
      return BadFormatException(
        prettyMessage: e.message ?? ErrorMessages.somethingWentWrong,
        devMessage: '${e.message} - ${e.stackTrace}',
        stackTrace: e.stackTrace,
      );
    }

    return switch (e.type) {
      DioExceptionType.badResponse => BadFormatException(
          prettyMessage: e.message ?? ErrorMessages.somethingWentWrong,
          devMessage: '${e.message} - ${e.stackTrace}',
          stackTrace: e.stackTrace,
        ),
      DioExceptionType.badCertificate => UnknownException(
          prettyMessage: e.message ?? ErrorMessages.somethingWentWrong,
          devMessage: '${e.message} - ${e.stackTrace}',
          stackTrace: e.stackTrace,
          statusCode: e.response?.statusCode,
        ),
      DioExceptionType.unknown => UnknownException(
          prettyMessage: e.message ?? ErrorMessages.somethingWentWrong,
          devMessage: '${e.message} - ${e.stackTrace}',
          stackTrace: e.stackTrace,
          statusCode: e.response?.statusCode,
        ),
      DioExceptionType.connectionError => NoInternetException(
          prettyMessage: ErrorMessages.noInternet,
          devMessage: e.message ?? '',
          stackTrace: e.stackTrace,
        ),
      DioExceptionType.sendTimeout => ClientNetworkException(
          prettyMessage: ErrorMessages.sendTimeOut,
          devMessage: e.message ?? '',
          stackTrace: e.stackTrace,
        ),
      DioExceptionType.connectionTimeout => ClientNetworkException(
          prettyMessage: ErrorMessages.receiveTimeOut,
          devMessage: e.message ?? '',
          stackTrace: e.stackTrace,
        ),
      DioExceptionType.receiveTimeout => ServerNetworkException(
          prettyMessage: ErrorMessages.somethingWentWrong,
          devMessage: e.message ?? '',
          stackTrace: e.stackTrace,
          statusCode: e.response?.statusCode,
        ),
      DioExceptionType.cancel => RequestCancelledException(
          prettyMessage: ErrorMessages.somethingWentWrong,
          devMessage: e.message ?? '',
          stackTrace: e.stackTrace,
          statusCode: e.response?.statusCode,
        ),
    };
  }

  /// Extract error message from API response
  static String _getErrorMessage(dynamic message) {
    if (message is List && message.isNotEmpty) {
      return message
          .join(', '); // Join multiple error messages if provided in an array
    }
    return message?.toString() ?? ErrorMessages.somethingWentWrong;
  }

  /// Handle the HTTP code and map it to DefaultException
  static DefaultException _handleHttpCode({
    required int httpCode,
    required String message,
    required String description,
    required String devMessage,
    required StackTrace? stackTrace,
    required dynamic data,
  }) {
    // Return a DefaultException for all HTTP status codes
    return DefaultException(
      prettyMessage: message,
      devMessage: '$message - $description',
      stackTrace: stackTrace ?? StackTrace.empty,
      statusCode: httpCode,
      error: httpCode.toString(),
      status: httpCode.toString(),
      data: data,
    );
  }
}
