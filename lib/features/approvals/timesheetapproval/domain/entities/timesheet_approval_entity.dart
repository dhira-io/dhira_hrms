import 'package:freezed_annotation/freezed_annotation.dart';
import 'project_assignment_approval_entity.dart';
export 'project_assignment_approval_entity.dart';

part 'timesheet_approval_entity.freezed.dart';

@freezed
abstract class TimesheetApprovalEntity with _$TimesheetApprovalEntity {
  const factory TimesheetApprovalEntity({
    required String name,
    required String employee,
    String? employeeName,
    @Default(0.0) double hoursTotal,
    String? fromDate,
    String? toDate,
    @Default(0) int docStatus,
    @Default(0.0) double expectedHoursTotal,
    @Default(0.0) double remainingHours,
    @Default(0.0) double totalSpentHours,
    String? approver,
    String? approverName,
    String? department,
    List<ProjectAssignmentApprovalEntity>? projectAssignments,
  }) = _TimesheetApprovalEntity;

  const TimesheetApprovalEntity._();
}
