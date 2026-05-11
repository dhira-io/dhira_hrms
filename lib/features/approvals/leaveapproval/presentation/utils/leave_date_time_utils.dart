import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/constants/leave_constants.dart';

class LeaveDateTimeUtils {
  LeaveDateTimeUtils._();

  static double calculateTotalDays(DateTime? fromDate, DateTime? toDate, bool isHalfDay) {
    if (fromDate == null || toDate == null) return 0;
    if (isHalfDay) return 0.5;
    return toDate.difference(fromDate).inDays.toDouble() + 1.0;
  }

  static bool isSickLeaveDateInvalid(DateTime? fromDate, DateTime? toDate, bool isSickLeave) {
    if (!isSickLeave) return false;
    final today = DateUtils.dateOnly(DateTime.now());
    return (fromDate != null && fromDate.isAfter(today)) ||
        (toDate != null && toDate.isAfter(today));
  }

  static ({DateTime firstDate, DateTime lastDate}) getFromDateBounds(String? leaveType) {
    final today = DateUtils.dateOnly(DateTime.now());
    final isSickLeave = leaveType == LeaveTypes.sickLeave;
    final isPastAllowed = leaveType == LeaveTypes.bereavementLeave || isSickLeave;
    
    return (
      firstDate: isPastAllowed ? today.subtract(const Duration(days: 365)) : today,
      lastDate: isPastAllowed ? today : today.add(const Duration(days: 365)),
    );
  }

  static DateTime getLastDate(bool isSickLeave) {
    final today = DateUtils.dateOnly(DateTime.now());
    return isSickLeave 
          ? today
          : today.add(const Duration(days: 365));
  }

  static bool isWeekend(DateTime date) =>
      date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

  static bool isHoliday(DateTime date, List<DateTime> holidays) {
    final day = DateUtils.dateOnly(date);
    return holidays.any((h) => DateUtils.isSameDay(h, day));
  }
}
