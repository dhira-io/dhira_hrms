import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:dhira_hrms/core/constants/storage_constants.dart';
import 'package:dhira_hrms/features/dashboard/domain/usecases/get_dashboard_stats_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/dashboard/data/models/dashboard_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardStatsUseCase getDashboardStatsUseCase;

  DashboardCubit({
    required this.getDashboardStatsUseCase,
  }) : super(const DashboardState()) {
    fetchDashboardStats();
  }
  void _initItems(
    String timesheetTitle,
    String timesheetSubtitle,
    String leaveTitle,
    String leaveSubtitle,
    String attendanceTitle,
    String attendanceSubtitle,
    String leaderBoardTitle,
    String leaderBoardSubtitle,
  ) {
    final employeeActions = [
      DashboardItem(
        title: timesheetTitle,
        subtitle: timesheetSubtitle,
        assetImagePath: AppAssets.timesheetIcon,
        bgColorValue: AppColors.iconbgblue.toARGB32(),
        route: AppRouter.timesheetPath,
      ),
      DashboardItem(
        title: leaveTitle,
        subtitle: leaveSubtitle,
        assetImagePath: AppAssets.leaveIcon,
        bgColorValue: AppColors.iconbggreen.toARGB32(),
        route: AppRouter.applyLeavePath,
      ),
      DashboardItem(
        title: attendanceTitle,
        subtitle: attendanceSubtitle,
        assetImagePath: AppAssets.attendanceIcon,
        bgColorValue: AppColors.iconbgviolet.toARGB32(),
        route: AppRouter.attendancePath,
      ),
    ];

    final companyInfo = [
      DashboardItem(
        title: leaderBoardTitle,
        subtitle: leaderBoardSubtitle,
        assetImagePath: AppAssets.leaderIcon,
        bgColorValue: AppColors.iconbgred.toARGB32(),
        route: AppRouter.organizationPath,
      ),
    ];

    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(
        allEmployeeActions: employeeActions,
        allCompanyInfo: companyInfo,
        filteredEmployeeActions: employeeActions,
        filteredCompanyInfo: companyInfo,
        isLoading: false,
      ));
    });
  }

  void initializeLocalizedItems({
    required String timesheetTitle,
    required String timesheetSubtitle,
    required String leaveTitle,
    required String leaveSubtitle,
    required String attendanceTitle,
    required String attendanceSubtitle,
    required String leaderBoardTitle,
    required String leaderBoardSubtitle,
  }) {
    _initItems(
      timesheetTitle,
      timesheetSubtitle,
      leaveTitle,
      leaveSubtitle,
      attendanceTitle,
      attendanceSubtitle,
      leaderBoardTitle,
      leaderBoardSubtitle,
    );
  }

  Future<void> fetchDashboardStats() async {
    final prefs = await SharedPreferences.getInstance();
    final employeeId = prefs.getString(StorageConstants.empId);

    if (employeeId == null) return;

    emit(state.copyWith(statsLoading: true, statsError: null));

    final result = await getDashboardStatsUseCase(employeeId);

    result.fold(
      (failure) => emit(state.copyWith(
        statsLoading: false,
        statsError: failure.message,
      )),
      (stats) => emit(state.copyWith(
        statsLoading: false,
        stats: stats,
      )),
    );
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
