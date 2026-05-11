import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_state.dart';
import 'package:dhira_hrms/features/leave/presentation/widgets/dashed_border_painter.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LeaveFileUploadSection extends StatelessWidget {
  final AppLocalizations l10n;
  final LeaveApprovalState state;
  final String? selectedFileName;
  final VoidCallback onPickFile;

  const LeaveFileUploadSection({
    super.key,
    required this.l10n,
    required this.state,
    this.selectedFileName,
    required this.onPickFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: DashedBorderPainter(color: AppColors.outlineVariant),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.p24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.p12),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: state.isUploading
                      ? const SizedBox(
                          width: AppConstants.iconMedium,
                          height: AppConstants.iconMedium,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.primary),
                        )
                      : Icon(
                          state.uploadedFileUrl != null
                              ? Icons.check_circle_outline
                              : Icons.cloud_upload_outlined,
                          color: state.uploadedFileUrl != null
                              ? Colors.green
                              : AppColors.primary,
                          size: AppConstants.iconMedium,
                        ),
                ),
                const SizedBox(height: AppConstants.p12),
                Text(
                  selectedFileName ?? l10n.dragAndDrop,
                  style: AppTextStyle.bodySmall.copyWith(
                      color: state.uploadedFileUrl != null
                          ? Colors.green
                          : AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                if (state.uploadError != null) ...[
                  const SizedBox(height: AppConstants.p8),
                  Text(
                    state.uploadError!,
                    style: AppTextStyle.bodySmall
                        .copyWith(color: Colors.red, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: AppConstants.p8),
                ElevatedButton(
                  onPressed: state.isUploading ? null : onPickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.primary,
                    elevation: 0,
                    side: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.2)),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    state.uploadedFileUrl != null
                        ? l10n.changeFile
                        : l10n.browseFiles,
                    style: AppTextStyle.button
                        .copyWith(fontSize: 12, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppConstants.p20),
        Container(
          padding: const EdgeInsets.all(AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.tertiaryContainer.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: AppColors.tertiaryContainer, size: AppConstants.iconXSmall),
              const SizedBox(width: AppConstants.p12),
              Expanded(
                child: Text(
                  l10n.medicalWarning,
                  style: AppTextStyle.bodySmall
                      .copyWith(color: AppColors.tertiary, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
