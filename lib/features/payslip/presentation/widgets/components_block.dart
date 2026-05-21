import 'package:flutter/material.dart';
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

  const ComponentsBlock({
    super.key,
    required this.title,
    required this.components,
    required this.total,
    required this.formatter,
    required this.accentColor,
    required this.isEarnings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.p16, vertical: AppConstants.p14),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppConstants.r16)),
            ),
            child: Row(
              children: [
                Icon(
                  isEarnings
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  color: accentColor,
                  size: 18,
                ),
                const SizedBox(width: AppConstants.p8),
                Text(
                  title,
                  style: AppTextStyle.labelLarge.copyWith(
                      color: accentColor, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  formatter.format(total),
                  style: AppTextStyle.labelLarge.copyWith(
                      color: accentColor, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          // Rows
          if (components.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Text(AppConstants.placeholderText,
                  style: AppTextStyle.bodySmall
                      .copyWith(color: AppColors.of(context).textSecondary)),
            )
          else
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                children: [
                  for (int i = 0; i < components.length; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            components[i].component,
                            style: AppTextStyle.bodySmall
                                .copyWith(color: AppColors.of(context).textSecondary),
                          ),
                        ),
                        Text(
                          formatter.format(components[i].amount),
                          style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.of(context).textPrimary,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    if (i < components.length - 1) ...[
                      const SizedBox(height: AppConstants.p10),
                      Divider(color: AppColors.of(context).border, height: 1),
                      const SizedBox(height: AppConstants.p10),
                    ],
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
