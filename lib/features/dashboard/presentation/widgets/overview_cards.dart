import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';

class LeaveBalanceCard extends StatelessWidget {
  const LeaveBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LeaveBloc, LeaveState, String>(
      selector: (state) {
        return state.maybeWhen(
          loaded: (leaves, _, balance, __, ___) => "$balance Days",
          orElse: () => "0 Days",
        );
      },
      builder: (context, balance) {
        return _OverviewCard(
          label: 'Leave Balance',
          value: balance,
          icon: Icons.calendar_month,
          iconColor: Colors.orange,
        );
      },
    );
  }
}

class TimesheetSummaryCard extends StatelessWidget {
  const TimesheetSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TimesheetBloc, TimesheetState, String>(
      selector: (state) {
        return state.maybeWhen(
          loaded: (timesheets, _, __) => "${timesheets.length} Entries", // Simplified
          orElse: () => "0 Entries",
        );
      },
      builder: (context, summary) {
        return _OverviewCard(
          label: 'Week Hours', // Keep label consistent with original UI for now
          value: summary,
          icon: Icons.timer,
          iconColor: Colors.green,
        );
      },
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _OverviewCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 30),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
