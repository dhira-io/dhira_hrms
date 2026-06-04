import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/common_button.dart';
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
          child: CommonButton(
            text: l10n.cancel,
            onPressed: onCancel,
            variant: ButtonVariant.outlined,
            padding:       EdgeInsets.symmetric(vertical: 14.h),
          ),
        ),
              SizedBox(width: 12.w),
        Expanded(
          child: CommonButton(
            text: l10n.submitRequest,
            onPressed: onSubmit,
            isLoading: isLoading,
            padding:       EdgeInsets.symmetric(vertical: 14.h),
          ),
        ),
      ],
    );
  }
}
