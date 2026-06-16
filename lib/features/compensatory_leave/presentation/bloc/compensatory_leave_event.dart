import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_eligible_date_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';

part 'compensatory_leave_event.freezed.dart';

@freezed
class CompensatoryLeaveEvent with _$CompensatoryLeaveEvent {
  const factory CompensatoryLeaveEvent.started({String? compensatoryLeaveId}) =
      CompensatoryLeaveStarted;
  const factory CompensatoryLeaveEvent.fetchRequested() =
      CompensatoryLeaveFetchRequested;
  const factory CompensatoryLeaveEvent.dateSelected(
    CompensatoryLeaveEligibleDateEntity? date,
  ) = CompensatoryLeaveDateSelected;
  const factory CompensatoryLeaveEvent.projectSelected(ProjectEntity? project) =
      CompensatoryLeaveProjectSelected;
  const factory CompensatoryLeaveEvent.timesheetFillChanged(String type) =
      CompensatoryLeaveTimesheetFillChanged;
  const factory CompensatoryLeaveEvent.taskDescriptionChanged(
    String description,
  ) = CompensatoryLeaveTaskDescriptionChanged;
  const factory CompensatoryLeaveEvent.reasonChanged(String reason) =
      CompensatoryLeaveReasonChanged;
  const factory CompensatoryLeaveEvent.workTypeChanged(String type) =
      CompensatoryLeaveWorkTypeChanged;
  const factory CompensatoryLeaveEvent.submitRequested() =
      CompensatoryLeaveSubmitRequested;
}
