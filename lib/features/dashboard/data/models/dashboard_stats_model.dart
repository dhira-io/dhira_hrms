import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dashboard_stats_entity.dart';

part 'dashboard_stats_model.freezed.dart';
part 'dashboard_stats_model.g.dart';

@freezed
abstract class DashboardStatsModel with _$DashboardStatsModel {
  const factory DashboardStatsModel({
    @JsonKey(name: 'days_present') required int daysPresent,
    @JsonKey(name: 'leave_balance') required double leaveBalance,
    @JsonKey(name: 'next_holiday') required String nextHoliday,
    @JsonKey(name: 'next_holiday_date') required String nextHolidayDate,
  }) = _DashboardStatsModel;

  const DashboardStatsModel._();

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsModelFromJson(json);

  DashboardStatsEntity toEntity() {
    return DashboardStatsEntity(
      daysPresent: daysPresent,
      leaveBalance: leaveBalance,
      nextHoliday: nextHoliday,
      nextHolidayDate: nextHolidayDate,
    );
  }
}
