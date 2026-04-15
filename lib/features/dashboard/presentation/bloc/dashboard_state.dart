import 'package:dhira_hrms/features/dashboard/data/models/dashboard_item_model.dart';
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
    @Default(false) bool isProfileMenuOpen,
    @Default(false) bool isMainMenuOpen,
  }) = _DashboardState;
}
