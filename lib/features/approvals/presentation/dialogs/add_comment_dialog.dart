import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/usecases/add_comment_usecase.dart';

class AddCommentDialog extends StatefulWidget {
  final ApprovalRequestEntity data;

  const AddCommentDialog({
    super.key,
    required this.data,
  });

  @override
  State<AddCommentDialog> createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    if (_commentController.text.trim().isEmpty) return;
    
    setState(() => _isLoading = true);
    final l10n = AppLocalizations.of(context)!;

    try {
      final useCase = Get.find<AddCommentUseCase>();
      final String doctype = widget.data.type.doctype;

      final result = await useCase(doctype, widget.data.id, _commentController.text.trim());

      if (mounted) {
        setState(() => _isLoading = false);
        result.fold(
          (failure) => ToastUtils.showError(failure.message),
          (_) {
            Navigator.pop(context);
            ToastUtils.showSuccess(l10n.commentAddedSuccessfully);
          },
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ToastUtils.showError(l10n.failedToAddComment);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: AppColors.of(context).surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r16)),
      title: Text(l10n.addComment, style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.commentVisibleToEmployee, style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).onSurfaceVariant)),
          const SizedBox(height: AppConstants.p16),
           TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: l10n.enterComment,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel, style: TextStyle(color: AppColors.of(context).onSurface)),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitComment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.of(context).primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                  minimumSize: const Size(0, AppConstants.p40),
                ),
                child: _isLoading
                    ? SizedBox(
                        width: AppConstants.p20,
                        height: AppConstants.p20,
                        child: CircularProgressIndicator(color: AppColors.of(context).white, strokeWidth: 2),
                      )
                    : Text(l10n.addComment, style: AppTextStyle.labelLarge.copyWith(color: AppColors.of(context).white)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
