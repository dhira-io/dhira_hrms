// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_regularization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceRegularizationModel _$AttendanceRegularizationModelFromJson(
  Map<String, dynamic> json,
) => _AttendanceRegularizationModel(
  docStatus:
      (json['docstatus'] as num?)?.toInt() ?? AppConstants.docStatusDraft,
  docType: json['doctype'] as String? ?? 'Attendance Regularization Request',
  attendanceDate: json['attendance_date'] as String,
  manualInTime: json['manual_in_time'] as String,
  manualOutTime: json['manual_out_time'] as String,
  reasonCategory: json['reason_category'] as String,
  employeeRemarks: json['employee_remarks'] as String,
  routedToHr: (json['routed_to_hr'] as num).toInt(),
  supportingDocument: json['supporting_document'] as String?,
);

Map<String, dynamic> _$AttendanceRegularizationModelToJson(
  _AttendanceRegularizationModel instance,
) => <String, dynamic>{
  'docstatus': instance.docStatus,
  'doctype': instance.docType,
  'attendance_date': instance.attendanceDate,
  'manual_in_time': instance.manualInTime,
  'manual_out_time': instance.manualOutTime,
  'reason_category': instance.reasonCategory,
  'employee_remarks': instance.employeeRemarks,
  'routed_to_hr': instance.routedToHr,
  'supporting_document': instance.supportingDocument,
};
