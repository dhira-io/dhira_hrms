import 'package:flutter/material.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/constants/leave_constants.dart';
import '../../domain/entities/leave_entities.dart';

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

  /// Returns the firstDate and lastDate bounds based on the selected leave type.
  static ({DateTime firstDate, DateTime lastDate}) getFromDateBounds(String? leaveType) {
    final today = DateUtils.dateOnly(DateTime.now());
    final isPastAllowed = leaveType == LeaveTypes.bereavementLeave ||
        leaveType == LeaveTypes.sickLeave;
    return (
      firstDate: isPastAllowed ? today.subtract(const Duration(days: 365)) : today,
      lastDate: isPastAllowed ? today : today.add(const Duration(days: 365)),
    );
  }

  /// Computes the initial date for the date picker based on current selection and bounds.
  static DateTime computeInitialDate({
    DateTime? currentDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    final today = DateUtils.dateOnly(DateTime.now());
    if (currentDate != null &&
        !currentDate.isBefore(firstDate) &&
        !currentDate.isAfter(lastDate)) {
      return currentDate;
    }
    if (today.isBefore(firstDate)) return firstDate;
    if (today.isAfter(lastDate)) return lastDate;
    return today;
  }

  /// Computes the date picker bounds for the "To Date" field.
  static ({DateTime firstDate, DateTime lastDate}) getToDateBounds(DateTime fromDate) {
    final today = DateUtils.dateOnly(DateTime.now());
    return (
      firstDate: fromDate,
      lastDate: today.add(const Duration(days: 365)),
    );
  }

  /// Computes initial date for the "To Date" picker.
  static DateTime computeToDateInitial({
    DateTime? toDate,
    required DateTime fromDate,
  }) {
    return (toDate != null && !toDate.isBefore(fromDate)) ? toDate : fromDate;
  }

  /// Applies date selection rules and returns updated state values.
  /// Handles from/to date logic and half-day date constraints.
  static ({
    DateTime? fromDate,
    DateTime? toDate,
    DateTime? halfDayDate,
  }) applyDateSelectionRules({
    required bool isFromDate,
    required DateTime picked,
    required bool isHalfDay,
    required DateTime? currentFromDate,
    required DateTime? currentToDate,
    required DateTime? currentHalfDayDate,
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

    // Handle half-day date constraint
    if (isHalfDay && fromDate != null && toDate != null) {
      if (fromDate == toDate) {
        halfDayDate = fromDate;
      } else if (halfDayDate != null) {
        if (halfDayDate.isBefore(fromDate) || halfDayDate.isAfter(toDate)) {
          halfDayDate = null;
        }
      }
    }

    return (
      fromDate: fromDate,
      toDate: toDate,
      halfDayDate: halfDayDate,
    );
  }

  /// Extracts holiday dates from leave statistics entity.
  static List<DateTime> extractHolidays(LeaveStatisticsEntity? statistics) {
    if (statistics == null) return <DateTime>[];
    return statistics.details.appliedLeaves
        .whereType<Map<String, dynamic>>()
        .where((e) => e['is_holiday'] == true)
        .map<DateTime>((e) => DateUtils.dateOnly(DateTime.parse(e['date'] as String)))
        .toList();
  }

  /// Computes total leave days based on date range and half-day flag.
  static double computeTotalDays({
    required DateTime? fromDate,
    required DateTime? toDate,
    required bool isHalfDay,
  }) {
    if (fromDate == null || toDate == null) return 0;
    if (isHalfDay) return 0.5;
    return toDate.difference(fromDate).inDays.toDouble() + 1.0;
  }

  /// Returns whether supporting docs are required (sick leave > 2 days).
  static bool requiresSupportingDocs({
    required String? leaveType,
    required double totalDays,
  }) {
    return leaveType == LeaveTypes.sickLeave && totalDays > 2;
  }
}
