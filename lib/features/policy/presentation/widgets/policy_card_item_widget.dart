import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';
import 'package:dhira_hrms/features/policy/presentation/bottom_sheets/policy_pdf_bottom_sheet.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PolicyCardItemWidget extends StatelessWidget {
  const PolicyCardItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final policy = context.watch<PolicyEntity>();
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(
          color: AppColors.of(context).outlineVariant.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppColors.of(context).transparent,
        child: InkWell(
          onTap: () {
            _showPdfBottomSheet(context, policy);
          },
          borderRadius: BorderRadius.circular(AppConstants.r16),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.p8.w,
              vertical: AppConstants.p4.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppConstants.p8.w),
                      decoration: BoxDecoration(
                        color: AppColors.of(
                          context,
                        ).primaryFixed.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(AppConstants.r12),
                      ),
                      child: Icon(
                        Icons.article_outlined,
                        color: AppColors.of(context).primary,
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(height: AppConstants.p8.h),
                    Text(
                      policy.title,
                      style: AppTextStyle.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppConstants.p4.h),
                    Text(
                      policy.description.trim(),
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: AppConstants.p12.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).surfaceContainerLow,
                      borderRadius: BorderRadius.circular(AppConstants.r8),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.readPolicy,
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.of(context).primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: AppConstants.p4.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10.sp,
                          color: AppColors.of(context).primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPdfBottomSheet(BuildContext context, PolicyEntity policy) {
    PolicyPdfBottomSheet.show(context, policy);
  }
}
