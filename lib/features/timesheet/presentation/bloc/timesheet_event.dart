import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_entities.dart';

part 'timesheet_event.freezed.dart';

@freezed
abstract class TimesheetEvent with _$TimesheetEvent {
  const TimesheetEvent._();

  const factory TimesheetEvent.started({String? timesheetId}) = TimesheetStarted;
  const factory TimesheetEvent.userInitRequested() = TimesheetUserInitRequested;

  const factory TimesheetEvent.fromDateChanged(DateTime? date) = TimesheetFromDateChanged;
  const factory TimesheetEvent.toDateChanged(DateTime? date) = TimesheetToDateChanged;
  const factory TimesheetEvent.assignmentsChanged(List<ProjectAssignmentEntity> assignments) = TimesheetAssignmentsChanged;
  const factory TimesheetEvent.daySelected(DateTime date) = TimesheetDaySelected;

  const factory TimesheetEvent.submitRequested({
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required List<ProjectAssignmentEntity> assignments,
    required int docStatus,
  }) = TimesheetSubmitRequested;

  const factory TimesheetEvent.updateRequested({
    required String name,
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required int approved,
    required double hoursTotal,
    required List<ProjectAssignmentEntity> assignments,
  }) = TimesheetUpdateRequested;

  const factory TimesheetEvent.fetchMonthWiseRequested({
    required int month,
    required int year,
  }) = TimesheetFetchMonthWiseRequested;

  const factory TimesheetEvent.deleteEntryRequested({
    required String name,
    required String parent,
    required String date,
  }) = TimesheetDeleteEntryRequested;

  const factory TimesheetEvent.fetchOverviewRequested({
    required int month,
    required int year,
  }) = TimesheetFetchOverviewRequested;

  const factory TimesheetEvent.submitWeeklyRequested() = TimesheetSubmitWeeklyRequested;
  const factory TimesheetEvent.editTaskRequested({required ProjectAssignmentEntity task, required int index}) = TimesheetEditTaskRequested;
  const factory TimesheetEvent.editTaskCleared() = TimesheetEditTaskCleared;
}
