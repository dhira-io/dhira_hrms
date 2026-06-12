import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import 'package:get/get.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/policy_entity.dart';
import '../../domain/usecases/get_policy_pdf_usecase.dart';
import '../bottom_sheets/policy_pdf_bottom_sheet.dart';
import '../cubit/policy_pdf_cubit.dart';

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
      padding: EdgeInsets.all(AppConstants.p16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.of(context).surfaceContainer,
                  borderRadius: BorderRadius.circular(AppConstants.r16),
                ),
                child: Text(
                  slNo,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.of(context).outlineVariant,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.p8.h),
          Text(
            policy.title,
            style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppConstants.p4.h),
          Text(
            policy.description,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(
                context,
              ).onSurfaceVariant.withValues(alpha: 0.8),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppConstants.p12.h),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                _showPdfBottomSheet(context, policy);
              },
              borderRadius: BorderRadius.circular(AppConstants.r8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.of(
                    context,
                  ).primaryFixed.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 16.sp,
                      color: AppColors.of(context).primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      l10n.view,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).primary,
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

  void _showPdfBottomSheet(BuildContext context, PolicyEntity policy) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider(
          create: (_) =>
              PolicyPdfCubit(Get.find<GetPolicyPdfUseCase>())
                ..loadPdf(policy.fileUrl),
          child: PolicyPdfBottomSheet(
            title: policy.title,
            fileUrl: policy.fileUrl,
          ),
        );
      },
    );
  }
}
