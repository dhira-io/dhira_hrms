import 'package:flutter/material.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("PROFESSIONAL SUMMARY", isDark, context),
        SizedBox(height: 8.h),
        _buildTextArea(summaryController, isDark, context),
        SizedBox(height: 16.h),
        _buildSectionHeader("AWARDS & ACHIEVEMENTS", isDark, context),
        SizedBox(height: 8.h),
        _buildTextArea(awardsController, isDark, context),
      ],
    );
  }

  Widget _buildSectionHeader(String title, bool isDark, BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.bodySmall.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: isDark ? AppColors.of(context).slate400 : const Color(0xFF64748B),
      ),
    );
  }

  Widget _buildTextArea(TextEditingController controller, bool isDark, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.of(context).surfaceContainerLow : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isDark ? AppColors.of(context).border : const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              TextFormField(
                controller: controller,
                maxLines: 4,
                minLines: 3,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(350),
                ],
                style: AppTextStyle.bodyMedium.copyWith(
                  color: isDark ? AppColors.of(context).slate200 : const Color(0xFF334155),
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
                  color: isDark ? AppColors.of(context).slate500 : const Color(0xFF94A3B8),
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
                    ? AppColors.of(context).error
                    : (isDark ? AppColors.of(context).slate400 : const Color(0xFF94A3B8)),
                fontSize: 10.sp,
              ),
            );
          },
        ),
      ],
    );
  }
}
