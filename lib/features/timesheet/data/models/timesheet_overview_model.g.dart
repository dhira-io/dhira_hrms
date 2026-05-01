// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet_overview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimesheetOverviewModel _$TimesheetOverviewModelFromJson(
  Map<String, dynamic> json,
) => _TimesheetOverviewModel(
  filled: (json['filled'] as num?)?.toInt() ?? 0,
  pendingApproval: (json['pending_approval'] as num?)?.toInt() ?? 0,
  correctionNeeded: (json['correction_needed'] as num?)?.toInt() ?? 0,
  upcomingToSubmit: (json['upcoming_to_submit'] as num?)?.toInt() ?? 0,
  approved: (json['approved'] as num?)?.toInt() ?? 0,
  totalWeeks: (json['total_weeks'] as num?)?.toInt() ?? 0,
  weekMeta: json['week_meta'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$TimesheetOverviewModelToJson(
  _TimesheetOverviewModel instance,
) => <String, dynamic>{
  'filled': instance.filled,
  'pending_approval': instance.pendingApproval,
  'correction_needed': instance.correctionNeeded,
  'upcoming_to_submit': instance.upcomingToSubmit,
  'approved': instance.approved,
  'total_weeks': instance.totalWeeks,
  'week_meta': instance.weekMeta,
};
