// ignore_for_file: public_member_api_docs, sort_constructors_first

/// This class is the base failure class that default exception format
/// [prettyMessage] This message is displayed to the user
/// [devMessage] This message is logged in the terminal for the developer
/// [stackTrace] This is the stacktrace for the exception
/// [statusCode] This is the status statusCode of the exception
/// [Failure] Base Exception/error class will be extended by other classes
abstract class Failure {
  ///[prettyMessage] UI message
  final String prettyMessage;

  ///[devMessage] Developr message
  final String devMessage;

  ///[stackTrace] error stackTrace
  final StackTrace stackTrace;

  final dynamic data;
  Failure({
    required this.prettyMessage,
    required this.devMessage,
    this.data,
    this.stackTrace = StackTrace.empty,
  });
}

/// This exceptions when there is a recieve timeout exception.
/// It is typically thrown when the client doesn't respond during
/// the specified timesplice.
final class ClientNetworkException extends Failure {
  /// This is the constructor of the [ClientNetworkException]  class.
  ClientNetworkException({
    required super.prettyMessage,
    required super.devMessage,
    super.stackTrace,
  });
}

/// This exception is thrown when the server returns a bad reponse,
/// or the user sends a bad request.
final class BadFormatException extends Failure {
  /// This is the constructor of the [BadFormatException]  class.
  BadFormatException({
    required super.prettyMessage,
    required super.devMessage,
    this.statusCode,
    super.stackTrace,
  });

  /// status statusCode of the error.
  final int? statusCode;
}

/// This exception is thrown when the user's internet connection
/// is not available.
final class NoInternetException extends Failure {
  /// This is the constructor of the [NoInternetException]  class.
  NoInternetException({
    required super.prettyMessage,
    required super.devMessage,
    super.stackTrace,
  });
}

/// This exception is thrown when the server returns a 404 error.
/// Also when the type of error cannot be determined.
final class UnknownException extends Failure {
  /// This is the constructor of the [UnknownException]  class.
  UnknownException({
    required super.prettyMessage,
    required super.devMessage,
    required this.statusCode,
    super.stackTrace,
  });

  /// status statusCode of the error.
  final int? statusCode;
}

/// This exception is thrown when the server returns a 500 error.
/// It is typically thrown when the server is down.
/// This exception can when the server doesn't respond within the timesplice.
final class ServerNetworkException extends Failure {
  /// This is the constructor of the [ServerNetworkException]  class.
  ServerNetworkException({
    required super.prettyMessage,
    required super.devMessage,
    required this.statusCode,
    super.stackTrace,
  });

  /// status statusCode of the error.
  final int? statusCode;
}

/// This exception is thrown when the requested cached data is not found.
final class RequestCancelledException extends Failure {
  /// This is the constructor of the [RequestCancelledException]  class.
  RequestCancelledException({
    required super.prettyMessage,
    required super.devMessage,
    required this.statusCode,
    super.stackTrace,
  });

  /// status statusCode of the error.
  final int? statusCode;
}

/// This exception is thrown when the api returns a diff statuscode.
final class DefaultException extends Failure {
  /// This is the constructor of the [DefaultException]  class.
  DefaultException({
    required super.prettyMessage,
    required super.devMessage,
    required this.statusCode,
    required this.error,
    required this.status,
    required super.data,
    super.stackTrace,
  });

  /// status statusCode of the error.
  final int? statusCode;
  final String status;
  final dynamic error;
  

  @override
  String toString() => 'DefaultException('
      'prettyMessage: $prettyMessage,'
      'devMessage: $devMessage,'
      'statusCode: $statusCode,'
      'error: $error,'
      'status: $status,'
      'data: $data,'
      'stackTrace: $stackTrace,)';
}
