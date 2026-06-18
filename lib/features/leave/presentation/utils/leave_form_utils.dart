import 'package:flutter/material.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/constants/leave_constants.dart';

class LeaveFormUtils {
  LeaveFormUtils._();

  /// Returns true if the given date is a public holiday
  static bool isHoliday(DateTime date, List<DateTime> holidays) {
    final day = DateUtils.dateOnly(date);
    return holidays.any((h) => DateTimeUtils.isSameDay(h, day));
  }

  /// Returns true if the given date is a weekend or holiday.
  static bool isWeekendOrHoliday(DateTime date, List<DateTime> holidays) {
    return DateTimeUtils.isWeekend(date) || isHoliday(date, holidays);
  }

  /// Extracts holiday dates from leave statistics.
  static List<DateTime> extractHolidays(dynamic statistics) {
    if (statistics == null) return [];
    try {
      final appliedLeaves = statistics.details.appliedLeaves;
      return appliedLeaves
          .whereType<Map<String, dynamic>>()
          .where((e) => e['is_holiday'] == true)
          .map<DateTime>(
            (e) => DateUtils.dateOnly(DateTime.parse(e['date'] as String)),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Computes total leave days.
  static double computeTotalDays({
    DateTime? fromDate,
    DateTime? toDate,
    required bool isHalfDay,
  }) {
    if (fromDate == null || toDate == null) return 0;
    if (isHalfDay) return 0.5;
    return toDate.difference(fromDate).inDays.toDouble() + 1.0;
  }

  /// Checks if supporting documents are required.
  static bool requiresSupportingDocs({
    String? leaveType,
    required double totalDays,
  }) {
    return leaveType == LeaveTypes.sickLeave && totalDays > 2;
  }

  /// Returns the firstDate and lastDate bounds based on the selected leave type.
  static ({DateTime firstDate, DateTime lastDate}) getFromDateBounds(
    String? leaveType,
  ) {
    final today = DateUtils.dateOnly(DateTime.now());
    final isPastAllowed =
        leaveType == LeaveTypes.bereavementLeave ||
        leaveType == LeaveTypes.sickLeave;
    return (
      firstDate: isPastAllowed
          ? today.subtract(const Duration(days: 365))
          : today,
      lastDate: isPastAllowed ? today : today.add(const Duration(days: 365)),
    );
  }

  /// Applies date selection logic to determine new from/to/halfDay dates.
  static ({DateTime? fromDate, DateTime? toDate, DateTime? halfDayDate})
  applyDateSelectionRules({
    required bool isFromDate,
    required DateTime picked,
    required bool isHalfDay,
    DateTime? currentFromDate,
    DateTime? currentToDate,
    DateTime? currentHalfDayDate,
  }) {
    DateTime? fromDate = currentFromDate;
    DateTime? toDate = currentToDate;
    DateTime? halfDayDate = currentHalfDayDate;

    if (isFromDate) {
      fromDate = picked;
      if (isHalfDay) {
        toDate = picked;
        halfDayDate = picked;
      } else {
        toDate = null;
        halfDayDate = null;
      }
    } else {
      toDate = picked;
    }

    // Secondary constraints for half-day
    if (isHalfDay && fromDate != null && toDate != null) {
      if (fromDate == toDate) {
        halfDayDate = fromDate;
      } else if (halfDayDate != null) {
        if (halfDayDate.isBefore(fromDate) || halfDayDate.isAfter(toDate)) {
          halfDayDate = null;
        }
      }
    }

    return (fromDate: fromDate, toDate: toDate, halfDayDate: halfDayDate);
  }
}
