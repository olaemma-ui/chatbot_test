import 'dart:developer';

import 'package:chatbot_test/core/config/environment.dart';

///[ApiUri] this class is a constant class that contains all the Uri setup
///for each enpoint and makes it much more easier
class ApiUri {
  ///[_host] This is the host of the server
  ///The current running evnvironment dev
  static final String _host = _getHost();

  static String _getHost() {
    const String flavor = String.fromEnvironment('FLAVOR');
    log('flavor = $flavor');

    switch (Environment.currentEnvironment) {
      case EnvProcess.development:
        return 'api.theiapics.com';
      case EnvProcess.stagging:
        return 'apistage.theiapics.com';
      case EnvProcess.production:
        return 'apiprod.theiapics.com';
      default:
        return '';
    }
  }

  ///[_scheme] This defines the scheme for the api (http or https)
  static const String _scheme = 'https';

  ///[_version] This is the api version e.g v1
  // static final String _version =
  //     Environment.currentEnvironment == 'dev' ? '' : '/Development/';

  /// This is the base Uri setup for all enpoints
  static Uri _baseUri(String path, [Map<String, dynamic>? queryParameters]) =>
      Uri(
        scheme: _scheme,
        host: _host,
        path: path,
        queryParameters: queryParameters,
      );

  /// This is the base Uri setup for all enpoints
  static Uri _parkBaseUri(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) =>
      _baseUri('api/parks/visitor/$path', queryParameters);

  /// This is the base Uri setup for all enpoints
  static Uri _defaultBaseUri(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) =>
      _baseUri('api/users/$path', queryParameters);

  /// This is the base Uri setup for all enpoints
  static Uri _authBaseUri(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) =>
      _baseUri('api/users/auth/$path', queryParameters);

  /// This is the base Uri setup for all enpoints
  static Uri _publicBaseUri(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) =>
      _baseUri('api/users/public/$path', queryParameters);

  //======= Public Authentication URI declaration
  static Uri get login => _publicBaseUri('sign-in');
  static Uri get socialSignin => _publicBaseUri('social/sign-in');

  static Uri checkEmailAndPhone({
    required String phone,
    required String email,
    required String countryCode,
  }) =>
      _publicBaseUri('check-email-phone', {
        'email': email,
        'phone': phone,
        'countryCode': countryCode,
      });

  static Uri get generateSignupOtp => _publicBaseUri('generate-sign-up-otp');
  static Uri get signup => _publicBaseUri('sign-up');

  static Uri get reserPasswordGenerateOtp => _publicBaseUri('generate-otp');
  static Uri get resetPasswordVerifuOtp => _publicBaseUri(
        'validate-otp-reset-token',
      );
  static Uri get changePassword => _defaultBaseUri('change-password');
  static Uri get resetPassword => _defaultBaseUri('reset-password');

  //=======
  static Uri get refreshToken => _defaultBaseUri('refresh-token');

  //======= Profile UIR declaration
  static Uri get profile => _baseUri('api/users/me');
  static Uri get profileUpdate => _baseUri('api/users/update');
  static Uri get logout => _baseUri('api/users/logout');
  static Uri get deactivate => _baseUri('api/users/deactivate');
  static Uri get notification => _baseUri('api/users/notification/save');

  static Uri notificationList({required Map<String, dynamic> query}) =>
      _baseUri(
        'api/notifications/notifications',
        query,
      );

  static Uri get readAllNotification => _baseUri(
        'api/notifications/mark-all-as-read',
      );

  static Uri readNotification({
    required String notificationId,
  }) =>
      _baseUri('api/notifications/$notificationId/read');

  // FaceRecognition api declaration
  static Uri getSelfie({required String userId}) => _baseUri(
        'selfie/user-face/$userId',
      );
  // FaceRecognition api declaration
  static Uri deleteSelfie({required String userId}) => _baseUri(
        'selfie/user-face/$userId/clear-url',
      );

  // FaceRecognition api declaration
  static Uri get updateLocation => _baseUri('api/users/update-location');

  static Uri get uploadSelfie => _baseUri('selfie/upload-user-face');
  static Uri get matchingImage => _baseUri('face-matching/find-face-matches');

  static Uri get parktype => _baseUri('api/park-types/visitor');
  static Uri get nearbyParks => _baseUri('api/parks/visitor/nearby-parks');
  static Uri get recentParks => _baseUri('api/parks/visitor/recent-parks');
  static Uri parkRatings(String id) => _baseUri('api/park-ratings/$id/rate');
  static Uri userParkRatings(String id) => _baseUri(
        'api/park-ratings/$id/user-rating',
      );

  // static Uri for park lsit
  static Uri getParkList({required Map<String, dynamic> query}) =>
      _parkBaseUri('park-list', query);

  static Uri get getImageParkList => _baseUri('api/user-images/parks');

  // static Uri for park lsit
  static Uri get parkListOffers => _parkBaseUri('active-offers');

  static Uri getParkDetails({required String id}) =>
      _parkBaseUri('park-details/$id');

  static Uri get getCountryList => _baseUri('api/countries/public/get');
  static Uri get getLanguageList => _baseUri('api/common/public/languages');
  static Uri get getCurrenyList => _baseUri('api/common/public/currencies');

  // Pricing plan
  static Uri getPricingPlan(String parkId) => _baseUri(
        '/api/purchases/park/$parkId/pricing-details',
      );

  // PaymentIntent
  static Uri getPaymemtIntent(String parkId) => _baseUri(
        '/api/purchases/park/$parkId/create',
      );

  // PaymentIntent
  static Uri initialisepayment(String parkId) => _baseUri(
        '/api/purchases/park/$parkId/initialize',
      );

  // PaymentIntent
  static Uri getPurchasedImages(String purchaseId) => _baseUri(
        '/api/user-images/purchase/$purchaseId',
      );

  // PaymentIntent
  static Uri getDownloadedImages({
    required Map<String, dynamic> query,
  }) =>
      _baseUri(
        '/api/user-images/all',
        query,
      );

  // PaymentIntent
  static Uri getTransactionHistory({
    required Map<String, dynamic> query,
  }) =>
      _baseUri(
        '/api/purchases/user/all',
        query,
      );

  // PaymentIntent
  static Uri getTransactionDetails({
    required String purchasId,
  }) =>
      _baseUri('/api/purchases/$purchasId/details');

  // PaymentIntent
  static Uri validateCoupon({
    required Map<String, dynamic> query,
  }) =>
      _baseUri(
        'api/coupons/validate',
        query,
      );

  // PaymentIntent
  static Uri validateOffer({
    required Map<String, dynamic> query,
  }) =>
      _baseUri('api/offers/validate', query);

  // PaymentIntent
  static Uri removeCoupon({
    required String purchasId,
  }) =>
      _baseUri('api/purchases/remove-coupon/$purchasId');

  // PaymentIntent
  static Uri removeOffer({
    required String purchasId,
  }) =>
      _baseUri('api/purchases/remove-offer/$purchasId');

  // Get active coupon
  static Uri getActiveCoupon({
    required String parkId,
  }) =>
      _baseUri('api/coupons/park/$parkId/active');

  // Get active coupon
  static Uri getActiveOffers({required String parkId}) =>
      _baseUri('api/offers/valid/$parkId');

  // Get active coupon
  static Uri get notificationSettings => _baseUri('api/notifications/settings');

  // Video / Memories
  static Uri getCreatedVideos({
    required Map<String, dynamic> query,
  }) =>
      _baseUri(
        'api/user-videos/user/all',
        query,
      );

  // Video / Memories
  static Uri getProcessedVideo({
    required Map<String, dynamic> query,
  }) =>
      _baseUri(
        'api/user-videos/user/processed',
        query,
      );

  static Uri getVideoById({
    required String videoId,
  }) =>
      _baseUri('api/user-videos/$videoId');

  static Uri get createVideo => _baseUri('api/user-videos/create');

  static Uri get ticketList => _baseUri('api/support-tickets/user');
  static Uri get createTicket => _baseUri('api/support-tickets');

  static Uri sendMessage({required String ticketId}) =>
      _baseUri('api/support-tickets/$ticketId/messages/create');

  static Uri getTicketMessage({required String ticketId}) =>
      _baseUri('api/support-tickets/$ticketId/messages');

  static Uri ticketDetails({required String ticketId}) =>
      _baseUri('api/support-tickets/$ticketId');
}
