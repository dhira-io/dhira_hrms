import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';
import 'package:dhira_hrms/core/utils/string_utils.dart';

part 'calendar_model.freezed.dart';
part 'calendar_model.g.dart';

@freezed
class CalendarSummaryModel with _$CalendarSummaryModel {
  @JsonSerializable(explicitToJson: true)
  const factory CalendarSummaryModel({
    @JsonKey(name: 'present_days') required double presentDays,
    @JsonKey(name: 'absent_days') required double absentDays,
    @JsonKey(name: 'on_leave_days') required double onLeaveDays,
    required int holidays,
    @JsonKey(name: 'weekend_days') required int weekendDays,
    @JsonKey(name: 'total_working_days') required int totalWorkingDays,
    @JsonKey(name: 'attendance_percentage') required double attendancePercentage,
    @JsonKey(name: 'holiday_details') required List<CalendarHolidayDetailModel> holidayDetails,
  }) = _CalendarSummaryModel;

  const CalendarSummaryModel._();

  factory CalendarSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarSummaryModelFromJson(json);

  CalendarSummaryEntity toEntity() {
    return CalendarSummaryEntity(
      presentDays: presentDays,
      absentDays: absentDays,
      onLeaveDays: onLeaveDays,
      holidays: holidays,
      weekendDays: weekendDays,
      totalWorkingDays: totalWorkingDays,
      attendancePercentage: attendancePercentage,
      holidayDetails: holidayDetails.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
class CalendarHolidayDetailModel with _$CalendarHolidayDetailModel {
  const factory CalendarHolidayDetailModel({
    required String date,
    required String name,
  }) = _CalendarHolidayDetailModel;

  const CalendarHolidayDetailModel._();

  factory CalendarHolidayDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarHolidayDetailModelFromJson(json);

  CalendarHolidayDetailEntity toEntity() {
    return CalendarHolidayDetailEntity(
      date: date,
      name: StringUtils.stripHtml(name),
    );
  }
}
