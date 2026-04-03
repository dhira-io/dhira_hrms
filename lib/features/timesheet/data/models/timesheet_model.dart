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
    @JsonKey(name: 'total_hours') required double hoursTotal,
    @JsonKey(name: 'start_date') required String fromDate,
    @JsonKey(name: 'end_date') required String toDate,
    required int docstatus,
    @JsonKey(name: 'total_billable_hours') required double totalSpentHours,
    required String approver,
    @JsonKey(name: 'leave_approver_name') required String approverName,
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
      expectedHoursTotal: hoursTotal,
      remainingHours: hoursTotal - totalSpentHours,
      totalSpentHours: totalSpentHours,
      approver: approver,
      approverName: approverName,
      projectAssignments: projectAssignments?.map((e) => e.toEntity()).toList(),
    );
  }
}
