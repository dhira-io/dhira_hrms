// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_work_durations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceWorkDurationsModel _$AttendanceWorkDurationsModelFromJson(
  Map<String, dynamic> json,
) => _AttendanceWorkDurationsModel(
  today: WorkDurationInfo.fromJson(json['today'] as Map<String, dynamic>),
  week: WorkDurationInfo.fromJson(json['week'] as Map<String, dynamic>),
  month: WorkDurationInfo.fromJson(json['month'] as Map<String, dynamic>),
  onBreak: json['on_break'] as bool,
  punchedIn: json['punched_in'] as bool,
);

Map<String, dynamic> _$AttendanceWorkDurationsModelToJson(
  _AttendanceWorkDurationsModel instance,
) => <String, dynamic>{
  'today': instance.today,
  'week': instance.week,
  'month': instance.month,
  'on_break': instance.onBreak,
  'punched_in': instance.punchedIn,
};

_WorkDurationInfo _$WorkDurationInfoFromJson(Map<String, dynamic> json) =>
    _WorkDurationInfo(
      hours: (json['hours'] as num).toDouble(),
      label: json['label'] as String,
    );

Map<String, dynamic> _$WorkDurationInfoToJson(_WorkDurationInfo instance) =>
    <String, dynamic>{'hours': instance.hours, 'label': instance.label};
