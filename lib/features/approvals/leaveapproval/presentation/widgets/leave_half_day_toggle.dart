import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LeaveHalfDayToggle extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isHalfDay;
  final ValueChanged<bool> onChanged;

  const LeaveHalfDayToggle({
    super.key,
    required this.l10n,
    required this.isHalfDay,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.of(context).outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.wb_sunny_outlined, color: AppColors.of(context).onSurfaceVariant),
              const SizedBox(width: AppConstants.p12),
              Text(
                l10n.halfDayToggle,
                style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: isHalfDay,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: AppColors.of(context).primary,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: AppColors.of(context).outlineVariant.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
