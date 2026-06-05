import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../l10n/app_localizations.dart';

class CommonFormDialog extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final VoidCallback onSave;

  final GlobalKey<FormState>? formKey;

  const CommonFormDialog({
    super.key,
    required this.title,
    required this.fields,
    required this.onSave,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: fields,
    );

    if (formKey != null) {
      content = Form(
        key: formKey,
        child: content,
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      actionsPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
      titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      title: Text(
        title,
        style: AppTextStyle.h3.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
      content: SingleChildScrollView(
        child: content,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color:
                        isDark
                            ? AppColors.of(context).slate600
                            : AppColors.of(context).slate300,
                  ),
                  minimumSize: Size(0, 44.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  backgroundColor:
                      isDark
                          ? AppColors.of(context).surface
                          : AppColors.of(context).white,
                ),
                child: Text(
                  l10n.cancel,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        isDark
                            ? AppColors.of(context).white
                            : AppColors.of(context).slate700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.of(context).primary,
                  foregroundColor: AppColors.of(context).white,
                  elevation: 0,
                  minimumSize: Size(0, 44.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  l10n.save,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
