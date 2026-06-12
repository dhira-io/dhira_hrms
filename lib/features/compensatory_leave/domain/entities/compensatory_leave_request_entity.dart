import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_timesheet_detail_entity.dart';

part 'compensatory_leave_request_entity.freezed.dart';

@freezed
class CompensatoryLeaveRequestEntity with _$CompensatoryLeaveRequestEntity {
  const factory CompensatoryLeaveRequestEntity({
    required String customAutofill,
    required List<CompensatoryLeaveTimesheetDetailEntity> customTimesheetDetails,
    required String customWorkType,
    required String employee,
    required String employeeName,
    required String leaveType,
    required String reason,
    required String workEndDate,
    required String workFromDate,
  }) = _CompensatoryLeaveRequestEntity;

  const CompensatoryLeaveRequestEntity._();
}
