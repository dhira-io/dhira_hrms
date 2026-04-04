import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_event.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/home_header.dart';
import '../widgets/attendance_summary_card.dart';
import '../widgets/overview_cards.dart';
import '../widgets/quick_actions_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userfullname')?.split(' ').first ?? "User";
      _userId = prefs.getString('userid');
    });
    if (_userId != null) {
      _refreshAll();
    }
  }

  void _refreshAll() {
    if (_userId == null) return;
    context.read<AttendanceBloc>().add(AttendanceEvent.logRequested(_userId!));
    context.read<AttendanceBloc>().add(AttendanceEvent.checkStatusRequested(_userId!));
    context.read<LeaveBloc>().add(LeaveEvent.started(_userId!));
    context.read<TimesheetBloc>().add(TimesheetEvent.started(_userId!));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => _refreshAll(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppConstants.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(userName: _userName ?? "User"),
                const SizedBox(height: AppConstants.p24),
                const AttendanceSummaryCard(),
                const SizedBox(height: AppConstants.p20),
                Text(
                  l10n.yourOverview,
                  style: AppTextStyle.h3,
                ),
                const SizedBox(height: AppConstants.p16),
                const Row(
                  children: [
                    Expanded(child: LeaveBalanceCard()),
                    SizedBox(width: AppConstants.p15),
                    Expanded(child: TimesheetSummaryCard()),
                  ],
                ),
                const SizedBox(height: AppConstants.p24),
                const QuickActionsGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

