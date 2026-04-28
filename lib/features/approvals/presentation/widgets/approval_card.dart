import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';

class ApprovalCard extends StatelessWidget {
  final ApprovalRequestEntity data; // Add this required parameter

  const ApprovalCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=ronald'),
              ),
              const SizedBox(width: AppConstants.p12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ronald Richards',
                      style: AppTextStyle.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      'Senior Designer • Design Team',
                      style: AppTextStyle.labelMedium.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.p8, vertical: AppConstants.p4),
                decoration: BoxDecoration(
                  color: AppColors.warningBg,
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                ),
                child: Text(
                  'PENDING',
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.warning,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p16),
          Container(
            padding: const EdgeInsets.all(AppConstants.p12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Column(
              children: [
                _buildDetailRow(l10n.leaveType, 'Sick Leave'),
                const Divider(height: AppConstants.p16, color: AppColors.border),
                _buildDetailRow(l10n.dateRangeLabel, 'Jan 05 - Jan 05'),
                const Divider(height: AppConstants.p16, color: AppColors.border),
                _buildDetailRow(l10n.duration, '01 Day'),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.p12),
                  ),
                  child: Text(
                    l10n.reject,
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.p12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.success,
                    side: const BorderSide(color: AppColors.success),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.p12),
                  ),
                  child: Text(
                    l10n.approve,
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.p12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryFixed,
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.chat_bubble, color: AppColors.primary, size: 20),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.labelMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.labelLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
      ],
    );
  }
}
