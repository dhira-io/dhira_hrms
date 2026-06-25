import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_entity.freezed.dart';

@freezed
class CalendarSummaryEntity with _$CalendarSummaryEntity {
  const factory CalendarSummaryEntity({
    required double presentDays,
    required double absentDays,
    required double onLeaveDays,
    required int holidays,
    required int weekendDays,
    required int totalWorkingDays,
    required double attendancePercentage,
    required List<CalendarHolidayDetailEntity> holidayDetails,
    double? totalWorkingHours,
  }) = _CalendarSummaryEntity;
}

@freezed
class CalendarHolidayDetailEntity with _$CalendarHolidayDetailEntity {
  const factory CalendarHolidayDetailEntity({
    required String date,
    required String name,
  }) = _CalendarHolidayDetailEntity;
}
