// ignore_for_file: constant_identifier_names

enum LocalStorageKey {
  // User data keys
  PROFILE,
  SELFIE,
  ACCESS_TOKEN,
  REFRESH_TOKEN,
  COOKIE,
  PARK_LIST,
  IS_LOGGEDIN,

  //App Data Keys
  FIRST_TIME,
  COUNTRY_LIST,
  CURRENCY_LIST,
  LANGUAGE_LIST,
}

enum LocalStorageBox {
  USER_DATA,
  APP_DATA,
}

enum AuthType {
  MANUAL,
  SOCIAL,
}

enum AnimateFrom {
  left,
  right,
  top,
  bottom,
}

enum AppAnimationStyle {
  fade,
  slide,
  resize,
}

// enum FaceCaptureStep {
//   lookLeft('Please turn your head left', 0, false),
//   lookRight('Please turn your head right', 40, false),
//   lookUp('Please look up', 55, false),
//   lookDown('Please look down', 70, false),
//   blink('Please blink your eyes', 85, false),
//   lookStraight('Please look straight', 100, false);

//   final String prompt;
//   final bool captured;
//   final int percent; // Progress percentage

//   const FaceCaptureStep(this.prompt, this.percent, this.captured);

//   // Method to get the current progress percentage
//   int get progress => percent;

//   // Mimicking copyWith for enums
//   FaceCaptureStep copyWith({String? prompt, bool? captured, int? percent}) {
//     return FaceCaptureStep.values.firstWhere(
//       (step) =>
//           step.prompt == (prompt ?? this.prompt) &&
//           step.captured == (captured ?? this.captured) &&
//           step.percent == (percent ?? this.percent),
//       orElse: () => this,
//     );
//   }
// }

enum FaceCaptureStep {
  lookLeft(
    prompt: 'Please turn your head left',
    percent: 0,
    captured: false,
    description: 'Turn your head slightly to the left to capture your profile.',
  ),
  lookRight(
    prompt: 'Please turn your head right',
    percent: 20,
    captured: false,
    description:
        'Turn your head slightly to the right to capture your profile.',
  ),
  lookUp(
    prompt: 'Please look up',
    percent: 35,
    captured: false,
    description: 'Tilt your head upward for an upward capture.',
  ),
  lookDown(
    prompt: 'Please look down',
    percent: 45,
    captured: false,
    description: 'Tilt your head downward for a downward capture.',
  ),
  lookStraight(
    prompt: 'Please look straight',
    percent: 60,
    captured: false,
    description: 'Look straight at the camera to complete the capture process.',
  ),
  blink(
    prompt: 'Please blink your eyes',
    percent: 100,
    captured: false,
    description: 'Blink your eyes once to verify liveness.',
  );

  final String prompt;
  final int percent;
  final bool captured;
  final String description;

  const FaceCaptureStep({
    required this.prompt,
    required this.percent,
    required this.captured,
    required this.description,
  });

  // Method to get the progress percentage
  int get progress => percent;

  // Method to copyWith updated properties
  FaceCaptureStep copyWith({String? prompt, bool? captured, int? percent}) {
    return FaceCaptureStep.values.firstWhere(
      (step) =>
          step.prompt == (prompt ?? this.prompt) &&
          step.captured == (captured ?? this.captured) &&
          step.percent == (percent ?? this.percent),
      orElse: () => this,
    );
  }
}

enum VerificationType {
  EMAIL,
  PHONE,
}
