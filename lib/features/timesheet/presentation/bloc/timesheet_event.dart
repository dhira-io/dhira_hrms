import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_entities.dart';

part 'timesheet_event.freezed.dart';

@freezed
abstract class TimesheetEvent with _$TimesheetEvent {
  const TimesheetEvent._();

  const factory TimesheetEvent.started() = _Started;
  const factory TimesheetEvent.userInitRequested() = _UserInitRequested;
  const factory TimesheetEvent.loadMoreRequested() = _LoadMoreRequested;
  const factory TimesheetEvent.fetchDetailsRequested(String timesheetId) = _FetchDetailsRequested;
  
  // New Events for Reactive Form
  const factory TimesheetEvent.fromDateChanged(DateTime? date) = _FromDateChanged;
  const factory TimesheetEvent.toDateChanged(DateTime? date) = _ToDateChanged;
  const factory TimesheetEvent.assignmentsChanged(List<ProjectAssignmentEntity> assignments) = _AssignmentsChanged;

  const factory TimesheetEvent.submitRequested({
    required String employee,
    required String department,
    required String approver,
    required String fromDate,
    required String toDate,
    required List<ProjectAssignmentEntity> assignments,
  }) = _SubmitRequested;

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
  }) = _UpdateRequested;
}
