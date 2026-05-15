import 'package:freezed_annotation/freezed_annotation.dart';

part 'timesheet_overview_entity.freezed.dart';

@freezed
abstract class TimesheetOverviewEntity with _$TimesheetOverviewEntity {
  const factory TimesheetOverviewEntity({
    required int filled,
    required int pendingApproval,
    required int correctionNeeded,
    required int upcomingToSubmit,
    required int approved,
    required int totalWeeks,
    required Map<String, dynamic> weekMeta,
  }) = _TimesheetOverviewEntity;
}
