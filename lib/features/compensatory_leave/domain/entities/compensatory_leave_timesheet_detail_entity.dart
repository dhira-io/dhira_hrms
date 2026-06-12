import 'package:freezed_annotation/freezed_annotation.dart';

part 'compensatory_leave_timesheet_detail_entity.freezed.dart';

@freezed
class CompensatoryLeaveTimesheetDetailEntity
    with _$CompensatoryLeaveTimesheetDetailEntity {
  const factory CompensatoryLeaveTimesheetDetailEntity({
    required String projectActivity,
    required String task,
    required String reasonForExtraWork,
    required double spentHours,
  }) = _CompensatoryLeaveTimesheetDetailEntity;
}
