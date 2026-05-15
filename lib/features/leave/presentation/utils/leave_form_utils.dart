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
}
