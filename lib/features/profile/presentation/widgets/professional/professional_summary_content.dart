import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';

class ProfessionalSummaryContent extends StatelessWidget {
  final TextEditingController summaryController;
  final TextEditingController awardsController;

  const ProfessionalSummaryContent({
    super.key,
    required this.summaryController,
    required this.awardsController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: AppLocalizations.of(context)!.professionalSummary,
        ),
        SizedBox(height: 8.h),
        _TextArea(controller: summaryController),
        SizedBox(height: 16.h),
        _SectionHeader(title: AppLocalizations.of(context)!.awardsAchievements),
        SizedBox(height: 8.h),
        _TextArea(controller: awardsController),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

    return Text(
      title,
      style: AppTextStyle.bodySmall.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: isDark ? colors.slate400 : colors.slate500,
      ),
    );
  }
}

class _TextArea extends StatelessWidget {
  final TextEditingController controller;

  const _TextArea({required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDark ? colors.surfaceContainerLow : colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isDark ? colors.border : colors.slate200,
              width: 1.w,
            ),
          ),
          child: Stack(
            children: [
              TextFormField(
                controller: controller,
                maxLines: 4,
                minLines: 3,
                inputFormatters: [LengthLimitingTextInputFormatter(350)],
                style: AppTextStyle.bodyMedium.copyWith(
                  color: isDark ? colors.slate200 : colors.slate700,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.w),
                  isDense: true,
                ),
              ),
              Positioned(
                bottom: 4.h,
                right: 4.w,
                child: Icon(
                  Icons.signal_cellular_4_bar,
                  size: 12.sp,
                  color: isDark ? colors.slate500 : colors.slate400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, child) {
            int charCount = value.text.length;
            return Text(
              "$charCount / 350 characters",
              style: AppTextStyle.bodySmall.copyWith(
                color: charCount >= 350
                    ? colors.error
                    : (isDark ? colors.slate400 : colors.slate400),
                fontSize: 10.sp,
              ),
            );
          },
        ),
      ],
    );
  }
}
