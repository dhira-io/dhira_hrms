import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../l10n/app_localizations.dart';

class LeaveReasonField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const LeaveReasonField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: l10n.provideReasonHint,
        hintStyle: AppTextStyle.bodyMedium.copyWith(color: AppColors.outline.withValues(alpha: 0.5)),
        filled: true,
        fillColor: AppColors.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide.none,
        ),
        errorStyle: AppTextStyle.bodySmall.copyWith(color: Colors.red),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
