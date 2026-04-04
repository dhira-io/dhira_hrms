// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  fullName: json['full_name'] as String,
  email: json['email'] as String,
  empId: json['name'] as String,
  department: json['department'] as String?,
  userImage: json['user_image'] as String?,
  approver: json['approver'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'name': instance.empId,
      'department': instance.department,
      'user_image': instance.userImage,
      'approver': instance.approver,
    };
