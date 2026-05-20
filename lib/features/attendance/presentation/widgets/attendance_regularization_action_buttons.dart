import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class RegularizationActionButtons extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final bool isLoading;

  const RegularizationActionButtons({
    super.key,
    required this.onSubmit,
    required this.onCancel,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.of(context).surfaceContainerHighest,
              foregroundColor: AppColors.of(context).onSurfaceVariant,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.r12),
              ),
            ),
            child: Text(
              l10n.cancel,
              style: AppTextStyle.labelLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.of(context).onSurfaceVariant,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.of(context).primary.withValues(alpha: isLoading ? 0.5 : 1.0),
                  AppColors.of(context).primaryContainer
                      .withValues(alpha: isLoading ? 0.5 : 1.0),
                ],
              ),
              borderRadius: BorderRadius.circular(AppConstants.r12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.of(context).primary.withValues(alpha: 0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : onSubmit,
                borderRadius: BorderRadius.circular(AppConstants.r12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p16,
                  ),
                  alignment: Alignment.center,
                  child: isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.of(context).white,
                            strokeWidth: 1.5,
                          ),
                        )
                      : Text(
                          l10n.submitRequest,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: AppColors.of(context).white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
