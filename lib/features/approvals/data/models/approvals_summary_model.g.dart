// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approvals_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApprovalsSummaryModelImpl _$$ApprovalsSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$ApprovalsSummaryModelImpl(
  leaveApprovalsPending: (json['leave_approvals_pending'] as num).toInt(),
  attendanceRegularizationPending:
      (json['attendance_regularization_pending'] as num).toInt(),
  timesheetApprovalsPending: (json['timesheet_approvals_pending'] as num)
      .toInt(),
  compensatoryLeavePending: (json['compensatory_leave_pending'] as num).toInt(),
  totalAllPending: (json['total_all_pending'] as num).toInt(),
  timestamp: json['timestamp'] as String?,
);

Map<String, dynamic> _$$ApprovalsSummaryModelImplToJson(
  _$ApprovalsSummaryModelImpl instance,
) => <String, dynamic>{
  'leave_approvals_pending': instance.leaveApprovalsPending,
  'attendance_regularization_pending': instance.attendanceRegularizationPending,
  'timesheet_approvals_pending': instance.timesheetApprovalsPending,
  'compensatory_leave_pending': instance.compensatoryLeavePending,
  'total_all_pending': instance.totalAllPending,
  'timestamp': instance.timestamp,
};

_$ApprovalsSummaryResponseImpl _$$ApprovalsSummaryResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ApprovalsSummaryResponseImpl(
  success: json['success'] as bool,
  data: ApprovalsSummaryModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ApprovalsSummaryResponseImplToJson(
  _$ApprovalsSummaryResponseImpl instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};
