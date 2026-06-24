import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveReasonField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const LeaveReasonField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    
    return TextFormField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: l10n.provideReasonHint,
        hintStyle: AppTextStyle.bodyMedium.copyWith(
          color: colors.outline.withValues(alpha: 0.5),
        ),
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide(color: colors.outlineVariant, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide(color: colors.outlineVariant, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide(color: colors.primary, width: 1.0),
        ),
        errorStyle: AppTextStyle.bodySmall.copyWith(color: colors.error),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
