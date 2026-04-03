// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceLogModel _$AttendanceLogModelFromJson(Map<String, dynamic> json) =>
    _AttendanceLogModel(
      date: json['attendance_date'] as String,
      dayName: json['day_name'] as String,
      inTime: json['in_time'] as String,
      outTime: json['out_time'] as String?,
      workingHours: (json['working_hours'] as num?)?.toDouble(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$AttendanceLogModelToJson(_AttendanceLogModel instance) =>
    <String, dynamic>{
      'attendance_date': instance.date,
      'day_name': instance.dayName,
      'in_time': instance.inTime,
      'out_time': instance.outTime,
      'working_hours': instance.workingHours,
      'status': instance.status,
    };
