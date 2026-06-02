import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import 'salary_action_card.dart';
class SalarySection extends StatelessWidget {
  const SalarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.salary,
          style: AppTextStyle.h3.copyWith(
            fontSize: AppConstants.p16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.p16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _SalaryActionCard(
                icon: Icons.receipt_long_outlined,
                label: l10n.payslip,
                subtitle: l10n.homepayslipSubtitle,
                iconBgColor: AppColors.of(context).iconbgviolet,
                iconColor: AppColors.of(context).brandPurple,
                onTap: () {
                  context.push(AppRouter.payslipPath);
                },
              ),
            ),
            const SizedBox(width: AppConstants.p16),
            const Spacer(), // Empty space for the 2nd column
          ],
        ),
      ],
    );
  }
}

class _SalaryActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _SalaryActionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        child: Ink(
          padding: const EdgeInsets.all(AppConstants.p10),
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppConstants.r16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: AppConstants.iconXXSmall,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.p16),
              Text(
                label,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.f12.sp,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConstants.p4),
              Text(
                subtitle,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.of(context).textSecondary,
                  fontSize: AppConstants.f10.sp,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
