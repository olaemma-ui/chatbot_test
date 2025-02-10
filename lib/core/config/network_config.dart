import 'dart:io';

import 'package:dio/dio.dart';

/// This is the setup for the configuration for the apis
/// [NetworkConfiguration] extends the [BaseOptions] class and defines a
/// default value for every timeout and must not be more than 30s
class NetworkConfiguration extends BaseOptions {
  @override
  // TODO: implement connectTimeout
  Duration? get connectTimeout => const Duration(minutes: 3);

  @override
  // TODO: implement sendTimeout
  Duration? get sendTimeout => const Duration(minutes: 3);

  @override
  // TODO: implement receiveTimeout
  Duration? get receiveTimeout => const Duration(minutes: 3);

  @override
  // TODO: implement headers
  Map<String, dynamic> get headers => {
        HttpHeaders.userAgentHeader: 'dio',
        'Accept': 'application/json',
      };
}
