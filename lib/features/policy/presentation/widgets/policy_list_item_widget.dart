import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';
import 'package:dhira_hrms/features/policy/presentation/bottom_sheets/policy_pdf_bottom_sheet.dart';

class PolicyListItemWidget extends StatelessWidget {
  const PolicyListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final index = context.read<int>();
    final policy = context.watch<PolicyEntity>();
    final l10n = AppLocalizations.of(context)!;
    final slNo = (index + 1).toString().padLeft(2, '0');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(
          color: AppColors.of(context).outlineVariant.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.p10.w,
        vertical: AppConstants.p4.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.of(context).surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppConstants.r16),
                ),
                child: Text(
                  slNo,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.of(context).onSurfaceVariant,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.p6.h),
          Text(
            policy.title.trim(),
            style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppConstants.p4.h),
          Text(
            policy.description.trim(),
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(
                context,
              ).onSurfaceVariant.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: AppConstants.p6.h),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => PolicyPdfBottomSheet.show(context, policy),
              borderRadius: BorderRadius.circular(AppConstants.r8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.of(context).primary,
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 16.sp,
                      color: AppColors.of(context).onPrimary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      l10n.view,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
