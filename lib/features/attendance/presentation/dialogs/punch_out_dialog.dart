import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../core/utils/date_time_utils.dart';

void showPunchOutDialog({
  required BuildContext context,
  required int Function() getWorkedSeconds,
  required VoidCallback onConfirm,
}) {
  final l10n = AppLocalizations.of(context)!;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.of(context).surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (BuildContext bottomSheetContext) {
      final colors = AppColors.of(context);
      return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (sbContext, snapshot) {
          final currentTotal = Duration(seconds: getWorkedSeconds());
          final formattedTime = DateTimeUtils.formatDuration(currentTotal);
          final isLess = currentTotal.inMinutes < (9 * 60 + 30);
          final title = isLess ? l10n.earlyLogoutWarningTitle : l10n.confirmLogout;

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: colors.outlineVariant,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: colors.errorContainer, // Light red background
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: colors.error, // Red icon
                      size: 24.w,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.h3.copyWith(
                      color: colors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    l10n.earlyLogoutConfirmationMessage(formattedTime),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bodyLarge.copyWith(
                      color: colors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CommonButton(
                    text: l10n.yesLogOut,
                    variant: ButtonVariant.outlined,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    width: double.infinity,
                  ),
                  SizedBox(height: 12.h),
                  CommonButton(
                    text: l10n.cancel,
                    variant: ButtonVariant.primary,
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: colors.primary,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
