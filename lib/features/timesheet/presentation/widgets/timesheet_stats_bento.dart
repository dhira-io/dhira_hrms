import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../../l10n/app_localizations.dart';

import 'package:shimmer/shimmer.dart';

class TimesheetBentoStats extends StatelessWidget {
  final List<ProjectAssignmentEntity> editAssignments;
  final DateTime selectedDate;
  final String weekMeta;
  final int? filled;
  final int? approved;
  final int? pending;
  final int? rejected;
  final int? upcoming;
  final bool isLoading;

  const TimesheetBentoStats({
    super.key,
    required this.editAssignments,
    required this.selectedDate,
    this.weekMeta = "",
    this.filled,
    this.approved,
    this.pending,
    this.rejected,
    this.upcoming,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Fallback to 0 if not provided
    final f = filled ?? 0;
    final a = approved ?? 0;
    final p = pending ?? 0;
    final r = rejected ?? 0;
    final u = upcoming ?? 0;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.timesheetFiled.toUpperCase(), style: AppTextStyle.statsLabel),
                      const SizedBox(height: 4),
                      isLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 28,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            )
                          : Text(l10n.weeksCount(f), style: AppTextStyle.statsValue),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                       color: AppColors.primaryFixed,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.query_stats, color: AppColors.onPrimaryFixedVariant),
                  ),
                ],
              ),
              if (weekMeta.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(weekMeta, style: AppTextStyle.statsLabel.copyWith(fontSize: 11, fontWeight: FontWeight.w500)),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _buildSmallCard(context, l10n.timesheetApproved.toUpperCase(), a, "", Icons.check_circle, AppColors.success),
            _buildSmallCard(context, l10n.timesheetPending.toUpperCase(), p, "", Icons.pending, AppColors.warning),
            _buildSmallCard(context, l10n.timesheetRejected.toUpperCase(), r, "", Icons.cancel, AppColors.error),
            _buildSmallCard(context, l10n.timesheetUpcoming.toUpperCase(), u, "", Icons.event, AppColors.primaryBlue),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallCard(BuildContext context, String label, int value, String weeks, IconData icon, Color iconColor) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 8),
              Text(label, style: AppTextStyle.statsLabel.copyWith(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 4),
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 22,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
              : Text(l10n.weeksCount(value), style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.w800, fontSize: 18)),
          const Spacer(),
          if (weeks.isNotEmpty)
            Text(
              weeks,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.statsLabel.copyWith(fontSize: 10, fontWeight: FontWeight.w500),
            ),
        ],
      ),
    );
  }
}
