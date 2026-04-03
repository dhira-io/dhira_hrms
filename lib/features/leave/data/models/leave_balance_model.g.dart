// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveBalanceModel _$LeaveBalanceModelFromJson(Map<String, dynamic> json) =>
    _LeaveBalanceModel(
      totalAllocated: (json['total_leaves'] as num).toInt(),
      used: (json['leaves_taken'] as num).toInt(),
      pending: (json['leaves_pending_approval'] as num).toInt(),
    );

Map<String, dynamic> _$LeaveBalanceModelToJson(_LeaveBalanceModel instance) =>
    <String, dynamic>{
      'total_leaves': instance.totalAllocated,
      'leaves_taken': instance.used,
      'leaves_pending_approval': instance.pending,
    };
