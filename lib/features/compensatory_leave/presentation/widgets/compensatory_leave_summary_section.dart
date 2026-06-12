import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/compensatory_leave/presentation/bloc/compensatory_leave_bloc.dart';

class CompensatoryLeaveSummarySection extends StatelessWidget {
  const CompensatoryLeaveSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final summary = context.select(
      (CompensatoryLeaveBloc bloc) => bloc.state.summary,
    );

    if (summary == null) {
      return const SizedBox.shrink();
    }

    String formatValue(double value) {
      if (value == value.toInt()) {
        return value.toInt().toString();
      }
      return value.toStringAsFixed(1);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.balanceSummary,
          style: AppTextStyle.h3.copyWith(
            fontSize: AppConstants.fs12.sp,
            color: AppColors.of(context).textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CompensatoryLeaveSummaryCard(
                  title: l10n.availableBalance,
                  value:
                      "${formatValue(summary.availableBalance)} ${l10n.daysLabel.toLowerCase()}",
                  icon: Icons.calendar_today_outlined,
                  textColor: AppColors.of(context).primary,
                  bgColor: AppColors.of(context).infoBg,
                  borderColor: AppColors.of(context).infoBorder,
                  subtitle: l10n.daysLabel,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CompensatoryLeaveSummaryCard(
                  title: l10n.raisedRequests,
                  value:
                      "${formatValue(summary.raisedRequest)} ${l10n.daysLabel.toLowerCase()}",
                  icon: Icons.mail_outline_rounded,
                  textColor: AppColors.of(context).pendingStatusText,
                  bgColor: AppColors.of(context).pendingStatusBg,
                  borderColor: AppColors.of(context).warningBorder,
                  subtitle: l10n.pendingApproval,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CompensatoryLeaveSummaryCard(
                  title: l10n.expiringSoon,
                  value:
                      "${formatValue(summary.expiringSoon)} ${l10n.daysLabel.toLowerCase()}",
                  icon: Icons.warning_amber_rounded,
                  textColor: AppColors.of(context).rejectedText,
                  bgColor: AppColors.of(context).rejectedBg,
                  borderColor: AppColors.of(context).errorBorder,
                  subtitle: summary.expiringSoon > 0
                      ? l10n.expiresInDays(summary.expiringSoon.toInt())
                      : l10n.noExpiry,
                ),
              ),
              SizedBox(width: 10.w),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }
}

class CompensatoryLeaveSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color textColor;
  final Color bgColor;
  final Color borderColor;
  final String subtitle;

  const CompensatoryLeaveSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.textColor,
    required this.bgColor,
    required this.borderColor,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).textSecondary,
                    fontSize: AppConstants.fs11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, color: textColor, size: 16.sp),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            value,
            style: AppTextStyle.h2.copyWith(
              fontSize: AppConstants.fs16.sp,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).textSecondary,
              fontSize: AppConstants.fs9.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
