import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:chatbot_test/core/exception/exception.dart';

import 'network_response.dart';

/// [NetworkService] This class handles all
/// the api calls in the application
abstract class NetworkService {
  ///[getUri] This method is used on get request
  ///The [uri] parameter is the uri to the enpoibt to fetch data from
  ///The  [headers] parameter is only passed when there's need to parse an header for th request
  Future<Either<Failure, NetworkResponse<T>>> loadJsonDataFromAsset<T>(
    String path,
  );

  ///[getUri] This method is used on get request
  ///The [uri] parameter is the uri to the enpoibt to fetch data from
  ///The  [headers] parameter is only passed when there's need to parse an header for th request
  Future<Either<Failure, NetworkResponse<T>>> getUri<T>(
    Uri uri, {
    Map<String, dynamic>? header,
  });

  Future<Either<Failure, NetworkResponse<T>>> fetchUri<T>(
    RequestOptions requestOptions,
  );

  ///[postUri] This method is used on get request
  ///The [uri] parameter is the uri to the enpoibt to fetch data from
  ///The  [headers] parameter is only passed when there's need to parse an header for th request
  ///The  [body] this is the request body for the endpoint called using this method
  Future<Either<Failure, NetworkResponse<T>>> postUri<T>(
    Uri uri, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    FormData? formData,
    Function(double sentPercent)? onSendProgress,
  });

  ///[getUri] This method is used on get request
  ///The [uri] parameter is the uri to the enpoibt to fetch data from
  ///The  [headers] parameter is only passed when there's need to parse an header for th request
  //////The  [body] this is the request body for the endpoint called using this method
  Future<Either<Failure, NetworkResponse<T>>> deletUri<T>(
    Uri uri, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  });

  ///[getUri] This method is used on get request
  ///The [uri] parameter is the uri to the enpoibt to fetch data from
  ///The  [headers] parameter is only passed when there's need to parse an header for th request
  //////The  [body] this is the request body for the endpoint called using this method
  Future<Either<Failure, NetworkResponse<T>>> putUri<T>(
    Uri uri, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  });

  ///[getUri] This method is used on get request
  ///The [uri] parameter is the uri to the enpoibt to fetch data from
  ///The  [headers] parameter is only passed when there's need to parse an header for th request
  //////The  [body] this is the request body for the endpoint called using this method
  Future<Either<Failure, NetworkResponse<T>>> patchUri<T>(
    Uri uri, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  });

  ///[downloadFile] This method is used on dowload a file from the server
  ///The [url] parameter is the uri to the enpoibt to fetch data from
  Future<Either<Failure, String>> downloadFile({
    required String url,
    required String savePath,
  });
}
