// ignore_for_file: public_member_api_docs, sort_constructors_first

/// Base response class that handles API network responses.
class NetworkResponse<T> {
  /// The status message from the API.
  final String? statusMessage;

  /// The status code from the API.
  final int? statusCode;

  /// The data returned from the API.
  final T? data;

  /// Additional information such as meta and response details.
  final Meta? meta;
  final ResponseInfo? responseInfo;

  const NetworkResponse({
    required this.statusMessage,
    required this.statusCode,
    this.data,
    this.meta,
    this.responseInfo,
  });

  /// Creates a new instance with optional overriding of fields.
  NetworkResponse<T> copyWith({
    String? statusMessage,
    int? statusCode,
    T? data,
    Meta? meta,
    ResponseInfo? responseInfo,
  }) {
    return NetworkResponse<T>(
      statusMessage: statusMessage ?? this.statusMessage,
      statusCode: statusCode ?? this.statusCode,
      data: data ?? this.data,
      meta: meta ?? this.meta,
      responseInfo: responseInfo ?? this.responseInfo,
    );
  }

  /// Factory method to create a `NetworkResponse` object from a map.
  factory NetworkResponse.fromMap(Map<String, dynamic> json) => NetworkResponse<T>(
        statusMessage: json["statusMessage"],
        statusCode: json["statusCode"],
        data: json["data"],
        meta: json["meta"] != null ? Meta.fromMap(json["meta"]) : null,
        responseInfo: json["responseInfo"] != null
            ? ResponseInfo.fromMap(json["responseInfo"])
            : null,
      );

  @override
  String toString() =>
      'NetworkResponse(statusMessage: $statusMessage, statusCode: $statusCode, data: $data, meta: $meta, responseInfo: $responseInfo)';
}

/// [ResponseInfo] class contains additional information about the API response.
class ResponseInfo {
  final int? httpCode;
  final String? message;
  final String? description;

  const ResponseInfo({
    this.httpCode,
    this.message,
    this.description,
  });

  /// Factory method to create a ResponseInfo object from a map.
  factory ResponseInfo.fromMap(Map<String, dynamic> json) => ResponseInfo(
        httpCode: json["httpCode"],
        message: json["message"],
        description: json["description"],
      );

  @override
  String toString() =>
      'ResponseInfo(httpCode: $httpCode, message: $message, description: $description)';
}

/// [Meta] class contains pagination details if present.
class Meta {
  final int? totalCount;
  final int? totalPages;
  final bool? hasNextPage;

  const Meta({
    this.totalCount,
    this.totalPages,
    this.hasNextPage,
  });

  /// Factory method to create a Meta object from a map.
  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
        hasNextPage: json["hasNextPage"],
      );

  @override
  String toString() =>
      'Meta(totalCount: $totalCount, totalPages: $totalPages, hasNextPage: $hasNextPage)';
}
