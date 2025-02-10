import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';

const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

extension StringEnxtension on String {
  getFileSize({int decimals = 1}) async {
    int bytes = length;
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  DateTime toDateTime() {
    DateFormat format = DateFormat("MMMM d, yyyy");
    return format.parse(this);
  }

  Color hex() {
    return Color(int.parse(replaceAll('#', '0xFF')));
  }

  Map<String, dynamic> get password => _password();

  _password() {
    bool upper = RegExp(r'[A-Z]').hasMatch(this);
    bool lower = RegExp(r'[a-z]').hasMatch(this);
    bool number = RegExp(r'[0-9]').hasMatch(this);
    bool symbol = RegExp(r'[(!@#$%^&*)]').hasMatch(this);
    bool length = this.length >= 8;
    return {
      'upper': upper,
      'lower': lower,
      'number': number,
      'symbol': symbol,
      'length': length
    };
  }

  validate({required String key, required Map errors}) {
    bool valid = false;
    if (key.toLowerCase().contains('name')) {
      errors[key].value = (isNotEmpty)
          ? (isAlphabetOnly)
              ? ''
              : 'Please enter your full name.'
          : 'Please enter your full name.';
      valid = isNotEmpty ? isAlphabetOnly : false;
    }
    if (key == 'email') {
      errors[key].value = (isNotEmpty)
          ? (isEmail)
              ? ''
              : 'Please enter a valid email address.'
          : 'Please enter a valid email address.';
      valid = isNotEmpty ? isEmail : false;
    }
    if (key == 'phone') {
      errors[key].value = (isNotEmpty)
          ? (isPhoneNumber)
              ? ''
              : 'Please enter a valid phone number.'
          : 'Please enter a valid phone number.';
      valid = isNotEmpty ? isPhoneNumber : false;
    }

    if (key == 'otp') {
      errors[key].value = (isNotEmpty)
          ? (isNumericOnly)
              ? ''
              : 'Invalid OTP'
          : 'This field is required';
      valid = isNotEmpty ? isNumericOnly : false;
    }

    if (key.toLowerCase().contains('password')) {
      errors[key].value =
          (isNotEmpty) ? '' : 'Password must be at least 8 characters long. ';
      valid = isNotEmpty;
    }

    return valid;
  }

  // bool name() => RegExp(r'[A-Za-z]').pattern.;
}

extension FileIoExtension on File {
  getFileSize({int decimals = 1}) async {
    int bytes = await length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

extension DateExtension on DateTime? {
  String? get toActualDate => this == null ? null : _getActualDate(this!);

  String? get toActualDateAbbr =>
      this == null ? null : _getActualDateAbbr(this!);
      
  String? get toActualTime => this == null ? null : _toTimeFormat();

  String get timeAgo => _timeAgo(this!);

  String _timeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} ${((difference.inDays / 7).floor() == 1) ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} ${((difference.inDays / 30).floor() == 1) ? 'month' : 'months'} ago';
    } else {
      return '${(difference.inDays / 365).floor()} ${((difference.inDays / 365).floor() == 1) ? 'year' : 'years'} ago';
    }
  }

  String _toTimeFormat() {
    // Determine hour in 12-hour format
    int hour = this!.hour % 12 == 0 ? 12 : this!.hour % 12;

    // Determine AM/PM
    String period = this!.hour >= 12 ? 'PM' : 'AM';

    // Format minute with leading zero if necessary
    String minute = this!.minute.toString().padLeft(2, '0');

    return '$hour:$minute $period';
  }

  String? timeLeft({required DateTime endDate}) => _formatTimeLeft(
        this,
        endDate,
      );

  String _formatTimeLeft(DateTime? endDate, DateTime startDate) {
    if (endDate == null) {
      return 'Expired'; // Return a default message if `endDate` is null
    }

    final duration = endDate.difference(startDate);
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    return '${days}d : ${hours}h : ${minutes}m';
  }
}

String _getActualDate(DateTime date) {
  final parsedDate = date;
  return '${_getMonthName(parsedDate.month)} ${parsedDate.day}, ${parsedDate.year}';
}

String _getActualDateAbbr(DateTime date) {
  final parsedDate = date;
  return '${_getMonthAbbr(parsedDate.month)} ${parsedDate.day}, ${parsedDate.year}';
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return 'Unknown';
  }
}

String _getMonthAbbr(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return 'Unknown';
  }
}

extension IntExtension on int {
  String get toDuration => _formatDuration();
  String _formatDuration() {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
