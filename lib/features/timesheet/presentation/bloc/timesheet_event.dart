import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_entities.dart';

part 'timesheet_event.freezed.dart';

@freezed
abstract class TimesheetEvent with _$TimesheetEvent {
  const TimesheetEvent._();

  const factory TimesheetEvent.started() = _Started;
  const factory TimesheetEvent.userInitRequested() = _UserInitRequested;
  
  // New Events for Reactive Form
  const factory TimesheetEvent.fromDateChanged(DateTime? date) = _FromDateChanged;
  const factory TimesheetEvent.toDateChanged(DateTime? date) = _ToDateChanged;
  const factory TimesheetEvent.assignmentsChanged(List<ProjectAssignmentEntity> assignments) = _AssignmentsChanged;
  const factory TimesheetEvent.daySelected(DateTime date) = _DaySelected;

  const factory TimesheetEvent.submitRequested({
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required List<ProjectAssignmentEntity> assignments,
    required int docStatus,
  }) = _SubmitRequested;

  const factory TimesheetEvent.updateRequested({
    required String name,
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required int approved, // This serves as docStatus
    required double hoursTotal,
    required List<ProjectAssignmentEntity> assignments,
  }) = _UpdateRequested;
  const factory TimesheetEvent.fetchMonthWiseRequested({
    required int month,
    required int year,
  }) = _FetchMonthWiseRequested;

  const factory TimesheetEvent.deleteEntryRequested({
    required String name,
    required String parent,
    required String date,
  }) = _DeleteEntryRequested;

  const factory TimesheetEvent.fetchOverviewRequested({
    required int month,
    required int year,
  }) = _FetchOverviewRequested;
}
