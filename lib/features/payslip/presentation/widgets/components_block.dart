import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/payslip_entities.dart';

class ComponentsBlock extends StatelessWidget {
  final String title;
  final List<SalaryComponentEntity> components;
  final double total;
  final NumberFormat formatter;
  final Color accentColor;
  final bool isEarnings;
  final String totalLabel;

  const ComponentsBlock({
    super.key,
    required this.title,
    required this.components,
    required this.total,
    required this.formatter,
    required this.accentColor,
    required this.isEarnings,
    required this.totalLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(color: AppColors.of(context).border),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Solid Premium Header with White Text
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p16,
              vertical: AppConstants.p14,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor, accentColor.withValues(alpha: 0.9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: double.infinity,
            child: Text(
              title,
              style: AppTextStyle.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // Component Rows
          Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (components.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.p8,
                    ),
                    child: Text(
                      AppConstants.placeholderText,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).textSecondary,
                      ),
                    ),
                  )
                else ...[
                  for (int i = 0; i < components.length; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            components[i].component,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.of(context).textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          formatter.format(components[i].amount),
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.of(context).textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (i < components.length - 1) ...[
                      const SizedBox(height: AppConstants.p12),
                      Divider(
                        color: AppColors.of(
                          context,
                        ).border.withValues(alpha: 0.5),
                        height: 1.h,
                      ),
                      const SizedBox(height: AppConstants.p12),
                    ],
                  ],
                ],
                // Divider before bottom total row
                const SizedBox(height: AppConstants.p12),
                Divider(color: AppColors.of(context).border, height: 1.h),
                const SizedBox(height: AppConstants.p12),
                // Bottom Total Row matching image
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      totalLabel,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: AppColors.of(context).textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      formatter.format(total),
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
