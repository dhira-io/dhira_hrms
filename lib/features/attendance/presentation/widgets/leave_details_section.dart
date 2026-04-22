import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/leave_details_entity.dart';

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
              SizedBox(width: 4, height: 20),
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
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: details.leaveAllocation.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final leaveType = details.leaveAllocation.keys.elementAt(index);
            final allocation = details.leaveAllocation[leaveType]!;
            return _LeaveCard(title: leaveType, allocation: allocation);
          },
        ),
        const SizedBox(height: AppConstants.p24),
      ],
    );
  }
}

class _LeaveCard extends StatelessWidget {
  final String title;
  final LeaveAllocationEntity allocation;

  const _LeaveCard({required this.title, required this.allocation});

  @override
  Widget build(BuildContext context) {
    final theme = _getThemeForLeave(title);
    final double progress = allocation.totalLeaves > 0
        ? (allocation.leavesTaken / allocation.totalLeaves).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: theme.background,
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.textColor,
                  ),
                ),
              ),
              Text(
                "${allocation.leavesTaken.toInt()}/${allocation.totalLeaves.toInt()}",
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.track,
              valueColor: AlwaysStoppedAnimation<Color>(theme.progress),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  _LeaveTheme _getThemeForLeave(String title) {
    final t = title.toLowerCase();
    if (t.contains('bereavement')) {
      return const _LeaveTheme(
        background: AppColors.bereavementBg,
        track: AppColors.bereavementTrack,
        progress: AppColors.bereavementProgress,
        textColor: AppColors.textSecondary,
      );
    } else if (t.contains('casual')) {
      return const _LeaveTheme(
        background: AppColors.casualBg,
        track: AppColors.casualTrack,
        progress: AppColors.casualProgress,
        textColor: AppColors.holidayText,
      );
    } else if (t.contains('earned') || t.contains('privileged')) {
      return const _LeaveTheme(
        background: AppColors.earnedBg,
        track: AppColors.earnedTrack,
        progress: AppColors.earnedProgress,
        textColor: AppColors.secondary,
      );
    } else if (t.contains('restricted')) {
      return const _LeaveTheme(
        background: AppColors.restrictedBg,
        track: AppColors.restrictedTrack,
        progress: AppColors.restrictedProgress,
        textColor: AppColors.textSecondary,
      );
    } else if (t.contains('sick')) {
      return const _LeaveTheme(
        background: AppColors.sickBg,
        track: AppColors.sickTrack,
        progress: AppColors.sickProgress,
        textColor: AppColors.textSecondary,
      );
    } else {
      return const _LeaveTheme(
        background: AppColors.background,
        track: AppColors.border,
        progress: AppColors.primary,
        textColor: AppColors.textSecondary,
      );
    }
  }
}

class _LeaveTheme {
  final Color background;
  final Color track;
  final Color progress;
  final Color textColor;

  const _LeaveTheme({
    required this.background,
    required this.track,
    required this.progress,
    required this.textColor,
  });
}
