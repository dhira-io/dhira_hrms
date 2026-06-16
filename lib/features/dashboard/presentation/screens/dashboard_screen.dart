import 'package:dhira_hrms/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_event.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/bottom_nav_cubit.dart';
import 'home_screen.dart';
import '../../../approvals/presentation/screens/approvals_screen.dart';
import '../widgets/custom_bottom_nav.dart';

import 'package:get/get.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/team_evaluation/team_evaluation_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/team_evaluation/team_evaluation_filter_cubit.dart';
import 'package:dhira_hrms/features/settings/presentation/screens/settings_screen.dart';
import 'package:dhira_hrms/features/settings/presentation/bloc/settings_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavCubit>.value(value: Get.find<BottomNavCubit>()),
        BlocProvider<DashboardCubit>.value(value: Get.find<DashboardCubit>()),
        BlocProvider<AttendanceBloc>.value(value: Get.find<AttendanceBloc>()),
        BlocProvider<LeaveBloc>.value(value: Get.find<LeaveBloc>()),
        BlocProvider<TimesheetBloc>.value(value: Get.find<TimesheetBloc>()),
        BlocProvider<ProfileBloc>.value(value: Get.find<ProfileBloc>()),
        BlocProvider<ApprovalsBloc>.value(value: Get.find<ApprovalsBloc>()),
        BlocProvider<PerformanceBloc>.value(
          value: Get.find<PerformanceBloc>()
            ..add(const PerformanceEvent.started()),
        ),
        BlocProvider<TeamEvaluationCubit>.value(
          value: Get.find<TeamEvaluationCubit>(),
        ),
        BlocProvider<TeamEvaluationFilterCubit>.value(
          value: Get.find<TeamEvaluationFilterCubit>(),
        ),
        BlocProvider<SettingsCubit>.value(value: Get.find<SettingsCubit>()),
      ],
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    context.read<DashboardCubit>().initializeLocalizedItems(
      timesheetTitle: l10n.timesheet,
      timesheetSubtitle: l10n.logYourHours,
      leaveTitle: l10n.leave,
      leaveSubtitle: l10n.requestTimeOff,
      compensatoryLeaveTitle: l10n.compensatoryLeave,
      compensatoryLeaveSubtitle: l10n.requestCompensatoryLeave,
      attendanceTitle: l10n.attendance,
      attendanceSubtitle: l10n.viewAttendanceRecords,
      leaderBoardTitle: l10n.leadersBoard,
      leaderBoardSubtitle: l10n.organizationHierarchy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      extendBody: true,
      body: SafeArea(
        child: BlocBuilder<BottomNavCubit, int>(
          builder: (context, state) {
            return IndexedStack(
              index: state,
              children: [
                const HomeScreen(),
                const AttendanceScreen(),
                const ApprovalsScreen(),
                const SettingsScreen(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
