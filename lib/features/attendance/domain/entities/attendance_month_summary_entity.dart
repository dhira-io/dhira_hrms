import 'package:equatable/equatable.dart';

class AttendanceMonthSummaryEntity extends Equatable {
  final double presentDays;
  final double absentDays;
  final double onLeaveDays;
  final int holidays;
  final int weekendDays;
  final int totalWorkingDays;
  final double attendancePercentage;
  final List<HolidayDetailEntity> holidayDetails;

  const AttendanceMonthSummaryEntity({
    required this.presentDays,
    required this.absentDays,
    required this.onLeaveDays,
    required this.holidays,
    required this.weekendDays,
    required this.totalWorkingDays,
    required this.attendancePercentage,
    required this.holidayDetails,
  });

  @override
  List<Object?> get props => [
        presentDays,
        absentDays,
        onLeaveDays,
        holidays,
        weekendDays,
        totalWorkingDays,
        attendancePercentage,
        holidayDetails,
      ];
}

class HolidayDetailEntity extends Equatable {
  final String date;
  final String name;

  const HolidayDetailEntity({
    required this.date,
    required this.name,
  });

  @override
  List<Object?> get props => [date, name];
}
