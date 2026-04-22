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

  /// Formats date to 'yyyy-MM-dd' (e.g., 2023-10-25)
  static String formatToYMD(DateTime date) {
    return date.format('yyyy-MM-dd');
  }

  /// Formats date to 'MMMM' (e.g., October)
  static String formatToMonthName(DateTime date) {
    return date.format('MMMM');
  }

  /// Formats date to 'EEEE, MMMM d, yyyy' (e.g., Monday, October 25, 2023)
  static String formatToFullDate(DateTime date) {
    return date.format('EEEE, MMMM d, yyyy');
  }

  /// Returns 2-letter abbreviation of the day (e.g., MO, TU)
  static String formatToDayAbbr(DateTime date) {
    return DateFormat.E().format(date).substring(0, 2);
  }

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
  static String convertDateStringToTime(
    String datetime, [
    String fallback = '--:--',
  ]) {
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

  /// Formats a given DateTime into a custom string using the provided pattern.
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return date.format(pattern);
  }

  /// Generates the key for the Timesheet Week (e.g., "Week 2 Jan 5 - Jan 11, 2026")
  static String getTimesheetWeekKey(DateTime date) {
    // Find Monday of the week
    final monday = date.subtract(Duration(days: date.weekday - 1));
    final sunday = monday.add(const Duration(days: 6));

    // Calculate Week of the Month (Monday to Sunday)
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final firstMonday = firstDayOfMonth.add(Duration(
        days: (firstDayOfMonth.weekday <= 1)
            ? (1 - firstDayOfMonth.weekday)
            : (8 - firstDayOfMonth.weekday)));
    
    // If the date is before the first Monday, it's Week 1
    int weekNumber;
    if (monday.isBefore(firstMonday)) {
      weekNumber = 1;
    } else {
      weekNumber = ((monday.day - firstMonday.day) / 7).floor() + 2;
    }

    final monthStr = DateFormat('MMM').format(monday);
    final mondayDay = monday.day;
    final sundayDay = sunday.day;
    final year = monday.year;

    return "Week $weekNumber $monthStr $mondayDay - $monthStr $sundayDay, $year";
  }

  /// Generates the key for the Timesheet Day (e.g., "Tuesday Jan 6, 2026")
  static String getTimesheetDayKey(DateTime date) {
    return DateFormat('EEEE MMM d, yyyy').format(date);
  }
}
