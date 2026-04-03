import 'package:freezed_annotation/freezed_annotation.dart';
import 'project_assignment_entity.dart';

part 'timesheet_entity.freezed.dart';

@freezed
abstract class TimesheetEntity with _$TimesheetEntity {
  const factory TimesheetEntity({
    required String name,
    required String employee,
    required String employeeName,
    required double hoursTotal,
    required String fromDate,
    required String toDate,
    required int docStatus,
    required double expectedHoursTotal,
    required double remainingHours,
    required double totalSpentHours,
    required String approver,
    required String approverName,
    List<ProjectAssignmentEntity>? projectAssignments,
  }) = _TimesheetEntity;

  const TimesheetEntity._();
}
