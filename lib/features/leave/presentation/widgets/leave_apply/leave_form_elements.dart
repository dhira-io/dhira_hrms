import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';

class LeaveFormSectionTitle extends StatelessWidget {
  final String title;

  const LeaveFormSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.h3.copyWith(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.bold,
        color: AppColors.of(context).onSurface,
      ),
    );
  }
}

class LeaveFormLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const LeaveFormLabel({super.key, required this.label, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 6.h),
      child: RichText(
        text: TextSpan(
          text: label,
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.of(context).onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
          children: [
            if (isRequired)
              TextSpan(
                text: '*',
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.of(context).error,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
