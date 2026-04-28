import '../../domain/entities/attendance_month_summary_entity.dart';
import '../../../../core/utils/string_utils.dart';

class AttendanceMonthSummaryModel extends AttendanceMonthSummaryEntity {
  const AttendanceMonthSummaryModel({
    required super.presentDays,
    required super.absentDays,
    required super.onLeaveDays,
    required super.holidays,
    required super.weekendDays,
    required super.totalWorkingDays,
    required super.attendancePercentage,
    required super.holidayDetails,
  });

  factory AttendanceMonthSummaryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceMonthSummaryModel(
      presentDays: (json['present_days'] as num).toDouble(),
      absentDays: (json['absent_days'] as num).toDouble(),
      onLeaveDays: (json['on_leave_days'] as num).toDouble(),
      holidays: (json['holidays'] as num).toInt(),
      weekendDays: (json['weekend_days'] as num).toInt(),
      totalWorkingDays: (json['total_working_days'] as num).toInt(),
      attendancePercentage: (json['attendance_percentage'] as num).toDouble(),
      holidayDetails: (json['holiday_details'] as List?)
              ?.map((e) => HolidayDetailModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'present_days': presentDays,
      'absent_days': absentDays,
      'on_leave_days': onLeaveDays,
      'holidays': holidays,
      'weekend_days': weekendDays,
      'total_working_days': totalWorkingDays,
      'attendance_percentage': attendancePercentage,
      'holiday_details':
          holidayDetails.map((e) => (e as HolidayDetailModel).toJson()).toList(),
    };
  }
}

class HolidayDetailModel extends HolidayDetailEntity {
  const HolidayDetailModel({
    required super.date,
    required super.name,
  });

  factory HolidayDetailModel.fromJson(Map<String, dynamic> json) {
    return HolidayDetailModel(
      date: json['date'] as String,
      name: StringUtils.stripHtml(json['name'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'name': name,
    };
  }
}
