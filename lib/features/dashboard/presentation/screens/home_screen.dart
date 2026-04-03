import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_event.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => _refreshAll(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(userName: _userName ?? "User"),
                const SizedBox(height: 25),
                const AttendanceSummaryCard(),
                const SizedBox(height: 20),
                const Text(
                  'Your Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Expanded(child: LeaveBalanceCard()),
                    SizedBox(width: 15),
                    Expanded(child: TimesheetSummaryCard()),
                  ],
                ),
                const SizedBox(height: 25),
                const QuickActionsGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
