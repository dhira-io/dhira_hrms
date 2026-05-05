import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'project_assignment_approval_model.dart';
export 'project_assignment_approval_model.dart';

part 'timesheet_approval_model.freezed.dart';
part 'timesheet_approval_model.g.dart';

@freezed
abstract class TimesheetApprovalModel with _$TimesheetApprovalModel {
  const factory TimesheetApprovalModel({
    required String name,
    required dynamic employee,
    @JsonKey(name: 'employee_name') String? employeeName,
    @JsonKey(name: 'hours_total') @Default(0.0) double hoursTotal,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
    @Default(0) int docstatus,
    @JsonKey(name: 'expected_hours') @Default(0.0) double expectedHoursTotal,
    @JsonKey(name: 'remaining_hours') @Default(0.0) double remainingHours,
    @JsonKey(name: 'actual_hours') @Default(0.0) double totalSpentHours,
    String? approver,
    @JsonKey(name: 'approver_name') String? approverName,
    @JsonKey(name: 'organization_department') String? department,
    @JsonKey(name: 'rows') List<ProjectAssignmentApprovalModel>? projectAssignments,
  }) = _TimesheetApprovalModel;

  const TimesheetApprovalModel._();

  factory TimesheetApprovalModel.fromJson(Map<String, dynamic> json) => _$TimesheetApprovalModelFromJson(json);

  TimesheetApprovalEntity toEntity() {
    String employeeId = "";
    String? nameFromEmp = employeeName;
    
    if (employee is String) {
      employeeId = employee;
    } else if (employee is Map) {
      employeeId = employee['id'] ?? "";
      nameFromEmp ??= employee['name'];
    }

    return TimesheetApprovalEntity(
      name: name,
      employee: employeeId,
      employeeName: nameFromEmp,
      hoursTotal: hoursTotal,
      fromDate: fromDate,
      toDate: toDate,
      docStatus: docstatus,
      expectedHoursTotal: expectedHoursTotal,
      remainingHours: remainingHours,
      totalSpentHours: totalSpentHours,
      approver: approver,
      approverName: approverName,
      department: department,
      projectAssignments: projectAssignments?.map((e) => e.toEntity()).toList(),
    );
  }
}
