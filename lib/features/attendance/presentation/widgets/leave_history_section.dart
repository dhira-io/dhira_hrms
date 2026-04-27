import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/leave_constants.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/leave_history_entity.dart';

class LeaveHistorySection extends StatelessWidget {
  final List<LeaveHistoryEntity> history;

  const LeaveHistorySection({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (history.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                l10n.leaveHistory,
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              if (history.length > 4)
                TextButton(
                  onPressed: () {
                    // TODO: Implement navigation to full history
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    l10n.viewAll,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.p16),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length > 4 ? 4 : history.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppConstants.p12),
          itemBuilder: (context, index) {
            return _LeaveHistoryCard(record: history[index]);
          },
        ),
        const SizedBox(height: AppConstants.p24),
      ],
    );
  }
}

class _LeaveHistoryCard extends StatelessWidget {
  final LeaveHistoryEntity record;

  const _LeaveHistoryCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusTheme = _getStatusTheme(record.status);
    final dateString = DateTimeUtils.formatDateRange(record.fromDate, record.toDate);
    final days = record.totalLeaveDays ?? 0.0;
    final daysText =
        "(${days.toInt()} ${days == 1 ? l10n.day : l10n.daysLabel})";

    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.leaveType,
                  style: AppTextStyle.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$dateString $daysText",
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusTheme.background,
              borderRadius: BorderRadius.circular(AppConstants.r20),
            ),
            child: Text(
              record.status,
              style: AppTextStyle.bodySmall.copyWith(
                color: statusTheme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _StatusTheme _getStatusTheme(String status) {
    final s = status.toLowerCase();
    if (s == 'approved') {
      return const _StatusTheme(
        background: AppColors.approvedBg,
        textColor: AppColors.approvedText,
      );
    } else if (s == 'open' || s == 'pending') {
      return const _StatusTheme(
        background: AppColors.pendingStatusBg,
        textColor: AppColors.pendingStatusText,
      );
    } else if (s == 'rejected') {
      return const _StatusTheme(
        background: AppColors.rejectedBg,
        textColor: AppColors.rejectedText,
      );
    } else if (s == 'cancelled' || s == 'canceled') {
      return const _StatusTheme(
        background: AppColors.absentBg,
        textColor: AppColors.absentText,
      );
    } else if (s == 'draft') {
      return const _StatusTheme(
        background: AppColors.slateBg,
        textColor: AppColors.slateText,
      );
    } else {
      return const _StatusTheme(
        background: AppColors.border,
        textColor: AppColors.textSecondary,
      );
    }
  }
}

class _StatusTheme {
  final Color background;
  final Color textColor;

  const _StatusTheme({required this.background, required this.textColor});
}
