import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/data/constants/approvals_api_constants.dart';
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
        color: AppColors.of(context).surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Column(
        children: data.displayDetails.entries.map((entry) {
          final bool isLast = data.displayDetails.keys.last == entry.key;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.p4),
                child: _DetailRow(
                  label: entry.key,
                  value: entry.value,
                  onViewComments: onViewComments,
                  onOpenAttachment: onOpenAttachment,
                  onShowContent: onShowContent,
                ),
              ),
              if (!isLast)
                Divider(
                  height: AppConstants.p16,
                  color: AppColors.of(context).border,
                ),
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

    final bool isViewable =
        lowerLabel == RequestDetailKeys.reason ||
        lowerLabel == RequestDetailKeys.attachments ||
        lowerLabel == RequestDetailKeys.comments ||
        lowerLabel == RequestDetailKeys.remarks;

    String localizedLabel = ApprovalsApiConstants.getLocalizedLabel(l10n, label);
    localizedLabel = localizedLabel.replaceAll(":", "").trim();

    String localizedValue = ApprovalsApiConstants.getLocalizedValue(l10n, lowerLabel, value);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizedLabel,
          style: AppTextStyle.labelMedium.copyWith(
            color: AppColors.of(context).onSurfaceVariant,
          ),
        ),
              SizedBox(width: 16.w),
        if (isViewable && value != AppConstants.noneValue && value != AppConstants.naValue)
          GestureDetector(
            onTap: () {
              if (lowerLabel == RequestDetailKeys.comments) {
                onViewComments();
              } else if (lowerLabel == RequestDetailKeys.attachments || lowerLabel == RequestDetailKeys.attachment) {
                onOpenAttachment();
              } else {
                onShowContent(localizedLabel, localizedValue);
              }
            },
            child: Text(
              l10n.view,
              style: AppTextStyle.labelLarge.copyWith(
                color: AppColors.of(context).primary,
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
                color: AppColors.of(context).onSurface,
              ),
            ),
          ),
      ],
    );
  }
}
