import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class LeaveApplicationCard extends StatelessWidget {
  final LeaveEntity leave;
  final VoidCallback onDelete;

  const LeaveApplicationCard({
    super.key,
    required this.leave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.p15),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  leave.leaveType,
                  style: AppTextStyle.h3.copyWith(fontSize: 16),
                ),
                _StatusBadge(status: leave.status),
              ],
            ),
            const SizedBox(height: AppConstants.p8),
            Text(
              l10n.dateRange(leave.fromDate, leave.toDate),
              style: AppTextStyle.bodySmall.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: AppConstants.p8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.days(leave.totalLeaveDays ?? 0),
                  style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color color = Colors.blue;
    String statusText = status;

    if (status == 'Approved') {
      color = Colors.green;
      statusText = l10n.approved;
    } else if (status == 'Rejected') {
      color = Colors.red;
      statusText = l10n.rejected;
    } else if (status == 'Pending') {
      color = Colors.orange;
      statusText = l10n.pending;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p10,
        vertical: AppConstants.p4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.r20),
      ),
      child: Text(
        statusText,
        style: AppTextStyle.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

