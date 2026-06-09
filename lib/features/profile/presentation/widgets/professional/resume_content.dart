import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../l10n/app_localizations.dart';

class ResumeContent extends StatelessWidget {
  final String resumeFileName;
  final String resumeLastUpdated;
  final VoidCallback onDownload;
  final VoidCallback onReplace;

  const ResumeContent({
    super.key,
    required this.resumeFileName,
    required this.resumeLastUpdated,
    required this.onDownload,
    required this.onReplace,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.of(context).surface
            : AppColors.of(context).surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark
              ? AppColors.of(context).slate700
              : AppColors.of(context).slate200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.of(context).error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.picture_as_pdf,
              color: AppColors.of(context).error,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resumeFileName,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  resumeLastUpdated,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.of(context).slate400
                        : AppColors.of(context).slate500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.download_outlined, size: 20.sp),
                onPressed: onDownload,
                color: AppColors.of(context).primary,
                tooltip: l10n.download,
              ),
              IconButton(
                icon: Icon(Icons.file_upload_outlined, size: 20.sp),
                onPressed: onReplace,
                color: AppColors.of(context).primary,
                tooltip: l10n.replace,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
