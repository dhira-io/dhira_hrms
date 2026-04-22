import 'package:dhira_hrms/features/attendance/domain/entities/leave_details_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class LeaveDetailsSection extends StatelessWidget {
  final LeaveDetailsEntity details;

  const LeaveDetailsSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (details.leaveAllocation.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
          child: Row(
            children: [
              const SizedBox(width: 4, height: 20),
              const SizedBox(width: 10),
              Text(
                l10n.leaveBalance,
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
          child: Container(
            padding: const EdgeInsets.all(AppConstants.p20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppConstants.r16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                for (int i = 0; i < details.leaveAllocation.length; i++) ...[
                  _LeaveItem(
                    title: details.leaveAllocation.keys.elementAt(i),
                    allocation: details.leaveAllocation.values.elementAt(i),
                  ),
                  if (i < details.leaveAllocation.length - 1)
                    const SizedBox(height: 24),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: AppConstants.p24),
      ],
    );
  }
}

class _LeaveItem extends StatelessWidget {
  final String title;
  final LeaveAllocationEntity allocation;

  const _LeaveItem({required this.title, required this.allocation});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = _getThemeForLeave(title);
    final double progress = allocation.totalLeaves > 0
        ? (allocation.leavesTaken / allocation.totalLeaves).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              "${allocation.leavesTaken.toInt()} / ${allocation.totalLeaves.toInt()} ${allocation.totalLeaves == 1 ? l10n.day : l10n.daysLabel}",
              style: AppTextStyle.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.progress,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.track,
            valueColor: AlwaysStoppedAnimation<Color>(theme.progress),
            minHeight: 10,
          ),
        ),
      ],
    );
  }

  _LeaveTheme _getThemeForLeave(String title) {
    final t = title.toLowerCase();
    if (t.contains('bereavement')) {
      return const _LeaveTheme(
        track: AppColors.border,
        progress: AppColors.bereavementProgress,
      );
    } else if (t.contains('casual')) {
      return const _LeaveTheme(
        track: AppColors.border,
        progress: AppColors.pendingStatusText,
      );
    } else if (t.contains('earned') || t.contains('privileged')) {
      return const _LeaveTheme(
        track: AppColors.border,
        progress: AppColors.textSecondary,
      );
    } else if (t.contains('restricted')) {
      return const _LeaveTheme(
        track: AppColors.border,
        progress: AppColors.restrictedProgress,
      );
    } else if (t.contains('sick')) {
      return const _LeaveTheme(
        track: AppColors.border,
        progress: AppColors.blueIcon,
      );
    } else {
      return const _LeaveTheme(
        track: AppColors.border,
        progress: AppColors.primary,
      );
    }
  }
}

class _LeaveTheme {
  final Color track;
  final Color progress;

  const _LeaveTheme({required this.track, required this.progress});
}
