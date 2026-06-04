import 'package:dhira_hrms/features/attendance/domain/entities/leave_details_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/collapsible_section.dart';

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
        CollapsibleSection(
          initiallyExpanded: false,
          title: Row(
            children: [
              Text(
                l10n.leaveBalance,
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                    fontSize: AppConstants.f15.sp
                ),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    SizedBox(height: 16.h),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p20,
                ),
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.p20),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surfaceContainerLowest,
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
                      for (
                        int i = 0;
                        i < details.leaveAllocation.length;
                        i++
                      ) ...[
                        _LeaveItem(
                          title: details.leaveAllocation.keys.elementAt(i),
                          allocation: details.leaveAllocation.values.elementAt(
                            i,
                          ),
                        ),
                        if (i < details.leaveAllocation.length - 1)
                                SizedBox(height: 24.h),
                      ],
                    ],
                  ),
                ),
              ),
            ],
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
    final theme = _getThemeForLeave(context, title);
    final double progress = allocation.totalLeaves > 0
        ? (allocation.leavesTaken / allocation.totalLeaves).clamp(0.0, 1.0)
        : 0.0;

    String formatValue(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

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
              "${formatValue(allocation.leavesTaken)} / ${formatValue(allocation.totalLeaves)} ${allocation.totalLeaves == 1 ? l10n.day : l10n.daysLabel}",
              style: AppTextStyle.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.countText,
              ),
            ),
          ],
        ),
              SizedBox(height: 12.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.track,
            valueColor: AlwaysStoppedAnimation<Color>(theme.progress),
            minHeight: 5,
          ),
        ),
      ],
    );
  }

  _LeaveTheme _getThemeForLeave(BuildContext context, String title) {
    final t = title.toLowerCase();
    if (t.contains(LeaveType.bereavement)) {
      return _LeaveTheme(
        track: AppColors.of(context).bereavementTrack,
        progress: AppColors.of(context).bereavementProgress,
        countText: AppColors.of(context).bereavementText,
      );
    } else if (t.contains(LeaveType.casual)) {
      return _LeaveTheme(
        track: AppColors.of(context).casualTrack,
        progress: AppColors.of(context).casualProgress,
        countText: AppColors.of(context).casualText,
      );
    } else if (t.contains(LeaveType.earned) ||
        t.contains(LeaveType.privileged)) {
      return _LeaveTheme(
        track: AppColors.of(context).earnedTrack,
        progress: AppColors.of(context).earnedProgress,
        countText: AppColors.of(context).earnedText,
      );
    } else if (t.contains(LeaveType.paternity)) {
      return _LeaveTheme(
        track: AppColors.of(context).paternityTrack,
        progress: AppColors.of(context).paternityProgress,
        countText: AppColors.of(context).paternityText,
      );
    } else if (t.contains(LeaveType.maternity)) {
      return _LeaveTheme(
        track: AppColors.of(context).maternityTrack,
        progress: AppColors.of(context).maternityProgress,
        countText: AppColors.of(context).maternityText,
      );
    } else if (t.contains(LeaveType.restricted)) {
      return _LeaveTheme(
        track: AppColors.of(context).restrictedTrack,
        progress: AppColors.of(context).restrictedProgress,
        countText: AppColors.of(context).restrictedText,
      );
    } else if (t.contains(LeaveType.sick)) {
      return _LeaveTheme(
        track: AppColors.of(context).sickTrack,
        progress: AppColors.of(context).sickProgress,
        countText: AppColors.of(context).sickText,
      );
    } else if (t.contains(LeaveType.compensatory)) {
      return _LeaveTheme(
        track: AppColors.of(context).compensatoryTrack,
        progress: AppColors.of(context).compensatoryProgress,
        countText: AppColors.of(context).compensatoryText,
      );
    } else {
      return _LeaveTheme(
        track: AppColors.of(context).border,
        progress: AppColors.of(context).primary,
        countText: AppColors.of(context).primary,
      );
    }
  }
}

class _LeaveTheme {
  final Color track;
  final Color progress;
  final Color countText;

  const _LeaveTheme({
    required this.track,
    required this.progress,
    required this.countText,
  });
}
