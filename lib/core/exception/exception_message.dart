abstract class ErrorMessages {
  /// Error message when a connection timesout.
  static const String connectionTimedOut =
      '''Oops! connection timed out. Please try again.''';

  /// Error message when there is a send time out.
  static const String sendTimeOut =
      '''Oops! Connection timed out. Please ensure your internet connection is stable and try again.''';

  /// Error message when the client doesn't
  /// response out data in the given time splice.
  static const String receiveTimeOut =
      '''Oops! Connection timed out. Please ensure your internet connection is stable and try again.''';

  /// Error message typically shown when there is a network
  /// response carries error.
  static const String responseError =
      '''Oops! There was something wrong with processing your request. Pls ensure your internet connection is stable.''';

  /// A generic error message when the cause of the error cannot be determined.
  static const String somethingWentWrong =
      'Oopss! something went wrong. Please try again';

  /// Error message shown when there is no interet connection.
  /// Example is SocketException.
  static const String noInternet =
      '''Please check your internet connection...''';

  /// Error message shown when the user is not authorised.
  /// Example is 401 HTTP Status Code
  static const String unAuthorised =
      '''Unauthorised...''';


  /// Error message shown when the user is not authorised.
  /// Example is 401 HTTP Status Code
  static const String serverError =
      '''Unauthorised...''';
}
