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
    return TextFormField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Please describe the reason for your Leave request (min 10 characters)...',
        hintStyle: AppTextStyle.bodyMedium.copyWith(
          color: AppColors.of(context).outline.withValues(alpha: 0.5),
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: const BorderSide(color: Color(0xFF90A1B9), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: const BorderSide(color: Color(0xFF90A1B9), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
          borderSide: BorderSide(color: AppColors.of(context).primary, width: 1.0),
        ),
        errorStyle: AppTextStyle.bodySmall.copyWith(color: Colors.red),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
