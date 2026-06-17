import 'package:dhira_hrms/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/bottom_nav_cubit.dart';
import 'home_screen.dart';
import '../../../approvals/presentation/screens/approvals_screen.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/custom_drawer.dart';
import 'package:dhira_hrms/features/payslip/presentation/screens/payslip_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardView();
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
      policyHubTitle: l10n.policyHub,
      policyHubSubtitle: l10n.policyHubSubtitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  const PayslipListScreen(),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: const CustomBottomNav(),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
