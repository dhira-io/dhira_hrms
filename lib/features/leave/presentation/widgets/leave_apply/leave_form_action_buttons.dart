import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/widgets/common_button.dart';
import '../../../../../l10n/app_localizations.dart';

class LeaveFormActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback? onSubmit;
  final bool isLoading;
  final bool isSubmitDisabled;

  const LeaveFormActionButtons({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    required this.isLoading,
    required this.isSubmitDisabled,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: CommonButton(
            text: l10n.cancel,
            onPressed: onCancel,
            variant: ButtonVariant.outlined,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: CommonButton(
            text: l10n.submitRequest,
            onPressed: isSubmitDisabled ? null : onSubmit,
            isLoading: isLoading,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ],
    );
  }
}
