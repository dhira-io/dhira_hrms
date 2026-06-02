import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import 'common_button.dart';

class CommonAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmButtonColor;

  const CommonAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.confirmButtonColor,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    String? cancelText,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    Color? confirmButtonColor,
  }) {
    return showDialog<T>(
      context: context,
      builder: (BuildContext dialogContext) {
        return CommonAlertDialog(
          title: title,
          content: content,
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: onConfirm,
          onCancel: onCancel,
          confirmButtonColor: confirmButtonColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      title: Text(
        title,
        style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: AppTextStyle.bodyMedium.copyWith(
          color: AppColors.of(context).textSecondary,
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppConstants.p24,
        0,
        AppConstants.p24,
        AppConstants.p24,
      ),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (cancelText != null) ...[
              CommonButton(
                text: cancelText!,
                onPressed: () {
                  Navigator.pop(context);
                  if (onCancel != null) {
                    onCancel!();
                  }
                },
                variant: ButtonVariant.outlined,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: AppConstants.p12),
              ),
              const SizedBox(height: AppConstants.p12),
            ],
            CommonButton(
              text: confirmText,
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppConstants.p12),
              backgroundColor: confirmButtonColor,
            ),
          ],
        ),
      ],
    );
  }
}
