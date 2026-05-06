import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/timesheet_entities.dart';
import 'timesheet_info_row.dart';
import 'package:go_router/go_router.dart';

class TimesheetCard extends StatelessWidget {
  final TimesheetEntity ts;

  const TimesheetCard({
    super.key,
    required this.ts,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p16),
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimesheetInfoRow(label: l10n.id, value: ts.name),
          TimesheetInfoRow(label: l10n.employeeName, value: ts.employeeName ?? "—"),
          TimesheetInfoRow(label: l10n.fromDate, value: DateTimeUtils.formatDateString(ts.fromDate)),
          TimesheetInfoRow(label: l10n.toDate, value: DateTimeUtils.formatDateString(ts.toDate)),
          TimesheetInfoRow(
            label: l10n.statusLabel,
            valueWidget: _buildStatusBadge(context, ts.docStatus),
          ),
          TimesheetInfoRow(label: l10n.organizations, value: ts.department ?? "—"),
          TimesheetInfoRow(label: l10n.approver, value: ts.approverName ?? "—"),
          const SizedBox(height: AppConstants.p12),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () => context.push(
                  AppRouter.applyTimesheetPath,
                  extra: ts.name,
                ),
                icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                label: Text(
                  l10n.edit,
                  style: AppTextStyle.button.copyWith(color: Colors.white, fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r8)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, int docStatus) {
    final l10n = AppLocalizations.of(context)!;
    final status = docStatus == 0 ? l10n.draft : l10n.saved;
    final color = docStatus == 0 ? AppColors.warning : AppColors.success;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p10,
        vertical: AppConstants.p4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.p4),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Text(
        status,
        style: AppTextStyle.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
