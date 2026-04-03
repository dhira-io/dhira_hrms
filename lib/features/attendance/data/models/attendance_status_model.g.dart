// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceStatusModel _$AttendanceStatusModelFromJson(
  Map<String, dynamic> json,
) => _AttendanceStatusModel(
  isPunchedIn: json['is_punched_in'] as bool,
  statusText: json['status_text'] as String,
);

Map<String, dynamic> _$AttendanceStatusModelToJson(
  _AttendanceStatusModel instance,
) => <String, dynamic>{
  'is_punched_in': instance.isPunchedIn,
  'status_text': instance.statusText,
};
