import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';

class LeaveBalanceCard extends StatelessWidget {
  const LeaveBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocSelector<LeaveBloc, LeaveState, String>(
      selector: (state) {
        return l10n.daysCount(state.balance.available.toString());
      },
      builder: (context, balance) {
        return _OverviewCard(
          label: l10n.leaveBalance,
          value: balance,
          icon: Icons.calendar_month,
          iconColor: AppColors.warning,
        );
      },
    );
  }
}

class TimesheetSummaryCard extends StatelessWidget {
  const TimesheetSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocSelector<TimesheetBloc, TimesheetState, String>(
      selector: (state) {
        return state.maybeWhen(
          loaded: (timesheets, _, __, ___, ____, _____, ______, _______) => l10n.entriesCount(timesheets.length),
          orElse: () => l10n.entriesCount(0),
        );
      },
      builder: (context, summary) {
        return _OverviewCard(
          label: l10n.weekHours,
          value: summary,
          icon: Icons.timer,
          iconColor: AppColors.success,
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
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: AppConstants.iconLarge),
          const SizedBox(height: AppConstants.p12),
          Text(
            label,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: AppTextStyle.h3,
          ),
        ],
      ),
    );
  }
}

