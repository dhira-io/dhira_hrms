import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/file_validation_utils.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SupportingDocumentsSection extends StatelessWidget {
  final List<FileAttachmentEntity> attachments;
  final bool isEditable;
  final bool isUploading;
  final String deletingAttachmentId;
  final Future<void> Function(String filePath, String fileName)
  onUploadAttachment;
  final Future<bool> Function(String fileId) onDeleteAttachment;
  final void Function({
    required String fileUrl,
    required String fileName,
    required AppLocalizations l10n,
  })
  onFileAction;

  const SupportingDocumentsSection({
    required this.attachments,
    required this.isEditable,
    required this.isUploading,
    required this.deletingAttachmentId,
    required this.onUploadAttachment,
    required this.onDeleteAttachment,
    required this.onFileAction,
  });

  Future<void> _pickAndUploadAttachment(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    if (!FileValidationUtils.canUploadMore(
      currentCount: attachments.length,
      l10n: l10n,
      maxCount: 5,
    )) {
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'xlsx', 'jpg', 'jpeg', 'png', 'webp'],
    );

    if (result == null || result.files.single.path == null) return;

    final file = result.files.single;
    if (!FileValidationUtils.validateFile(
      file: file,
      l10n: l10n,
      maxSizeBytes: 50 * 1024 * 1024,
    )) {
      return;
    }

    if (!context.mounted) return;
    await onUploadAttachment(file.path!, file.name);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isEditable) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.p24),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppConstants.r12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.p12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    color: AppColors.onSurfaceVariant,
                    size: AppConstants.p32,
                  ),
                ),
                const SizedBox(height: AppConstants.p16),
                Text(
                  l10n.uploadSupportingDocs,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.p4),
                Text(
                  l10n.maxFileSizeLabel(AppConstants.maxFileSizeText),
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppConstants.p16),
                ElevatedButton(
                  onPressed: isUploading
                      ? null
                      : () => _pickAndUploadAttachment(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.p24,
                      vertical: AppConstants.p12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r8),
                    ),
                  ),
                  child: isUploading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white,
                            ),
                          ),
                        )
                      : Text(l10n.selectFiles),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p24),
        ],
        Text(
          l10n.attachedFiles,
          style: AppTextStyle.labelSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: AppConstants.p12),
        if (attachments.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p24),
              child: Text(
                l10n.noFilesAttached,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          ...attachments.map((file) {
            final lowerFileName = file.fileName.toLowerCase();
            final isImage = [
              'jpg',
              'jpeg',
              'png',
              'webp',
              'heic',
              'heif',
            ].any((ext) => lowerFileName.endsWith(ext));
            final isDeleting = deletingAttachmentId == file.name;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.p8),
              child: Container(
                padding: const EdgeInsets.all(AppConstants.p12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.insert_drive_file_outlined,
                      color: AppColors.primary,
                      size: AppConstants.iconSmall,
                    ),
                    const SizedBox(width: AppConstants.p12),
                    Expanded(
                      child: Text(
                        file.fileName,
                        style: AppTextStyle.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onFileAction(
                          fileUrl: file.fileUrl,
                          fileName: file.fileName,
                          l10n: l10n,
                        );
                      },
                      icon: Icon(
                        isImage
                            ? Icons.visibility_outlined
                            : Icons.download_outlined,
                        size: AppConstants.iconSmall,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    if (isEditable)
                      isDeleting
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.p12,
                              ),
                              child: SizedBox(
                                height: AppConstants.iconSmall,
                                width: AppConstants.iconSmall,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.error,
                                  ),
                                ),
                              ),
                            )
                          : IconButton(
                              onPressed: () => onDeleteAttachment(file.name),
                              icon: const Icon(
                                Icons.delete_outline,
                                size: AppConstants.iconSmall,
                                color: AppColors.error,
                              ),
                            ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}
