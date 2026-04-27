// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardStatsModel _$DashboardStatsModelFromJson(Map<String, dynamic> json) =>
    _DashboardStatsModel(
      daysPresent: (json['days_present'] as num).toInt(),
      leaveBalance: (json['leave_balance'] as num).toDouble(),
      nextHoliday: json['next_holiday'] as String,
      nextHolidayDate: json['next_holiday_date'] as String,
    );

Map<String, dynamic> _$DashboardStatsModelToJson(
  _DashboardStatsModel instance,
) => <String, dynamic>{
  'days_present': instance.daysPresent,
  'leave_balance': instance.leaveBalance,
  'next_holiday': instance.nextHoliday,
  'next_holiday_date': instance.nextHolidayDate,
};
