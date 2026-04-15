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
    @JsonKey(name: 'employee_name') String? employeeName,
    @JsonKey(name: 'hours_total') @Default(0.0) double hoursTotal,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
    @Default(0) int docstatus,
    @JsonKey(name: 'expected_hours_total') @Default(0.0) double expectedHoursTotal,
    @JsonKey(name: 'remaining_hours') @Default(0.0) double remainingHours,
    @JsonKey(name: 'total_spent_hours') @Default(0.0) double totalSpentHours,
    String? approver,
    @JsonKey(name: 'approver_name') String? approverName,
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
