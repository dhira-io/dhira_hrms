import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Modern DateTime extensions for intuitive method chaining
extension DateTimeExtensions on DateTime {
  /// Formats the DateTime into a dynamic custom string. Defaults to 'yyyy-MM-dd'.
  String format([String pattern = 'yyyy-MM-dd']) {
    return DateFormat(pattern).format(this);
  }

  /// Returns the first day of the current month.
  DateTime get firstDayOfMonth => DateTime(year, month, 1);

  /// Returns the last day of the current month.
  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  /// Returns the time in a standard localized format (e.g., 9:00 AM).
  String get toTime => DateFormat.jm().format(this);
}

/// Utility class for global Date and Time operations
class DateTimeUtils {
  // Prevent instantiation
  DateTimeUtils._();

  /// Returns today's date formatted dynamically.
  static String todayDate({String pattern = 'yyyy-MM-dd'}) {
    return DateTime.now().format(pattern);
  }

  /// Returns the first day of the current month as a formatted string.
  static String getFirstDayOfMonth({String pattern = 'dd-MM-yy'}) {
    return DateTime.now().firstDayOfMonth.format(pattern);
  }

  /// Returns the last day of the current month as a formatted string.
  static String getLastDayOfMonth({String pattern = 'dd-MM-yy'}) {
    return DateTime.now().lastDayOfMonth.format(pattern);
  }

  /// Safely converts a given ISO string date to a localized time format.
  static String convertDateStringToTime(String datetime, [String fallback = '--:--']) {
    try {
      final dt = DateTime.parse(datetime).toLocal();
      return dt.toTime;
    } catch (e) {
      return fallback;
    }
  }

  /// Dynamically computes a localized greeting based on current device time.
  static String getGreetingMessage({String prefix = 'Hello,'}) {
    final hour = TimeOfDay.now().hour;
    
    String greeting;
    if (hour >= 5 && hour < 12) {
      greeting = 'Good morning';
    } else if (hour >= 12 && hour < 17) {
      greeting = 'Good afternoon';
    } else if (hour >= 17 && hour < 21) {
      greeting = 'Good evening';
    } else {
      greeting = 'Good night';
    }

    return prefix.isEmpty ? greeting : '$prefix $greeting';
  }
}
