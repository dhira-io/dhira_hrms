import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../l10n/app_localizations.dart';
import '../dashed_border_painter.dart';

class LeaveSupportingDocsUpload extends StatelessWidget {
  final bool isUploading;
  final String? uploadedFileUrl;
  final String? uploadError;
  final String? selectedFileName;
  final VoidCallback onPickFile;

  const LeaveSupportingDocsUpload({
    super.key,
    required this.isUploading,
    required this.uploadedFileUrl,
    required this.uploadError,
    required this.selectedFileName,
    required this.onPickFile,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        CustomPaint(
          painter: DashedBorderPainter(
            color: AppColors.of(context).outlineVariant,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.p24),
            decoration: BoxDecoration(
              color: AppColors.of(
                context,
              ).surfaceContainerLowest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.p12),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).primaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: isUploading
                      ? SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.of(context).primary,
                          ),
                        )
                      : Icon(
                          uploadedFileUrl != null
                              ? Icons.check_circle_outline
                              : Icons.cloud_upload_outlined,
                          color: uploadedFileUrl != null
                              ? Colors.green
                              : AppColors.of(context).primary,
                        ),
                ),
                const SizedBox(height: AppConstants.p12),
                Text(
                  selectedFileName ?? l10n.dragAndDrop,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: uploadedFileUrl != null
                        ? Colors.green
                        : AppColors.of(context).onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                      SizedBox(height: 4.h),
                Text(
                  "Max size is 5MB (pdf, png, jpg)",
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(
                      context,
                    ).onSurfaceVariant.withValues(alpha: 0.6),
                    fontSize: 10.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (uploadError != null) ...[
                  const SizedBox(height: AppConstants.p8),
                  Text(
                    uploadError!,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: Colors.red,
                      fontSize: 10.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: AppConstants.p8),
                ElevatedButton(
                  onPressed: isUploading ? null : onPickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.of(context).primary,
                    elevation: 0,
                    side: BorderSide(
                      color: AppColors.of(
                        context,
                      ).primary.withValues(alpha: 0.2),
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    uploadedFileUrl != null
                        ? l10n.changeFile
                        : l10n.browseFiles,
                    style: AppTextStyle.button.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.of(context).primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppConstants.p20),
        // Medical Warning
        Container(
          padding: const EdgeInsets.all(AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.of(
              context,
            ).tertiaryContainer.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.of(context).tertiaryContainer,
                size: 20,
              ),
              const SizedBox(width: AppConstants.p12),
              Expanded(
                child: Text(
                  l10n.medicalWarning,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).tertiary,
                    height: 1.5.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
