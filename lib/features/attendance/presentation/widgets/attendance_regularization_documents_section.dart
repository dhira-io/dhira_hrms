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
          l10n.supportingDocuments,
          style: AppTextStyle.labelLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.p12),
        if (uploadedFileUrl != null)
          _UploadedDropZone(
            fileName: selectedFileName ?? l10n.fileUploaded,
            onDelete: onDelete,
          )
        else
          _EmptyDropZone(
            isUploading: isUploading,
            onPickFile: onPickFile,
          ),
      ],
    );
  }
}

class _EmptyDropZone extends StatelessWidget {
  final bool isUploading;
  final VoidCallback onPickFile;

  const _EmptyDropZone({
    required this.isUploading,
    required this.onPickFile,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: isUploading ? null : onPickFile,
      borderRadius: BorderRadius.circular(AppConstants.r12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p32),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
        child: Column(
          children: [
            if (isUploading)
              const CircularProgressIndicator()
            else ...[
              const Icon(
                Icons.cloud_upload_outlined,
                size: 48,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppConstants.p12),
              Text(
                l10n.uploadFile,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConstants.p4),
              Text(
                l10n.maxFileSize(10),
                style: AppTextStyle.labelSmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _UploadedDropZone extends StatelessWidget {
  final String fileName;
  final VoidCallback onDelete;

  const _UploadedDropZone({
    required this.fileName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.insert_drive_file,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppConstants.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  l10n.fileUploaded,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.presentText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.absentText,
            ),
          ),
        ],
      ),
    );
  }
}
