import 'package:dhira_hrms/features/dashboard/data/models/dashboard_item_model.dart';
import 'package:dhira_hrms/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default([]) List<DashboardItem> allEmployeeActions,
    @Default([]) List<DashboardItem> allCompanyInfo,
    @Default([]) List<DashboardItem> filteredEmployeeActions,
    @Default([]) List<DashboardItem> filteredCompanyInfo,
    @Default('') String searchQuery,
    @Default(true) bool isLoading,
    @Default(false) bool isProfileMenuOpen,
    @Default(false) bool isMainMenuOpen,
    DashboardStatsEntity? stats,
    @Default(false) bool statsLoading,
    String? statsError,
  }) = _DashboardState;
}
