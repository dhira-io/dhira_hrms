import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/file_validation_utils.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportingDocumentsSection extends StatelessWidget {
  final List<FileAttachmentEntity>? attachments;
  final bool? isEditable;
  final bool? isUploading;
  final String? deletingAttachmentId;
  final Future<void> Function(String filePath, String fileName)? onUploadAttachment;
  final Future<bool> Function(String fileId)? onDeleteAttachment;
  final void Function({
    required String fileUrl,
    required String fileName,
    required AppLocalizations l10n,
  })? onFileAction;

  const SupportingDocumentsSection({
    super.key,
    this.attachments,
    this.isEditable,
    this.isUploading,
    this.deletingAttachmentId,
    this.onUploadAttachment,
    this.onDeleteAttachment,
    this.onFileAction,
  });

  Future<void> _pickAndUploadAttachment(
    BuildContext context,
    List<FileAttachmentEntity> resolvedAttachments,
    Future<void> Function(String filePath, String fileName) resolvedOnUploadAttachment,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    if (!FileValidationUtils.canUploadMore(
      currentCount: resolvedAttachments.length,
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
    await resolvedOnUploadAttachment(file.path!, file.name);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.watch<SelfAssessmentCubit>();
    final state = cubit.state;

    final resolvedAttachments = attachments ?? state.details?.attachments ?? [];
    final bool resolvedIsEditable = isEditable ??
        (state.details?.docStatus == AppConstants.docStatusDraft);
    final bool resolvedIsUploading = isUploading ?? state.isAttachmentUploading;
    final resolvedDeletingAttachmentId = deletingAttachmentId ?? state.deletingAttachmentId;

    final resolvedOnUploadAttachment = onUploadAttachment ??
        (filePath, fileName) => cubit.uploadAttachment(filePath: filePath, fileName: fileName);

    final resolvedOnDeleteAttachment = onDeleteAttachment ??
        (fileId) => cubit.deleteAttachment(fileId);

    final resolvedOnFileAction = onFileAction ??
        ({required fileUrl, required fileName, required l10n}) {
          context.read<FileOperationCubit>().handleFileAction(
                fileUrl: fileUrl,
                fileName: fileName,
                l10n: l10n,
              );
        };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (resolvedIsEditable) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.p24),
            decoration: BoxDecoration(
              color: AppColors.of(context).background,
              borderRadius: BorderRadius.circular(AppConstants.r12),
              border: Border.all(
                color: AppColors.of(context).primary.withValues(alpha: 0.2),
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.p12),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surfaceContainerHigh.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  child: Icon(
                    Icons.description_outlined,
                    color: AppColors.of(context).onSurfaceVariant,
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
                    color: AppColors.of(context).onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppConstants.p16),
                CommonButton(
                  text: l10n.selectFiles,
                  onPressed: () => _pickAndUploadAttachment(
                    context,
                    resolvedAttachments,
                    resolvedOnUploadAttachment,
                  ),
                  isLoading: resolvedIsUploading,
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
            color: AppColors.of(context).onSurface,
          ),
        ),
        const SizedBox(height: AppConstants.p12),
        if (resolvedAttachments.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p24),
              child: Text(
                l10n.noFilesAttached,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.of(context).onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          ...resolvedAttachments.map((file) {
            final lowerFileName = file.fileName.toLowerCase();
            final isImage = [
              'jpg',
              'jpeg',
              'png',
              'webp',
              'heic',
              'heif',
            ].any((ext) => lowerFileName.endsWith(ext));
            final isDeleting = resolvedDeletingAttachmentId == file.name;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.p8),
              child: Container(
                padding: const EdgeInsets.all(AppConstants.p12),
                decoration: BoxDecoration(
                  color: AppColors.of(context).surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                  border: Border.all(color: AppColors.of(context).surfaceContainerHigh),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.insert_drive_file_outlined,
                      color: AppColors.of(context).primary,
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
                        resolvedOnFileAction(
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
                        color: AppColors.of(context).onSurfaceVariant,
                      ),
                    ),
                    if (resolvedIsEditable)
                      isDeleting
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.p12,
                              ),
                              child: SizedBox(
                                height: AppConstants.iconSmall,
                                width: AppConstants.iconSmall,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.of(context).error,
                                  ),
                                ),
                              ),
                            )
                          : IconButton(
                              onPressed: () => resolvedOnDeleteAttachment(file.name),
                              icon: Icon(
                                Icons.delete_outline,
                                size: AppConstants.iconSmall,
                                color: AppColors.of(context).error,
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
