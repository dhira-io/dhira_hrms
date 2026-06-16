import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_button.dart';

void showPunchOutDialog({
  required BuildContext context,
  required int Function() getWorkedSeconds,
  required VoidCallback onConfirm,
}) {
  final l10n = AppLocalizations.of(context)!;

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (BuildContext bottomSheetContext) {
      return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (sbContext, snapshot) {
          final currentTotal = Duration(seconds: getWorkedSeconds());
          final formattedTime = formatDuration(currentTotal);
          final isLess = currentTotal.inMinutes < (9 * 60 + 30);
          final title = isLess ? "You are Logging out before completing\n9 hours 30mins" : l10n.confirmLogout;

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
                      color: const Color(0xFFCAD5E2),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEF2F2), // Light red background
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: const Color(0xFFEF4444), // Red icon
                      size: 24.w,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: const Color(0xFF020618),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "You have worked $formattedTime hours. Are you sure you\nwant to logout?",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: const Color(0xFF62748E),
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CommonButton(
                    text: "Yes, Log Out",
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
                    text: "Cancel",
                    variant: ButtonVariant.primary,
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    backgroundColor: const Color(0xFF155DFC),
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
