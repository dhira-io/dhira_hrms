// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approvals_access_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApprovalsAccessModel _$ApprovalsAccessModelFromJson(
  Map<String, dynamic> json,
) => _ApprovalsAccessModel(
  success: json['success'] as bool,
  canAccess: json['can_access'] as bool,
);

Map<String, dynamic> _$ApprovalsAccessModelToJson(
  _ApprovalsAccessModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'can_access': instance.canAccess,
};
