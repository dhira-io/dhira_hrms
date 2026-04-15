import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/timesheet_entity.dart';
import 'project_assignment_model.dart';

part 'timesheet_model.freezed.dart';
part 'timesheet_model.g.dart';

@freezed
abstract class TimesheetModel with _$TimesheetModel {
  const factory TimesheetModel({
    required String name,
    required String employee,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'hours_total') required double hoursTotal,
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    required int docstatus,
    @JsonKey(name: 'expected_hours_total') required double expectedHoursTotal,
    @JsonKey(name: 'remaining_hours') required double remainingHours,
    @JsonKey(name: 'total_spent_hours') required double totalSpentHours,
    required String approver,
    @JsonKey(name: 'approver_name') required String approverName,
    @JsonKey(name: 'organization_department') String? department,
    @JsonKey(name: 'time_logs') List<ProjectAssignmentModel>? projectAssignments,
  }) = _TimesheetModel;

  const TimesheetModel._();

  factory TimesheetModel.fromJson(Map<String, dynamic> json) => _$TimesheetModelFromJson(json);

  TimesheetEntity toEntity() {
    return TimesheetEntity(
      name: name,
      employee: employee,
      employeeName: employeeName,
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
