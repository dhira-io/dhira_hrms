// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveTypeModel _$LeaveTypeModelFromJson(Map<String, dynamic> json) =>
    _LeaveTypeModel(
      name: json['name'] as String,
      leaveTypeName: json['leave_type_name'] as String,
    );

Map<String, dynamic> _$LeaveTypeModelToJson(_LeaveTypeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'leave_type_name': instance.leaveTypeName,
    };
