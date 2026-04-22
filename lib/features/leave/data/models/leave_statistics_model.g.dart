// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveStatisticsModel _$LeaveStatisticsModelFromJson(
  Map<String, dynamic> json,
) => _LeaveStatisticsModel(
  success: json['success'] as bool,
  employee: json['employee'] as String,
  employeeName: json['employee_name'] as String,
  period: LeavePeriodModel.fromJson(json['period'] as Map<String, dynamic>),
  statistics: LeaveStatsModel.fromJson(
    json['statistics'] as Map<String, dynamic>,
  ),
  details: LeaveDetailsModel.fromJson(json['details'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LeaveStatisticsModelToJson(
  _LeaveStatisticsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'employee': instance.employee,
  'employee_name': instance.employeeName,
  'period': instance.period,
  'statistics': instance.statistics,
  'details': instance.details,
};

_LeavePeriodModel _$LeavePeriodModelFromJson(Map<String, dynamic> json) =>
    _LeavePeriodModel(
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
    );

Map<String, dynamic> _$LeavePeriodModelToJson(_LeavePeriodModel instance) =>
    <String, dynamic>{
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
    };

_LeaveStatsModel _$LeaveStatsModelFromJson(Map<String, dynamic> json) =>
    _LeaveStatsModel(
      appliedDays: (json['applied_days'] as num).toDouble(),
      approvedDays: (json['approved_days'] as num).toDouble(),
      pendingDays: (json['pending_days'] as num).toDouble(),
      cancelled_days: (json['cancelled_days'] as num).toDouble(),
      totalApplications: (json['total_applications'] as num).toInt(),
    );

Map<String, dynamic> _$LeaveStatsModelToJson(_LeaveStatsModel instance) =>
    <String, dynamic>{
      'applied_days': instance.appliedDays,
      'approved_days': instance.approvedDays,
      'pending_days': instance.pendingDays,
      'cancelled_days': instance.cancelled_days,
      'total_applications': instance.totalApplications,
    };

_LeaveDetailsModel _$LeaveDetailsModelFromJson(Map<String, dynamic> json) =>
    _LeaveDetailsModel(
      appliedLeaves: json['applied_leaves'] as List<dynamic>,
      approvedLeaves: json['approved_leaves'] as List<dynamic>,
      pendingLeaves: json['pending_leaves'] as List<dynamic>,
      cancelledLeaves: json['cancelled_leaves'] as List<dynamic>,
    );

Map<String, dynamic> _$LeaveDetailsModelToJson(_LeaveDetailsModel instance) =>
    <String, dynamic>{
      'applied_leaves': instance.appliedLeaves,
      'approved_leaves': instance.approvedLeaves,
      'pending_leaves': instance.pendingLeaves,
      'cancelled_leaves': instance.cancelledLeaves,
    };
