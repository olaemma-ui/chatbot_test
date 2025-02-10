class Environment {
  
  /// This variable holds the current running flavor of the app
  static EnvProcess? environment;

  /// This returns the current running build variant
  static EnvProcess get currentEnvironment => environment ?? EnvProcess.development;

  /// This returns the stripe payment key
  static String get stripeKey =>
      'pk_test_51IxUMeClzMdxwhfo9SLZCdor2BSdjvfIfDGcCXgHobTkLTutZD0GaCDYNR21b46mFTOIouIS28vqudkCh8j8bVXn000qz0Lk6t';
}


enum EnvProcess{
  production,
  development,
  stagging,
}