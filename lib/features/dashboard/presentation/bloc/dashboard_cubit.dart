import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/dashboard/data/models/dashboard_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState()) {
    _initItems();
  }

  void _initItems() {
    final employeeActions = [
      DashboardItem(
        title: "Timesheet",
        subtitle: "Log your hours",
        assetImagePath: "assets/icons/timesheet_clr.png",
        bgColorValue: AppColors.iconbgblue.toARGB32(),
        route: AppRouter.timesheetPath,
      ),
      DashboardItem(
        title: "Leave Application",
        subtitle: "Request time off",
        assetImagePath: "assets/icons/leave_clr.png",
        bgColorValue: AppColors.iconbggreen.toARGB32(),
        route: AppRouter.leavePath,
      ),
      DashboardItem(
        title: "Attendance",
        subtitle: "View records",
        assetImagePath: "assets/icons/attendance_clr.png",
        bgColorValue: AppColors.iconbgviolet.toARGB32(),
        route: AppRouter.attendancePath,
      ),
    ];

    final companyInfo = [
      DashboardItem(
        title: "Leaders Board",
        subtitle: "Organization hierarchy",
        assetImagePath: "assets/icons/leader_clr.png",
        bgColorValue: AppColors.iconbgred.toARGB32(),
        route: AppRouter.organizationPath,
      ),
    ];

    emit(state.copyWith(
      allEmployeeActions: employeeActions,
      allCompanyInfo: companyInfo,
      filteredEmployeeActions: employeeActions,
      filteredCompanyInfo: companyInfo,
    ));
  }

  void onSearchChanged(String query) {
    final lower = query.toLowerCase();
    
    if (query.isEmpty) {
      emit(state.copyWith(
        searchQuery: query,
        filteredEmployeeActions: state.allEmployeeActions,
        filteredCompanyInfo: state.allCompanyInfo,
      ));
      return;
    }

    final filteredActions = state.allEmployeeActions.where((item) =>
      item.title.toLowerCase().contains(lower) ||
      item.subtitle.toLowerCase().contains(lower)
    ).toList();

    final filteredInfo = state.allCompanyInfo.where((item) =>
      item.title.toLowerCase().contains(lower) ||
      item.subtitle.toLowerCase().contains(lower)
    ).toList();

    emit(state.copyWith(
      searchQuery: query,
      filteredEmployeeActions: filteredActions,
      filteredCompanyInfo: filteredInfo,
    ));
  }

  void toggleProfileMenu() {
    emit(state.copyWith(isProfileMenuOpen: !state.isProfileMenuOpen));
  }

  void toggleMainMenu() {
    emit(state.copyWith(isMainMenuOpen: !state.isMainMenuOpen));
  }

  void closeMenus() {
    emit(state.copyWith(isProfileMenuOpen: false, isMainMenuOpen: false));
  }
}
