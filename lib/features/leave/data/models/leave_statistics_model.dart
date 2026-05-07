import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_statistics_entity.dart';

part 'leave_statistics_model.freezed.dart';
part 'leave_statistics_model.g.dart';

String _stringFromJson(dynamic json) => json?.toString() ?? '';

List<dynamic> _listFromJson(dynamic json) {
  if (json is List) return json;
  if (json is Map) return json.values.toList();
  return [];
}

@freezed
abstract class LeaveStatisticsModel with _$LeaveStatisticsModel {
  const factory LeaveStatisticsModel({
    required bool success,
    @JsonKey(fromJson: _stringFromJson) required String employee,
    @JsonKey(name: 'employee_name', fromJson: _stringFromJson) required String employeeName,
    required LeavePeriodModel period,
    required LeaveStatsModel statistics,
    required LeaveDetailsModel details,
  }) = _LeaveStatisticsModel;

  const LeaveStatisticsModel._();

  factory LeaveStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveStatisticsModelFromJson(json);

  LeaveStatisticsEntity toEntity() {
    return LeaveStatisticsEntity(
      success: success,
      employee: employee,
      employeeName: employeeName,
      period: period.toEntity(),
      statistics: statistics.toEntity(),
      details: details.toEntity(),
    );
  }
}

@freezed
abstract class LeavePeriodModel with _$LeavePeriodModel {
  const factory LeavePeriodModel({
    @JsonKey(name: 'from_date', fromJson: _stringFromJson) required String fromDate,
    @JsonKey(name: 'to_date', fromJson: _stringFromJson) required String toDate,
  }) = _LeavePeriodModel;

  const LeavePeriodModel._();

  factory LeavePeriodModel.fromJson(Map<String, dynamic> json) =>
      _$LeavePeriodModelFromJson(json);

  LeavePeriodEntity toEntity() {
    return LeavePeriodEntity(
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}

@freezed
abstract class LeaveStatsModel with _$LeaveStatsModel {
  const factory LeaveStatsModel({
    @JsonKey(name: 'applied_days') required double appliedDays,
    @JsonKey(name: 'approved_days') required double approvedDays,
    @JsonKey(name: 'pending_days') required double pendingDays,
    @JsonKey(name: 'cancelled_days') required double cancelled_days,
    @JsonKey(name: 'total_applications') required int totalApplications,
  }) = _LeaveStatsModel;

  const LeaveStatsModel._();

  factory LeaveStatsModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveStatsModelFromJson(json);

  LeaveStatsEntity toEntity() {
    return LeaveStatsEntity(
      appliedDays: appliedDays,
      approvedDays: approvedDays,
      pendingDays: pendingDays,
      cancelledDays: cancelled_days,
      totalApplications: totalApplications,
    );
  }
}

@freezed
abstract class LeaveDetailsModel with _$LeaveDetailsModel {
  const factory LeaveDetailsModel({
    @JsonKey(name: 'applied_leaves', fromJson: _listFromJson) required List<dynamic> appliedLeaves,
    @JsonKey(name: 'approved_leaves', fromJson: _listFromJson) required List<dynamic> approvedLeaves,
    @JsonKey(name: 'pending_leaves', fromJson: _listFromJson) required List<dynamic> pendingLeaves,
    @JsonKey(name: 'cancelled_leaves', fromJson: _listFromJson) required List<dynamic> cancelledLeaves,
  }) = _LeaveDetailsModel;

  const LeaveDetailsModel._();

  factory LeaveDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveDetailsModelFromJson(json);

  LeaveDetailsEntity toEntity() {
    return LeaveDetailsEntity(
      appliedLeaves: appliedLeaves,
      approvedLeaves: approvedLeaves,
      pendingLeaves: pendingLeaves,
      cancelledLeaves: cancelledLeaves,
    );
  }
}
