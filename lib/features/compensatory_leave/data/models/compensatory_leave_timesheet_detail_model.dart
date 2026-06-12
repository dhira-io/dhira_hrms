import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_timesheet_detail_entity.dart';

part 'compensatory_leave_timesheet_detail_model.freezed.dart';
part 'compensatory_leave_timesheet_detail_model.g.dart';

@freezed
class CompensatoryLeaveTimesheetDetailModel
    with _$CompensatoryLeaveTimesheetDetailModel {
  const CompensatoryLeaveTimesheetDetailModel._();

  const factory CompensatoryLeaveTimesheetDetailModel({
    @JsonKey(name: 'project_activity') required String projectActivity,
    @JsonKey(name: 'task') required String task,
    @JsonKey(name: 'reason_for_extra_work') required String reasonForExtraWork,
    @JsonKey(name: 'spent_hours') required double spentHours,
  }) = _CompensatoryLeaveTimesheetDetailModel;

  factory CompensatoryLeaveTimesheetDetailModel.fromJson(
    Map<String, dynamic> json,
  ) => _$CompensatoryLeaveTimesheetDetailModelFromJson(json);

  factory CompensatoryLeaveTimesheetDetailModel.fromEntity(
    CompensatoryLeaveTimesheetDetailEntity entity,
  ) {
    return CompensatoryLeaveTimesheetDetailModel(
      projectActivity: entity.projectActivity,
      task: entity.task,
      reasonForExtraWork: entity.reasonForExtraWork,
      spentHours: entity.spentHours,
    );
  }

  CompensatoryLeaveTimesheetDetailEntity toEntity() {
    return CompensatoryLeaveTimesheetDetailEntity(
      projectActivity: projectActivity,
      task: task,
      reasonForExtraWork: reasonForExtraWork,
      spentHours: spentHours,
    );
  }
}
