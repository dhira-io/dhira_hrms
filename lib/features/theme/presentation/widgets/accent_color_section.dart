import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class AccentColorSection extends StatelessWidget {
  const AccentColorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.accentColor,
            style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.accentColorDesc,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              AccentColorButton(color: AppColors.accentBlue, isSelected: true),
              const SizedBox(width: AppConstants.p16),
              AccentColorButton(color: AppColors.accentTeal),
              const SizedBox(width: AppConstants.p16),
              AccentColorButton(color: AppColors.accentRed),
              const SizedBox(width: AppConstants.p16),
              AccentColorButton(color: AppColors.accentPurple),
            ],
          ),
        ],
      ),
    );
  }
}

class AccentColorButton extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const AccentColorButton({super.key, required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: AppColors.white, width: 2) : null,
        boxShadow: isSelected ? [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))] : null,
      ),
      child: isSelected ? Icon(Icons.check, color: AppColors.white, size: 20) : null,
    );
  }
}
