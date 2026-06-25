import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

/// Modern DateTime extensions for intuitive method chaining
extension DateTimeExtensions on DateTime {
  /// Formats the DateTime into a dynamic custom string. Defaults to 'yyyy-MM-dd'.
  String format([
    String pattern = DateTimeUtils.patternYYYYMMDD,
    String? locale,
  ]) {
    return DateFormat(pattern, locale).format(this);
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

  // Common Date-Time formatting patterns
  static const String patternYYYYMMDD = 'yyyy-MM-dd';
  static const String patternDDMMYYYY = 'dd-MM-yyyy';
  static const String patternMonthYear = 'MMMM yyyy';
  static const String patternDayMonth = dateFormatDayMonth;
  static const String patternDayMonthYear = 'dd MMM yyyy';
  static const String patternMonthYearAbbr = 'MMM yyyy';
  static const String patternDayMonthYearShortSlash = 'dd/MM/yy';

  // Named date format constants
  static const String dateWithDay = 'EEEE, dd-MM-yyyy';
  static const String dateFormatFull = 'EEEE, MMMM d, yyyy';
  static const String dateFormatDayMonth = 'dd MMM';
  static const String dateFormatShort = 'dd-MM-yy';
  static const String dateFormatYear = 'yyyy';
  static const String dateFormatAbbrMonthDay = 'MMM dd';
  static const String dateFormatDayMonthKey = 'EEEE MMM d, yyyy';
  static const String dateFormatMonthOnly = 'MMMM';
  static const String patternAbbrMonthDay = 'MMM d';
  static const String patternAbbrMonthDayYear = 'MMM d, yyyy';
  static const String dateFormatDayNameMonth = 'dd EEEE, MMMM';

  /// Formats date to 'yyyy-MM-dd' (e.g., 2023-10-25)
  static String formatToYMD(DateTime date) {
    return date.format(patternYYYYMMDD);
  }

  /// Formats date to 'MMMM' (e.g., October)
  static String formatToMonthName(DateTime date) {
    return date.format(dateFormatMonthOnly);
  }

  /// Formats date to 'dd-MM-yy' (e.g., 01-05-26)
  static String formatToDMYShort(DateTime date) {
    return date.format('dd-MM-yy');
  }

  /// Formats a string date to 'MMM d, yyyy' (e.g., Oct 25, 2023)
  static String formatDateAbbr(String? date) {
    if (date == null || date.isEmpty) return "";
    return DateTimeUtils.formatDateString(date, pattern: 'MMM d, yyyy', fallback: date);
  }

  /// Formats a string date/time to localized time (e.g., 9:00 AM)
  static String formatTimeStr(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) return "N/A";
    try {
      final DateTime dt = DateTime.parse(dateTimeStr);
      return dt.toTime;
    } catch (e) {
      return "N/A";
    }
  }

  /// Checks if a value represents a half day
  static bool isHalfDay(dynamic value) {
    if (value == null) return false;
    return value == 1 ||
        value == true ||
        value.toString() == "1" ||
        value.toString().toLowerCase() == "true";
  }

  /// Formats days to string (removes decimal if .0)
  static String formatDays(dynamic days) {
    if (days == null) return "0";
    double val = double.tryParse(days.toString()) ?? 0.0;
    return val == val.toInt() ? val.toInt().toString() : val.toString();
  }

  /// Formats date to 'dd MMM, yyyy' (e.g., 25 Oct, 2023)
  static String formatToDMY(DateTime date) {
    return date.format('dd MMM, yyyy');
  }

  /// Formats date to 'EEEE, MMMM d, yyyy' (e.g., Monday, October 25, 2023)
  static String formatToFullDate(DateTime date) {
    return date.format(dateFormatFull);
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
  static String todayDate({String pattern = DateTimeUtils.patternYYYYMMDD}) {
    return DateTime.now().format(pattern);
  }

  static String getFirstDayOfMonth({String pattern = dateFormatShort}) {
    return DateTime.now().firstDayOfMonth.format(pattern);
  }

  /// Returns the first day of the given month.
  static DateTime getFirstDayOfMonthFromDate(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static String getLastDayOfMonth({String pattern = dateFormatShort}) {
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
  /// Uses [l10n] for localized strings.
  static String getGreetingMessage({
    String? prefix,
    required AppLocalizations l10n,
  }) {
    final hour = TimeOfDay.now().hour;

    String greeting;
    if (hour >= 5 && hour < 12) {
      greeting = l10n.goodMorning;
    } else if (hour >= 12 && hour < 17) {
      greeting = l10n.goodAfternoon;
    } else if (hour >= 17 && hour < 21) {
      greeting = l10n.goodEvening;
    } else {
      greeting = l10n.goodNight;
    }

    if (prefix == null || prefix.isEmpty) {
      return greeting;
    }
    return '$prefix $greeting';
  }

  /// Formats a Duration to HH:mm:ss string
  static String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  /// Formats a given DateTime into a custom string using the provided pattern.
  static String formatDate(
    DateTime date, {
    String pattern = DateTimeUtils.patternYYYYMMDD,
    String? locale,
  }) {
    return date.format(pattern, locale);
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
      if (from == to) {
        return "${DateFormat(dateFormatAbbrMonthDay).format(fromDate)}, ${DateFormat(dateFormatYear).format(fromDate)}";
      } else {
        return "${DateFormat(dateFormatAbbrMonthDay).format(fromDate)} - ${DateFormat(dateFormatAbbrMonthDay).format(toDate)}, ${DateFormat(dateFormatYear).format(toDate)}";
      }
    } catch (_) {
      return "$from - $to";
    }
  }

  /// Formats a holiday date string to show only day and month (e.g., "26 Jan").
  static String formatHolidayDate(String dateString) {
    final parsedDate = DateTime.tryParse(dateString);
    if (parsedDate == null) return dateString;
    return DateFormat(patternDayMonth).format(parsedDate);
  }

  /// Returns the day number (e.g., "01", "25").
  static String getDayNumber(DateTime date) => DateFormat('dd').format(date);

  /// Returns the month abbreviation in uppercase (e.g., "JAN", "OCT").
  static String getMonthAbbr(DateTime date) =>
      DateFormat('MMM').format(date).toUpperCase();

  /// Returns the full day name (e.g., "Monday", "Friday").
  static String getDayName(DateTime date) => DateFormat('EEEE').format(date);

  /// Formats date to 'd MMM · yyyy' (e.g., 5 May · 2026)
  static String formatWithDotSeparator(DateTime date) =>
      DateFormat('d MMM · yyyy').format(date);

  /// Returns mixed-case month abbreviation (e.g., "Jan", "Feb")
  static String formatToMonthAbbr(DateTime date, [String? locale]) {
    return DateFormat('MMM', locale).format(date);
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

  /// Generates a machine-readable key for the Timesheet Week.
  /// This is used for internal grouping and should remain consistent (English/Fixed).
  static String getTimesheetWeekStorageKey(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    final weekNumber = ((monday.day - 1) / 7).floor() + 1;

    final monthStr = DateFormat('MMM', 'en_US').format(monday);
    final mondayDay = monday.day;
    final sundayDay = monday.add(const Duration(days: 6)).day;
    final year = monday.year;

    return "Week $weekNumber $monthStr $mondayDay - $monthStr $sundayDay, $year";
  }

  /// Generates a localized label for the Timesheet Week.
  static String getTimesheetWeekLabel(
    DateTime date, {
    required AppLocalizations l10n,
  }) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    final sunday = monday.add(const Duration(days: 6));

    final weekNumber = _getWeekOfMonth(date);
    final monthStr = DateFormat('MMM').format(monday);
    final mondayDay = monday.day;
    final sundayDay = sunday.day;
    final year = monday.year;

    final weekPrefix = l10n.weekLabel(weekNumber);
    return "$weekPrefix $monthStr $mondayDay - $monthStr $sundayDay, $year";
  }

  static int _getWeekOfMonth(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    return ((monday.day - 1) / 7).floor() + 1;
  }

  /// Generates the key for the Timesheet Day (e.g., "Tuesday Jan 6, 2026")
  static String getTimesheetDayKey(DateTime date) {
    return DateFormat(dateFormatDayMonthKey).format(date);
  }

  /// Returns the start of the week (Monday) for a given date.
  static DateTime getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// Formats a week range for a given date (e.g., "Jan 5 - Jan 11, 2026")
  /// Uses [l10n] for localized range formatting.
  static String formatWeekRange(
    DateTime date, {
    required AppLocalizations l10n,
  }) {
    final start = getStartOfWeek(date);
    final end = start.add(const Duration(days: 6));
    final from = DateFormat('MMM d').format(start);
    final to = DateFormat('MMM d, yyyy').format(end);
    return l10n.dateToDateRange(from, to);
  }

  /// Checks if the given date is today.
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  /// Checks if two dates are the same day (ignoring time).
  static bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  /// Checks if the given date is in the future compared to today (ignoring time).
  static bool isFutureDay(DateTime date) {
    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    return dateOnly.isAfter(todayDateOnly);
  }

  /// Returns true if the given date is a weekend (Sat/Sun).
  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  /// Safely formats a date string into a custom pattern.
  static String formatDateString(
    String? dateStr, {
    String pattern = AppConstants.dateFormatDefault,
    String fallback = '—',
    String? locale,
  }) {
    if (dateStr == null || dateStr.isEmpty) return fallback;
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat(pattern, locale).format(date);
    } catch (e) {
      return dateStr;
    }
  }

  static int getDominantMonthOfWeek(DateTime weekStart) {
    int firstMonthCount = 0;
    int secondMonthCount = 0;

    final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));
    final firstMonth = days.first.month;

    for (final day in days) {
      final isWorkingDay =
          day.weekday != DateTime.saturday && day.weekday != DateTime.sunday;

      if (!isWorkingDay) continue;

      if (day.month == firstMonth) {
        firstMonthCount++;
      } else {
        secondMonthCount++;
      }
    }

    return (secondMonthCount > firstMonthCount) ? days.last.month : firstMonth;
  }

  static int getDominantYearOfWeek(DateTime weekStart) {
    int firstMonthCount = 0;
    int secondMonthCount = 0;

    final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));

    final firstMonth = days.first.month;
    final firstYear = days.first.year;

    int secondYear = firstYear;

    for (final day in days) {
      final isWorkingDay =
          day.weekday != DateTime.saturday && day.weekday != DateTime.sunday;

      if (!isWorkingDay) continue;

      if (day.month == firstMonth) {
        firstMonthCount++;
      } else {
        secondMonthCount++;
        secondYear = day.year;
      }
    }

    return (secondMonthCount > firstMonthCount) ? secondYear : firstYear;
  }

  static bool isWeekAllowed(DateTime weekStart) {
    final now = DateTime.now();

    final minDate = DateTime(now.year, now.month - 3, 1);
    final maxDate = DateTime(now.year, now.month + 2, 0);

    final inRange =
        weekStart.isAfter(minDate.subtract(const Duration(days: 1))) &&
        weekStart.isBefore(maxDate.add(const Duration(days: 1)));

    if (!inRange) return false;

    final dominantMonth = getDominantMonthOfWeek(weekStart);

    final allowedMonths = [
      now.month - 3,
      now.month - 2,
      now.month - 1,
      now.month,
      now.month + 1,
    ];

    return allowedMonths.contains(dominantMonth);
  }

  /// Formats the time into a friendly string like "2 minutes ago" or "Yesterday"
  /// Uses [l10n] for localized strings.
  static String formatTimeAgo(DateTime time, {required AppLocalizations l10n}) {
    final now = DateTime.now();
    final difference = now.difference(time);

    // Stability: Handle future dates or extreme clock skew
    if (difference.isNegative) {
      return l10n.justNow;
    }

    if (difference.inSeconds < 60) {
      return l10n.justNow;
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return l10n.minutesAgo(minutes);
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return l10n.hoursAgo(hours);
    } else if (difference.inDays == 1 ||
        (difference.inDays == 0 && !isSameDay(time, now))) {
      return l10n.yesterday;
    } else if (difference.inDays < 7) {
      return l10n.daysAgo(difference.inDays);
    } else {
      return DateFormat(AppConstants.dateFormatDayMonthYear).format(time);
    }
  }

  /// Calculates the duration between two date strings and returns a friendly period (e.g., "1 year 2 months")
  static String calculateDuration(String fromStr, String toStr) {
    DateTime? parseDate(String dateStr) {
      if (dateStr.isEmpty) return null;
      try {
        final parsed = DateTime.tryParse(dateStr);
        if (parsed != null) return parsed;

        final normalized = dateStr.replaceAll('/', '-');
        final parts = normalized.split('-');
        if (parts.length == 3) {
          if (parts[0].length == 4) {
            final year = int.parse(parts[0]);
            final month = int.parse(parts[1]);
            final day = int.parse(parts[2]);
            return DateTime(year, month, day);
          } else {
            final day = int.parse(parts[0]);
            final month = int.parse(parts[1]);
            final year = int.parse(parts[2]);
            return DateTime(year, month, day);
          }
        }
      } catch (_) {}
      return null;
    }

    final fromDate = parseDate(fromStr);
    final toDate = parseDate(toStr);
    if (fromDate == null || toDate == null) return "";

    var start = fromDate;
    var end = toDate;
    if (start.isAfter(end)) {
      start = toDate;
      end = fromDate;
    }

    int years = end.year - start.year;
    int months = end.month - start.month;
    int days = end.day - start.day;

    if (days < 0) {
      months -= 1;
      final previousMonth = DateTime(end.year, end.month, 0);
      days += previousMonth.day;
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }

    final List<String> parts = [];
    if (years > 0) {
      parts.add(years == 1 ? "1 year" : "$years years");
    }
    if (months > 0) {
      parts.add(months == 1 ? "1 month" : "$months months");
    }
    if (parts.isEmpty) {
      if (days > 0) {
        parts.add(days == 1 ? "1 day" : "$days days");
      } else {
        parts.add("0 months");
      }
    }
    return parts.join(' ');
  }

  /// Returns the ISO 8601 week number for a given date.
  static int getWeekOfYear(DateTime date) {
    final dayUtc = DateTime.utc(date.year, date.month, date.day);
    final weekday = dayUtc.weekday;
    final thursday = dayUtc.add(Duration(days: 4 - weekday));
    final firstDayOfYear = DateTime.utc(thursday.year, 1, 1);
    final difference = thursday.difference(firstDayOfYear);
    return (difference.inDays / 7).floor() + 1;
  }

  /// Formats the timesheet week range (e.g. "Jun 1 – 7" or "Jun 29 – Jul 5")
  static String formatTimesheetWeekRange(DateTime date) {
    final monday = getStartOfWeek(date);
    final sunday = monday.add(const Duration(days: 6));

    if (monday.month == sunday.month) {
      final monthStr = DateFormat('MMM').format(monday);
      return "$monthStr ${monday.day} – ${sunday.day}";
    } else {
      final mondayMonthStr = DateFormat('MMM').format(monday);
      final sundayMonthStr = DateFormat('MMM').format(sunday);
      return "$mondayMonthStr ${monday.day} – $sundayMonthStr ${sunday.day}";
    }
  }

  /// Checks if a string is in a standard ISO 8601 format (YYYY-MM-DDTHH:mm:ss...)
  static bool isISOFormat(String input) {
    if (input.isEmpty) return false;
    // Basic check for T delimiter or standard format
    return input.contains('T') ||
        RegExp(r'^\d{4}-\d{2}-\d{2}T').hasMatch(input);
  }
}
