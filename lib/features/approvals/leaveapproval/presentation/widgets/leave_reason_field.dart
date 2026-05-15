import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'leave_form_elements.dart';

class LeaveReasonField extends StatelessWidget {
  final AppLocalizations l10n;
  final TextEditingController controller;

  const LeaveReasonField({
    super.key,
    required this.l10n,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeaveLabel(label: l10n.reasonForLeave),
        TextFormField(
          controller: controller,
          maxLines: 3,
          style: AppTextStyle.bodyMedium,
          decoration: InputDecoration(
            hintText: l10n.provideReasonHint,
            hintStyle: AppTextStyle.bodyMedium.copyWith(
              color: AppColors.outline.withValues(alpha: 0.5),
            ),
            filled: true,
            fillColor: AppColors.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorStyle: AppTextStyle.bodySmall.copyWith(color: Colors.red),
          ),
          validator: (val) => val == null || val.isEmpty ? l10n.required : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}
