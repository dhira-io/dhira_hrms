// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveBalanceModel _$LeaveBalanceModelFromJson(Map<String, dynamic> json) =>
    _LeaveBalanceModel(
      totalAllocated: json['total_leaves'] as num,
      used: json['leaves_taken'] as num,
      pending: json['leaves_pending_approval'] as num,
      approved: json['approved'] as num? ?? 0,
      rejected: json['rejected'] as num? ?? 0,
      applied: json['applied'] as num? ?? 0,
      details:
          (json['details'] as List<dynamic>?)
              ?.map(
                (e) => DetailedBalanceModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LeaveBalanceModelToJson(_LeaveBalanceModel instance) =>
    <String, dynamic>{
      'total_leaves': instance.totalAllocated,
      'leaves_taken': instance.used,
      'leaves_pending_approval': instance.pending,
      'approved': instance.approved,
      'rejected': instance.rejected,
      'applied': instance.applied,
      'details': instance.details,
    };

_DetailedBalanceModel _$DetailedBalanceModelFromJson(
  Map<String, dynamic> json,
) => _DetailedBalanceModel(
  leaveType: json['leaveType'] as String,
  allocated: (json['allocated'] as num).toDouble(),
  used: (json['used'] as num).toDouble(),
  pending: (json['pending'] as num).toDouble(),
);

Map<String, dynamic> _$DetailedBalanceModelToJson(
  _DetailedBalanceModel instance,
) => <String, dynamic>{
  'leaveType': instance.leaveType,
  'allocated': instance.allocated,
  'used': instance.used,
  'pending': instance.pending,
};
