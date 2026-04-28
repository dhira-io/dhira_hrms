import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class RegularizationDocumentsSection extends StatelessWidget {
  final String? selectedFileName;
  final String? uploadedFileUrl;
  final bool isUploading;
  final VoidCallback onPickFile;
  final VoidCallback onDelete;

  const RegularizationDocumentsSection({
    super.key,
    required this.selectedFileName,
    required this.uploadedFileUrl,
    required this.isUploading,
    required this.onPickFile,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.supportingDocsOptional,
          style: AppTextStyle.labelSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.p24),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppConstants.r12),
            border: Border.all(
              color: AppColors.outlineVariant,
              style: BorderStyle.none,
            ),
          ),
          child: Column(
            children: [
              if (isUploading)
                const CircularProgressIndicator()
              else if (uploadedFileUrl != null) ...[
                const Icon(
                  Icons.check_circle,
                  color: AppColors.approvedText,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.fileUploaded,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.p12,
                    vertical: AppConstants.p8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.r8),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          uploadedFileUrl!,
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontSize: 10,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.absentText,
                        ),
                        onPressed: onDelete,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  child: const Icon(
                    Icons.cloud_upload,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selectedFileName ?? l10n.uploadPhotosOrLogs,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: selectedFileName != null
                        ? AppColors.primary
                        : AppColors.onSurfaceVariant,
                    fontWeight: selectedFileName != null
                        ? FontWeight.bold
                        : null,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: onPickFile,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.outlineVariant),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.p16,
                      vertical: AppConstants.p6,
                    ),
                  ),
                  child: Text(
                    l10n.browseFiles,
                    style: AppTextStyle.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
