// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveDetailsModel _$LeaveDetailsModelFromJson(Map<String, dynamic> json) =>
    _LeaveDetailsModel(
      leaveAllocation: (json['leave_allocation'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          LeaveAllocationModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
      leaveApprover: json['leave_approver'] as String,
      lwps: (json['lwps'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LeaveDetailsModelToJson(_LeaveDetailsModel instance) =>
    <String, dynamic>{
      'leave_allocation': instance.leaveAllocation,
      'leave_approver': instance.leaveApprover,
      'lwps': instance.lwps,
    };

_LeaveAllocationModel _$LeaveAllocationModelFromJson(
  Map<String, dynamic> json,
) => _LeaveAllocationModel(
  totalLeaves: (json['total_leaves'] as num).toDouble(),
  expiredLeaves: (json['expired_leaves'] as num).toInt(),
  leavesTaken: (json['leaves_taken'] as num).toDouble(),
  leavesPendingApproval: (json['leaves_pending_approval'] as num).toDouble(),
  remainingLeaves: (json['remaining_leaves'] as num).toDouble(),
);

Map<String, dynamic> _$LeaveAllocationModelToJson(
  _LeaveAllocationModel instance,
) => <String, dynamic>{
  'total_leaves': instance.totalLeaves,
  'expired_leaves': instance.expiredLeaves,
  'leaves_taken': instance.leavesTaken,
  'leaves_pending_approval': instance.leavesPendingApproval,
  'remaining_leaves': instance.remainingLeaves,
};
