// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceLogModel _$AttendanceLogModelFromJson(Map<String, dynamic> json) =>
    _AttendanceLogModel(
      date: json['date'] as String,
      dayName: json['day_name'] as String,
      monthAbbr: json['month_abbr'] as String,
      dayNumber: json['day_number'] as String,
      status: json['status'] as String,
      inTime: json['in_time'] as String?,
      outTime: json['out_time'] as String?,
      workingHours: json['working_hours'] as String?,
      label: json['label'] as String,
    );

Map<String, dynamic> _$AttendanceLogModelToJson(_AttendanceLogModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'day_name': instance.dayName,
      'month_abbr': instance.monthAbbr,
      'day_number': instance.dayNumber,
      'status': instance.status,
      'in_time': instance.inTime,
      'out_time': instance.outTime,
      'working_hours': instance.workingHours,
      'label': instance.label,
    };
