// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApprovalRequestModel _$ApprovalRequestModelFromJson(
  Map<String, dynamic> json,
) => _ApprovalRequestModel(
  name: json['name'] as String,
  employeeName: json['employee_name'] as String,
  employeeRole: json['designation'] as String?,
  profileImage: json['image'] as String?,
  leaveType: json['leave_type'] as String?,
  attendanceDate: json['attendance_date'] as String?,
  fromDate: json['from_date'] as String?,
  toDate: json['to_date'] as String?,
  duration: (json['total_leave_days'] as num?)?.toDouble(),
  status: json['status'] as String,
);

Map<String, dynamic> _$ApprovalRequestModelToJson(
  _ApprovalRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'employee_name': instance.employeeName,
  'designation': instance.employeeRole,
  'image': instance.profileImage,
  'leave_type': instance.leaveType,
  'attendance_date': instance.attendanceDate,
  'from_date': instance.fromDate,
  'to_date': instance.toDate,
  'total_leave_days': instance.duration,
  'status': instance.status,
};
