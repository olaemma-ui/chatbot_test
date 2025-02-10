// import 'package:chatbot_test/core/logger/logger.dart';
import 'dart:developer';

abstract class Utils {
  static String? validatePassword(String password) {
    // Check if the password is at least 8 characters long
    if (password.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[a-z]').hasMatch(password) ||
        !RegExp(r'\d').hasMatch(password)) {
      return 'Password should contain one Uppercase, Lowercase,Number and 8 characters long';
    }

    // // Check for an uppercase letter
    // if (!RegExp(r'[A-Z]').hasMatch(password)) {
    //   return 'Password must contain at least one uppercase letter';
    // }

    // // Check for a lowercase letter
    // if (!RegExp(r'[a-z]').hasMatch(password)) {
    //   return 'Password must contain at least one lowercase letter';
    // }

    // // Check for a number
    // if (!RegExp(r'\d').hasMatch(password)) {
    //   return 'Password must contain at least one number';
    // }

    // // Check for a special character
    // if (!RegExp(r'[@$!%*?&]').hasMatch(password)) {
    //   return 'Password must contain at least one special character';
    // }

    // If all validations pass, return null (indicating no error)
    return null;
  }

  // Phone number validation
  static String? validatePhoneNumber(String phoneNumber) {
    // // Check if the phone number contains only digits
    // if (!RegExp(r'^[\d]+$').hasMatch(phoneNumber)) {
    //   return 'Phone number must contain only digits';
    // }

    log('phoneNumber.length = ${phoneNumber.length}');

    // Check if the phone number is between 10 and 15 digits long (adjust as needed)
    if (phoneNumber.length < 9 || phoneNumber.length > 15) {
      return 'Phone number must be 9 to 15 digits long';
    }

    // Check if the phone number starts with a valid country code (optional)
    if (!RegExp(r'^\+?\d{1,3}').hasMatch(phoneNumber)) {
      return 'Phone number must start with a valid country code';
    }

    // If all validations pass, return null (indicating no error)
    return null;
  }
}
