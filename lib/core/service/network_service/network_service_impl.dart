import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:chatbot_test/core/config/network_config.dart';
import 'package:chatbot_test/core/exception/exception.dart';
import 'package:chatbot_test/core/exception/exception_handler.dart';
import 'package:chatbot_test/core/interceptor/network_interceptor.dart';
import 'package:chatbot_test/core/logger/logger.dart';
import 'network_response.dart';
import 'network_service.dart';

class NetworkServiceImpl extends NetworkService {
  final _dio = Dio(
    NetworkConfiguration(),
  );

  final _log = getLogger("NetworkServiceImpl");

  NetworkServiceImpl() {
    _dio.interceptors.addAll([
      NetworkInterceptor(),
    ]);
  }

  @override
  Future<Either<Failure, NetworkResponse<T>>> deletUri<T>(
    Uri uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    // TODO: implement deletUri
    try {
      final resp = await _dio.deleteUri(uri, data: body);
      return Right(
        NetworkResponse(
          statusMessage: resp.statusMessage,
          statusCode: resp.statusCode,
          data: resp.data,
        ),
      );
    } on DioException catch (e) {
      // _log.e("Delete Method", error: e, stackTrace: e.stackTrace);
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, NetworkResponse<T>>> fetchUri<T>(
    RequestOptions requestOptions,
  ) async {
    // TODO: implement getUri
    try {
      final resp = await _dio.fetch(requestOptions);

      return Right(
        NetworkResponse(
          statusMessage: resp.statusMessage,
          statusCode: resp.statusCode,
          data: resp.data,
        ),
      );
    } on DioException catch (e) {
      // _log.e("Get Method", error: e, stackTrace: e.stackTrace);
      // Haptics.vibrate(HapticsType.error);
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, NetworkResponse<T>>> getUri<T>(
    Uri uri, {
    Map<String, dynamic>? header,
  }) async {
    // TODO: implement getUri
    try {
      final resp = await _dio.getUri(uri);
      log('Uri = ${uri.path}');
      log('Query = ${uri.queryParameters}');
      return Right(
        NetworkResponse(
          statusMessage: resp.statusMessage,
          statusCode: resp.statusCode,
          data: resp.data,
        ),
      );
    } on DioException catch (e) {
      // _log.e("Get Method", error: e, stackTrace: e.stackTrace);
      // Haptics.vibrate(HapticsType.error);
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, NetworkResponse<T>>> postUri<T>(
    Uri uri, {
    Map<String, dynamic>? body,
    FormData? formData,
    Map<String, dynamic>? headers,
    Function(double sentPercent)? onSendProgress,
  }) async {
    // TODO: implement postUri
    try {
      final resp = await _dio.postUri(
        uri,
        data: body ?? formData,
        onSendProgress: (sent, total) async {
          if (onSendProgress != null) onSendProgress((sent / total * 100));
          await Future.delayed(const Duration(seconds: 2));
        },
      );
      return Right(
        NetworkResponse(
          statusMessage: resp.statusMessage,
          statusCode: resp.statusCode,
          data: resp.data,
        ),
      );
    } on DioException catch (e) {
      // _log.e("Post Method", error: e, stackTrace: e.stackTrace);
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, NetworkResponse<T>>> putUri<T>(
    Uri uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    // TODO: implement putUri
    try {
      final resp = await _dio.putUri(uri, data: body);
      return Right(
        NetworkResponse(
          statusMessage: resp.statusMessage,
          statusCode: resp.statusCode,
          data: resp.data,
        ),
      );
    } on DioException catch (e) {
      // _log.e("Put Method", error: e, stackTrace: e.stackTrace);
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, NetworkResponse<T>>> patchUri<T>(
    Uri uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    // TODO: implement putUri
    try {
      final resp = await _dio.patchUri(uri, data: body);
      return Right(
        NetworkResponse(
          statusMessage: resp.statusMessage,
          statusCode: resp.statusCode,
          data: resp.data,
        ),
      );
    } on DioException catch (e) {
      // _log.e("Put Method", error: e, stackTrace: e.stackTrace);
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, NetworkResponse<T>>> loadJsonDataFromAsset<T>(
      String path) async {
    // TODO: implement loadJsonDataFromAsset
    try {
      String jsonString = await rootBundle.loadString(path);
      final jsonData = json.decode(jsonString);

      return Right(
        NetworkResponse(
          statusMessage: 'OK',
          statusCode: 200,
          data: jsonData as T,
        ),
      );
    } on DioException catch (e) {
      // Logger
      _log.e(
        "Put Method",
        error: e,
        stackTrace: StackTrace.empty,
      );

      return Left(
        DefaultException(
            prettyMessage: 'File not found',
            devMessage: e.toString(),
            statusCode: 500,
            error: e.toString(),
            status: '404',
            data: null),
      );
    }
  }

  /// Downloads a file from the given URL and saves it to the specified path.
  /// Returns an `Either<Failure, String>` where the string is the saved file path.
  @override
  Future<Either<Failure, String>> downloadFile({
    required String url,
    required String savePath,
  }) async {
    try {
      await _dio.download(url, savePath);
      return Right(savePath); // Return the saved file path on success.
    } on DioException catch (e) {
      _log.d(
        "Download File",
        error: e,
        stackTrace: e.stackTrace,
      );
      return Left(
        ExceptionHandler.handleException(e),
      ); // Handle and return the exception.
    } catch (e) {
      // _log.e("Download File", error: e);
      return Left(
        DefaultException(
            prettyMessage: 'Download failed',
            devMessage: e.toString(),
            statusCode: 500,
            error: e.toString(),
            status: '500',
            data: null),
      ); // Handle generic exceptions.
    }
  }
}
