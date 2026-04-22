// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeamLeaveModel _$TeamLeaveModelFromJson(Map<String, dynamic> json) =>
    _TeamLeaveModel(
      employeeName: json['employee_name'] as String,
      leaveType: json['leave_type'] as String,
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
      employee: json['employee'] as String,
      designation: json['designation'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$TeamLeaveModelToJson(_TeamLeaveModel instance) =>
    <String, dynamic>{
      'employee_name': instance.employeeName,
      'leave_type': instance.leaveType,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'employee': instance.employee,
      'designation': instance.designation,
      'image': instance.image,
    };
