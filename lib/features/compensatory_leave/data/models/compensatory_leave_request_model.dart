import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_request_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/data/models/compensatory_leave_timesheet_detail_model.dart';

part 'compensatory_leave_request_model.freezed.dart';
part 'compensatory_leave_request_model.g.dart';

@freezed
class CompensatoryLeaveRequestModel with _$CompensatoryLeaveRequestModel {
  const factory CompensatoryLeaveRequestModel({
    @JsonKey(name: 'custom_autofill') required String customAutofill,
    @JsonKey(name: 'custom_timesheet_details') required List<CompensatoryLeaveTimesheetDetailModel> customTimesheetDetails,
    @JsonKey(name: 'custom_work_type') required String customWorkType,
    required String employee,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'leave_type') required String leaveType,
    required String reason,
    @JsonKey(name: 'work_end_date') required String workEndDate,
    @JsonKey(name: 'work_from_date') required String workFromDate,
  }) = _CompensatoryLeaveRequestModel;

  const CompensatoryLeaveRequestModel._();

  factory CompensatoryLeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CompensatoryLeaveRequestModelFromJson(json);

  factory CompensatoryLeaveRequestModel.fromEntity(CompensatoryLeaveRequestEntity entity) {
    return CompensatoryLeaveRequestModel(
      customAutofill: entity.customAutofill,
      customTimesheetDetails: entity.customTimesheetDetails.map((e) => CompensatoryLeaveTimesheetDetailModel.fromEntity(e)).toList(),
      customWorkType: entity.customWorkType,
      employee: entity.employee,
      employeeName: entity.employeeName,
      leaveType: entity.leaveType,
      reason: entity.reason,
      workEndDate: entity.workEndDate,
      workFromDate: entity.workFromDate,
    );
  }

  CompensatoryLeaveRequestEntity toEntity() {
    return CompensatoryLeaveRequestEntity(
      customAutofill: customAutofill,
      customTimesheetDetails: customTimesheetDetails.map((e) => e.toEntity()).toList(),
      customWorkType: customWorkType,
      employee: employee,
      employeeName: employeeName,
      leaveType: leaveType,
      reason: reason,
      workEndDate: workEndDate,
      workFromDate: workFromDate,
    );
  }
}
