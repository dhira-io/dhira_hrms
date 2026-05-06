// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamLeaveModelImpl _$$TeamLeaveModelImplFromJson(Map<String, dynamic> json) =>
    _$TeamLeaveModelImpl(
      employee: json['employee'] as Map<String, dynamic>,
      leaveType: json['leave_type'] as String,
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
    );

Map<String, dynamic> _$$TeamLeaveModelImplToJson(
  _$TeamLeaveModelImpl instance,
) => <String, dynamic>{
  'employee': instance.employee,
  'leave_type': instance.leaveType,
  'from_date': instance.fromDate,
  'to_date': instance.toDate,
};
