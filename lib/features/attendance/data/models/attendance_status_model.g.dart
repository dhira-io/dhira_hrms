// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceStatusModel _$AttendanceStatusModelFromJson(
  Map<String, dynamic> json,
) => _AttendanceStatusModel(
  success: json['success'] as bool,
  punchedIn: json['punched_in'] as bool,
  onBreak: json['on_break'] as bool,
  dayEnded: json['day_ended'] as bool,
  firstIn: json['first_in'] as String?,
  lastOut: json['last_out'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$AttendanceStatusModelToJson(
  _AttendanceStatusModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'punched_in': instance.punchedIn,
  'on_break': instance.onBreak,
  'day_ended': instance.dayEnded,
  'first_in': instance.firstIn,
  'last_out': instance.lastOut,
  'message': instance.message,
};
