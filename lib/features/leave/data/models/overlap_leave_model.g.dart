// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlap_leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OverlapLeaveModelImpl _$$OverlapLeaveModelImplFromJson(
  Map<String, dynamic> json,
) => _$OverlapLeaveModelImpl(
  id: json['id'] as String,
  employee: OverlapEmployeeModel.fromJson(
    json['employee'] as Map<String, dynamic>,
  ),
  sharedProjects: (json['shared_projects'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  leaveType: json['leave_type'] as String,
  fromDate: json['from_date'] as String,
  toDate: json['to_date'] as String,
  days: (json['days'] as num).toDouble(),
  status: json['status'] as String,
  description: json['description'] as String?,
  posting_date: json['posting_date'] as String?,
  modified: json['modified'] as String?,
);

Map<String, dynamic> _$$OverlapLeaveModelImplToJson(
  _$OverlapLeaveModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'employee': instance.employee,
  'shared_projects': instance.sharedProjects,
  'leave_type': instance.leaveType,
  'from_date': instance.fromDate,
  'to_date': instance.toDate,
  'days': instance.days,
  'status': instance.status,
  'description': instance.description,
  'posting_date': instance.posting_date,
  'modified': instance.modified,
};

_$OverlapEmployeeModelImpl _$$OverlapEmployeeModelImplFromJson(
  Map<String, dynamic> json,
) => _$OverlapEmployeeModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  designation: json['designation'] as String,
  image: json['image'] as String?,
  department: json['department'] as String?,
);

Map<String, dynamic> _$$OverlapEmployeeModelImplToJson(
  _$OverlapEmployeeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'designation': instance.designation,
  'image': instance.image,
  'department': instance.department,
};
