import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_state.dart';

class AttendanceSummaryCard extends StatelessWidget {
  const AttendanceSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocSelector<AttendanceBloc, AttendanceState, String?>(
      selector: (state) {
        return state.maybeWhen(
          //loaded: (status, _) => status.statusText,
          orElse: () => "--:--",
        );
      },
      builder: (context, statusText) {
        return Container(
          padding: const EdgeInsets.all(AppConstants.p20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppConstants.r20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.todaysAttendance,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: AppColors.surface,
                    ),
                  ),
                  _StatusBadge(text: statusText ?? l10n.onTime),
                ],
              ),
              const SizedBox(height: AppConstants.p20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _TimeColumn(
                    label: l10n.checkIn,
                    time: '--:--',
                    icon: Icons.login,
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: AppColors.surface.withValues(alpha: 0.24),
                  ),
                  _TimeColumn(
                    label: l10n.checkOut,
                    time: '--:--',
                    icon: Icons.logout,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;
  const _StatusBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p10,
        vertical: AppConstants.p4,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppConstants.r20),
      ),
      child: Text(
        text,
        style: AppTextStyle.bodySmall.copyWith(
          color: AppColors.surface,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _TimeColumn extends StatelessWidget {
  final String label;
  final String time;
  final IconData icon;

  const _TimeColumn({
    required this.label,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.surface.withValues(alpha: 0.7),
          size: AppConstants.iconSmall + 2,
        ),
        const SizedBox(height: AppConstants.p8),
        Text(time, style: AppTextStyle.h2.copyWith(color: AppColors.surface)),
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.surface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
