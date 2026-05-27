import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/timesheet_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'timesheet_info_row.dart';
import 'package:go_router/go_router.dart';

class TimesheetCard extends StatelessWidget {
  final TimesheetEntity ts;

  const TimesheetCard({super.key, required this.ts});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p16),
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLow,
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
          TimesheetInfoRow(
            label: l10n.employeeName,
            value: ts.employeeName ?? AppConstants.placeholderText,
          ),
          TimesheetInfoRow(
            label: l10n.fromDate,
            value: DateTimeUtils.formatDateString(ts.fromDate),
          ),
          TimesheetInfoRow(
            label: l10n.toDate,
            value: DateTimeUtils.formatDateString(ts.toDate),
          ),
          TimesheetInfoRow(
            label: l10n.statusLabel,
            valueWidget: _StatusBadge(docStatus: ts.docStatus),
          ),
          TimesheetInfoRow(
            label: l10n.organizations,
            value: ts.department ?? AppConstants.placeholderText,
          ),
          TimesheetInfoRow(label: l10n.approver, value: ts.approverName ?? AppConstants.placeholderText),
          const SizedBox(height: AppConstants.p12),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () =>
                    context.push(AppRouter.applyTimesheetPath, extra: ts.name),
                icon: Icon(
                  Icons.edit,
                  size: 18,
                  color: AppColors.of(context).white,
                ),
                label: Text(
                  l10n.edit,
                  style: AppTextStyle.button.copyWith(
                    color: AppColors.of(context).white,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.of(context).primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r8),
                  ),
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
}

class _StatusBadge extends StatelessWidget {
  final int docStatus;

  const _StatusBadge({required this.docStatus});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final status = docStatus == 0 ? l10n.draft : l10n.saved;
    final color = docStatus == 0
        ? AppColors.of(context).warning
        : AppColors.of(context).success;

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
