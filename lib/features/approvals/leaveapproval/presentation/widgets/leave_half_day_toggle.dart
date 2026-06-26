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
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.wb_sunny_outlined,
                color: colors.onSurfaceVariant,
              ),
              const SizedBox(width: AppConstants.p12),
              Text(
                l10n.halfDayToggle,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: isHalfDay,
              onChanged: onChanged,
              activeThumbColor: colors.white,
              activeTrackColor: colors.primary,
              inactiveThumbColor: colors.white,
              inactiveTrackColor: colors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
