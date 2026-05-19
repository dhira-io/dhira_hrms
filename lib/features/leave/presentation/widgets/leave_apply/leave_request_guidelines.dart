import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../l10n/app_localizations.dart';

class LeaveRequestGuidelines extends StatelessWidget {
  const LeaveRequestGuidelines({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColors.of(context).outlineVariant, height: 1),
        const SizedBox(height: AppConstants.p24),
        Text(
          l10n.leaveRequestGuidelines.toUpperCase(),
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.of(context).outline,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: AppConstants.p12),
        _buildGuidelineItem(l10n.guideline1,context),
        const SizedBox(height: AppConstants.p8),
        _buildGuidelineItem(l10n.guideline2,context),
        const SizedBox(height: AppConstants.p8),
        _buildGuidelineItem(l10n.guideline3,context),
        const SizedBox(height: AppConstants.p8),
        _buildGuidelineItem(l10n.guideline4,context),
        const SizedBox(height: AppConstants.p8),
        _buildGuidelineItem(l10n.guideline5,context),
        const SizedBox(height: AppConstants.p8),
        _buildGuidelineItem(l10n.guideline6,context),
      ],
    );
  }

  Widget _buildGuidelineItem(String text, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration:  BoxDecoration(
            color: AppColors.of(context).primary,
            shape:  BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppConstants.p12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).onSurfaceVariant,
              height: 1.5,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
