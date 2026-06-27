import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return BlocSelector<AttendanceBloc, AttendanceState, String?>(
      selector: (state) {
        return state.maybeWhen(
          //loaded: (status, _) => status.statusText,
          orElse: () => AppConstants.timePlaceholder,
        );
      },
      builder: (context, statusText) {
        return Container(
          padding: const EdgeInsets.all(AppConstants.p20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary,
                colors.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppConstants.r20),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: AppConstants.opacityMedium),
                blurRadius: AppConstants.p15,
                offset: const Offset(0, AppConstants.p8),
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
                      color: colors.surface,
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
                    time: AppConstants.timePlaceholder,
                    icon: Icons.login,
                  ),
                  Container(
                    width: 1.w,
                    height: AppConstants.p40,
                    color: colors.surface.withValues(alpha: AppConstants.opacityFaded),
                  ),
                  _TimeColumn(
                    label: l10n.checkOut,
                    time: AppConstants.timePlaceholder,
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
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p10,
        vertical: AppConstants.p4,
      ),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: AppConstants.opacitySlight),
        borderRadius: BorderRadius.circular(AppConstants.r20),
      ),
      child: Text(
        text,
        style: AppTextStyle.bodySmall.copyWith(
          color: colors.surface,
          fontWeight: FontWeight.bold,
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
    final colors = AppColors.of(context);
    return Column(
      children: [
        Icon(
          icon,
          color: colors.surface.withValues(alpha: AppConstants.opacityMuted),
          size: AppConstants.iconSmall + 2,
        ),
        const SizedBox(height: AppConstants.p8),
        Text(
          time,
          style: AppTextStyle.h2.copyWith(color: colors.surface),
        ),
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: colors.surface.withValues(alpha: AppConstants.opacityMuted),
          ),
        ),
      ],
    );
  }
}
