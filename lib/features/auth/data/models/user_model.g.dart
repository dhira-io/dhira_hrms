// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  employeeName: json['employee_name'] as String?,
  fullName: json['full_name'] as String?,
  email: json['email'] as String?,
  empId: json['name'] as String,
  department: json['custom_organization_department'] as String?,
  userImage: json['user_image'] as String?,
  approver: json['leave_approver'] as String?,
  gender: json['gender'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'employee_name': instance.employeeName,
      'full_name': instance.fullName,
      'email': instance.email,
      'name': instance.empId,
      'custom_organization_department': instance.department,
      'user_image': instance.userImage,
      'leave_approver': instance.approver,
      'gender': instance.gender,
    };
