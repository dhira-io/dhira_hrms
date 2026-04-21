import 'package:freezed_annotation/freezed_annotation.dart';
import 'project_assignment_entity.dart';

part 'timesheet_entity.freezed.dart';

@freezed
abstract class TimesheetEntity with _$TimesheetEntity {
  const factory TimesheetEntity({
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
    List<ProjectAssignmentEntity>? projectAssignments,
  }) = _TimesheetEntity;

  const TimesheetEntity._();
}
