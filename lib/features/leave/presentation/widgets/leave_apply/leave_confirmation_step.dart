import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveConfirmationStep extends StatelessWidget {
  final VoidCallback onMyRequests;
  final VoidCallback onBackToHome;

  const LeaveConfirmationStep({
    super.key,
    required this.onMyRequests,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.minHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 46.w,
                    height: 46.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.success,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: 24.w,
                        color: colors.success,
                      ),
                    ),
                  ),
                  SizedBox(height: AppConstants.p24.h),
                  Text(
                    l10n.requestSubmitted,
                    style: AppTextStyle.headlineSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                  SizedBox(height: AppConstants.p16.h),
                  Text(
                    l10n.leaveSubmitSuccess,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: colors.outline,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          text: l10n.myRequests,
                          variant: ButtonVariant.outlined,
                          textStyle: AppTextStyle.bodyLarge.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          onPressed: onMyRequests,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CommonButton(
                          text: l10n.backToHome,
                          onPressed: onBackToHome,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
