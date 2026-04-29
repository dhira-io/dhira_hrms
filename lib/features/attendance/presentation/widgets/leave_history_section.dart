import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
          child: Column(
            children: [
              for (int i = 0; i < (history.length > 4 ? 4 : history.length); i++) ...[
                _LeaveHistoryCard(record: history[i]),
                if (i < (history.length > 4 ? 4 : history.length) - 1)
                  const SizedBox(height: AppConstants.p12),
              ]
            ],
          ),
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
    final dateString = DateTimeUtils.formatDateRange(
      record.fromDate,
      record.toDate,
    );
    String formatValue(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    final days = record.totalLeaveDays;
    final daysText =
        "(${formatValue(days)} ${days == 1 ? l10n.day : l10n.daysLabel})";

    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p12,
              vertical: AppConstants.p6,
            ),
            decoration: BoxDecoration(
              color: statusTheme.background,
              borderRadius: BorderRadius.circular(AppConstants.r20),
              border: Border.all(
                color: statusTheme.textColor.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Text(
              record.status.toLowerCase() ==
                      LeaveStatusConstants.open.toLowerCase()
                  ? l10n.pending
                  : record.status,
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
    if (s == LeaveStatusConstants.approved.toLowerCase()) {
      return const _StatusTheme(
        background: AppColors.approvedBg,
        textColor: AppColors.approvedText,
      );
    } else if (s == LeaveStatusConstants.cancelled.toLowerCase() ||
        s == LeaveStatusConstants.cancelledAlt.toLowerCase()) {
      return const _StatusTheme(
        background: AppColors.cancelledBg,
        textColor: AppColors.cancelledText,
      );
    } else {
      // For pending, open, rejected, draft, or any other status
      return const _StatusTheme(
        background: AppColors.pendingStatusBg,
        textColor: AppColors.pendingStatusText,
      );
    }
  }
}

class _StatusTheme {
  final Color background;
  final Color textColor;

  const _StatusTheme({required this.background, required this.textColor});
}
