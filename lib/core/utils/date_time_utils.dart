import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/utils/regex_utils.dart';
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

  /// Formats date to 'dd-MM-yy' (e.g., 01-05-26)
  static String formatToDMYShort(DateTime date) {
    return date.format('dd-MM-yy');
  }

  /// Formats date to 'EEEE, MMMM d, yyyy' (e.g., Monday, October 25, 2023)
  static String formatToFullDate(DateTime date) {
    return date.format('EEEE, MMMM d, yyyy');
  }

  /// Returns 2-letter abbreviation of the day (e.g., MO, TU)
  static String formatToDayAbbr(DateTime date) {
    return DateFormat.E().format(date).substring(0, 2);
  }

  /// Returns 1-letter abbreviation of the day (e.g., M, T)
  static String formatTo1LetterDay(DateTime date) {
    return DateFormat.E().format(date).substring(0, 1);
  }

  /// Returns 3-letter abbreviation of the day in uppercase (e.g., MON, TUE)
  static String formatToDayAbbrFull(DateTime date) {
    return DateFormat.E().format(date).toUpperCase();
  }

  /// Returns today's date formatted dynamically.
  static String todayDate({String pattern = 'yyyy-MM-dd'}) {
    return DateTime.now().format(pattern);
  }

  /// Returns the first day of the current month as a formatted string.
  static String getFirstDayOfMonth({String pattern = 'dd-MM-yy'}) {
    return DateTime.now().firstDayOfMonth.format(pattern);
  }

  /// Returns the first day of the given month.
  static DateTime getFirstDayOfMonthFromDate(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Returns the last day of the current month as a formatted string.
  static String getLastDayOfMonth({String pattern = 'dd-MM-yy'}) {
    return DateTime.now().lastDayOfMonth.format(pattern);
  }

  /// Returns the last day of the given month.
  static DateTime getLastDayOfMonthFromDate(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
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

  /// Formats a Duration to HH:mm:ss string
  static String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  /// Formats a given DateTime into a custom string using the provided pattern.
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return date.format(pattern);
  }

  /// Parses a duration label like "1h 30m" or "45m" into a [Duration].
  static Duration parseDurationLabel(String label) {
    if (label.isEmpty) return Duration.zero;

    int hours = 0;
    int minutes = 0;

    final hMatch = RegExp(r'(\d+)h').firstMatch(label);
    final mMatch = RegExp(r'(\d+)m').firstMatch(label);

    if (hMatch != null) {
      hours = int.tryParse(hMatch.group(1) ?? '0') ?? 0;
    }
    if (mMatch != null) {
      minutes = int.tryParse(mMatch.group(1) ?? '0') ?? 0;
    }

    return Duration(hours: hours, minutes: minutes);
  }

  /// Formats a date range into a readable string (e.g., "Jan 01 - Jan 05, 2023")
  static String formatDateRange(String from, String to) {
    try {
      final fromDate = DateTime.parse(from);
      final toDate = DateTime.parse(to);
      final formatter = DateFormat('MMM dd');
      final yearFormatter = DateFormat('yyyy');

      if (from == to) {
        return "${formatter.format(fromDate)}, ${yearFormatter.format(fromDate)}";
      } else {
        return "${formatter.format(fromDate)} - ${formatter.format(toDate)}, ${yearFormatter.format(toDate)}";
      }
    } catch (_) {
      return "$from - $to";
    }
  }

  /// Formats a holiday date string to show only day and month (e.g., "26 Jan").
  static String formatHolidayDate(String dateString) {
    final parsedDate = DateTime.tryParse(dateString);
    if (parsedDate == null) return dateString;
    return DateFormat('dd MMM').format(parsedDate);
  }

  /// Returns the day number (e.g., "01", "25").
  static String getDayNumber(DateTime date) => DateFormat('dd').format(date);

  /// Returns the month abbreviation in uppercase (e.g., "JAN", "OCT").
  static String getMonthAbbr(DateTime date) =>
      DateFormat('MMM').format(date).toUpperCase();

  /// Returns the full day name (e.g., "Monday", "Friday").
  static String getDayName(DateTime date) => DateFormat('EEEE').format(date);

  /// Returns mixed-case month abbreviation (e.g., "Jan", "Feb")
  static String formatToMonthAbbr(DateTime date) {
    return DateFormat('MMM').format(date);
  }

  /// Adds specified number of days to the date.
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Subtracts specified number of days from the date.
  static DateTime subtractDays(DateTime date, int days) {
    return date.subtract(Duration(days: days));
  }

  /// Parses localized time string (e.g., 9:00 AM) to a DateTime object.
  static DateTime? parseTime(String timeStr) {
    try {
      return DateFormat.jm().parse(timeStr);
    } catch (e) {
      return null;
    }
  }

  /// Combines a date from one DateTime and time from another into a single DateTime.
  static DateTime combineDateAndTime(DateTime date, DateTime time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  /// Formats a DateTime to the API standard format.
  static String formatToApi(DateTime date) {
    return date.format(AppConstants.apiDateTimeFormat);
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

  /// Returns the start of the week (Monday) for a given date.
  static DateTime getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// Formats a week range for a given date (e.g., "Jan 5 - Jan 11, 2026")
  static String formatWeekRange(DateTime date) {
    final start = getStartOfWeek(date);
    final end = start.add(const Duration(days: 6));
    return "${DateFormat('MMM d').format(start)} - ${DateFormat('MMM d, yyyy').format(end)}";
  }

  /// Checks if the given date is today.
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  /// Checks if two dates are the same day (ignoring time).
  static bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
