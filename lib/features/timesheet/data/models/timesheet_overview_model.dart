import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_overview_entity.dart';

part 'timesheet_overview_model.freezed.dart';
part 'timesheet_overview_model.g.dart';

@freezed
abstract class TimesheetOverviewModel with _$TimesheetOverviewModel {
  const factory TimesheetOverviewModel({
    @Default(0) int filled,
    @JsonKey(name: 'pending_approval') @Default(0) int pendingApproval,
    @JsonKey(name: 'correction_needed') @Default(0) int correctionNeeded,
    @JsonKey(name: 'upcoming_to_submit') @Default(0) int upcomingToSubmit,
    @Default(0) int approved,
    @JsonKey(name: 'total_weeks') @Default(0) int totalWeeks,
    @JsonKey(name: 'week_meta') @Default({}) Map<String, dynamic> weekMeta,
  }) = _TimesheetOverviewModel;

  const TimesheetOverviewModel._();

  factory TimesheetOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$TimesheetOverviewModelFromJson(json);

  TimesheetOverviewEntity toEntity() => TimesheetOverviewEntity(
        filled: filled,
        pendingApproval: pendingApproval,
        correctionNeeded: correctionNeeded,
        upcomingToSubmit: upcomingToSubmit,
        approved: approved,
        totalWeeks: totalWeeks,
        weekMeta: weekMeta,
      );
}
