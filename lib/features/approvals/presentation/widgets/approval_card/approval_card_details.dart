import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ApprovalCardDetails extends StatelessWidget {
  final ApprovalRequestEntity data;
  final VoidCallback onViewComments;
  final VoidCallback onOpenAttachment;
  final Function(String, String) onShowContent;

  const ApprovalCardDetails({
    super.key,
    required this.data,
    required this.onViewComments,
    required this.onOpenAttachment,
    required this.onShowContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Column(
        children: data.displayDetails.entries.map((entry) {
          final bool isLast = data.displayDetails.keys.last == entry.key;
          return Column(
            children: [
              _DetailRow(
                label: entry.key,
                value: entry.value,
                onViewComments: onViewComments,
                onOpenAttachment: onOpenAttachment,
                onShowContent: onShowContent,
              ),
              if (!isLast) const Divider(height: AppConstants.p16, color: AppColors.border),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onViewComments;
  final VoidCallback onOpenAttachment;
  final Function(String, String) onShowContent;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.onViewComments,
    required this.onOpenAttachment,
    required this.onShowContent,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String lowerLabel = label.toLowerCase();

    final bool isViewable = lowerLabel == 'reason' ||
        lowerLabel == 'attachments' ||
        lowerLabel == 'comments' ||
        lowerLabel == 'remarks';

    String localizedLabel = _getLocalizedLabel(l10n, label);
    localizedLabel = localizedLabel.replaceAll(":", "").trim();

    String localizedValue = _getLocalizedValue(l10n, lowerLabel, value);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizedLabel, style: AppTextStyle.labelMedium.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(width: 16),
        if (isViewable && value != "None" && value != "N/A")
          GestureDetector(
            onTap: () {
              if (lowerLabel == 'comments') {
                onViewComments();
              } else if (lowerLabel == 'attachments') {
                onOpenAttachment();
              } else {
                onShowContent(localizedLabel, localizedValue);
              }
            },
            child: Text(
              l10n.view,
              style: AppTextStyle.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        else
          Flexible(
            child: Text(
              localizedValue,
              textAlign: TextAlign.right,
              style: AppTextStyle.labelLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
          ),
      ],
    );
  }

  String _getLocalizedLabel(AppLocalizations l10n, String label) {
    switch (label) {
      case 'Leave Type': return l10n.leaveType;
      case 'From Date': return l10n.fromDate;
      case 'To Date': return l10n.toDate;
      case 'Days': return l10n.daysLabel;
      case 'Reason': return l10n.reason;
      case 'Date': return l10n.date;
      case 'In Time': return l10n.inTimeLabel;
      case 'Out Time': return l10n.outTimeLabel;
      case 'Attachments': return l10n.attachmentsLabel;
      case 'Week': return l10n.week;
      case 'Expected': return l10n.expectedLabel;
      case 'Actual': return l10n.actualLabel;
      case 'Projects': return l10n.projectsLabel;
      case 'Worked Date': return l10n.workedDateLabel;
      case 'Hours': return l10n.hoursLabel;
      case 'Req ID': return l10n.reqIdLabel;
      case 'Comments': return l10n.commentsLabel;
      case 'Week Range': return l10n.weekRangeLabel;
      case 'Total Hours': return l10n.totalHours("");
      case 'Submitted Date': return l10n.submittedDateLabel;
      case 'Approver': return l10n.approver;
      case 'Remarks': return l10n.remarksLabel;
      case 'Comp-off Date': return l10n.compOffDateLabel;
      case 'Day Segment': return l10n.daySegment;
      default: return label;
    }
  }

  String _getLocalizedValue(AppLocalizations l10n, String lowerLabel, String value) {
    if (value == "Unknown" || value == "N/A") {
      return l10n.notAvailable;
    } else if (value == "None") {
      return l10n.noneLabel;
    } else if (lowerLabel.contains('hours') || lowerLabel == 'expected' || lowerLabel == 'actual') {
      return "$value ${l10n.hoursLabel}";
    } else if (lowerLabel == 'days') {
      return "$value ${l10n.daysLabel}";
    }
    return value;
  }
}
