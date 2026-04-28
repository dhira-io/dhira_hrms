import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/attendance_regularization_entity.dart';

part 'attendance_regularization_model.freezed.dart';
part 'attendance_regularization_model.g.dart';

@freezed
abstract class AttendanceRegularizationModel with _$AttendanceRegularizationModel {
  const factory AttendanceRegularizationModel({
    @JsonKey(name: 'docstatus') @Default(AppConstants.docStatusDraft) int docStatus,
    @JsonKey(name: 'doctype')
    @Default('Attendance Regularization Request')
    String docType,
    @JsonKey(name: 'attendance_date') required String attendanceDate,
    @JsonKey(name: 'manual_in_time') required String manualInTime,
    @JsonKey(name: 'manual_out_time') required String manualOutTime,
    @JsonKey(name: 'reason_category') required String reasonCategory,
    @JsonKey(name: 'employee_remarks') required String employeeRemarks,
    @JsonKey(name: 'routed_to_hr') required int routedToHr,
    @JsonKey(name: 'supporting_document') String? supportingDocument,
  }) = _AttendanceRegularizationModel;

  const AttendanceRegularizationModel._();

  factory AttendanceRegularizationModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRegularizationModelFromJson(json);

  factory AttendanceRegularizationModel.fromEntity(
    AttendanceRegularizationEntity entity,
  ) {
    return AttendanceRegularizationModel(
      attendanceDate: entity.date.toIso8601String().split('T')[0],
      manualInTime: entity.requestedInTime,
      manualOutTime: entity.requestedOutTime,
      reasonCategory: entity.requestType,
      employeeRemarks: entity.reason,
      routedToHr: entity.routeToHR ? 1 : 0,
      supportingDocument:
          (entity.supportingDocuments != null &&
                  entity.supportingDocuments!.isNotEmpty)
              ? entity.supportingDocuments!.first
              : null,
    );
  }

  AttendanceRegularizationEntity toEntity() => AttendanceRegularizationEntity(
    date: DateTime.parse(attendanceDate),
    requestType: reasonCategory,
    requestedInTime: manualInTime,
    requestedOutTime: manualOutTime,
    routeToHR: routedToHr == 1,
    reason: employeeRemarks,
    supportingDocuments: supportingDocument != null ? [supportingDocument!] : null,
  );
}
