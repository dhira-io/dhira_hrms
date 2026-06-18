import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timesheet_event.freezed.dart';

@freezed
abstract class TimesheetEvent with _$TimesheetEvent {
  const TimesheetEvent._();

  const factory TimesheetEvent.started({String? timesheetId}) =
      TimesheetStarted;
  const factory TimesheetEvent.userInitRequested() = TimesheetUserInitRequested;

  const factory TimesheetEvent.fromDateChanged(DateTime? date) =
      TimesheetFromDateChanged;
  const factory TimesheetEvent.toDateChanged(DateTime? date) =
      TimesheetToDateChanged;
  const factory TimesheetEvent.assignmentsChanged(
    List<ProjectAssignmentEntity> assignments,
  ) = TimesheetAssignmentsChanged;
  const factory TimesheetEvent.daySelected(DateTime date) =
      TimesheetDaySelected;

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

  const factory TimesheetEvent.deleteTaskRequested({
    required ProjectAssignmentEntity task,
  }) = TimesheetDeleteTaskRequested;

  const factory TimesheetEvent.deleteTimesheetRequested({
    required String timesheetName,
  }) = TimesheetDeleteTimesheetRequested;

  const factory TimesheetEvent.fetchOverviewRequested({
    required int month,
    required int year,
  }) = TimesheetFetchOverviewRequested;

  const factory TimesheetEvent.submitWeeklyRequested() =
      TimesheetSubmitWeeklyRequested;
  const factory TimesheetEvent.editTaskRequested({
    required ProjectAssignmentEntity task,
    required int index,
  }) = TimesheetEditTaskRequested;
  const factory TimesheetEvent.editTaskCleared() = TimesheetEditTaskCleared;
  const factory TimesheetEvent.uploadFileRequested(String filePath) =
      TimesheetUploadFileRequested;
  const factory TimesheetEvent.clearUploadedFile() = TimesheetClearUploadedFile;
  const factory TimesheetEvent.saveTaskRequested({
    ProjectAssignmentEntity? task,
    String? timesheetId,
  }) = TimesheetSaveTaskRequested;
  const factory TimesheetEvent.formTaskDataChanged(String taskData) =
      TimesheetFormTaskDataChanged;
  const factory TimesheetEvent.formDescriptionChanged(String description) =
      TimesheetFormDescriptionChanged;
  const factory TimesheetEvent.formExpectedHoursChanged(String expectedHours) =
      TimesheetFormExpectedHoursChanged;
  const factory TimesheetEvent.formSpentHoursChanged(String spentHours) =
      TimesheetFormSpentHoursChanged;
  const factory TimesheetEvent.formProjectChanged(ProjectEntity? project) =
      TimesheetFormProjectChanged;
  const factory TimesheetEvent.pickAndUploadFileRequested() =
      TimesheetPickAndUploadFileRequested;
  const factory TimesheetEvent.previousWeekRequested() =
      TimesheetPreviousWeekRequested;
  const factory TimesheetEvent.nextWeekRequested() = TimesheetNextWeekRequested;
  const factory TimesheetEvent.refreshRequested() = TimesheetRefreshRequested;
  const factory TimesheetEvent.viewAttachmentRequested({
    required String attachment,
  }) = TimesheetViewAttachmentRequested;
  const factory TimesheetEvent.clearAttachmentViewRequested() =
      TimesheetClearAttachmentViewRequested;
}
