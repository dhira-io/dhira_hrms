import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_state.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/attendance_event.dart';

class PunchActionButtonRow extends StatelessWidget {
  final bool isPunchedIn;
  final bool isOnBreak;
  final AttendanceActionType? loadingType;
  final VoidCallback onPunchIn;
  final VoidCallback onTakeBreak;
  final VoidCallback onPunchOut;
  final VoidCallback onEndBreak;

  const PunchActionButtonRow({
    super.key,
    required this.isPunchedIn,
    required this.isOnBreak,
    this.loadingType,
    required this.onPunchIn,
    required this.onTakeBreak,
    required this.onPunchOut,
    required this.onEndBreak,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          if (!isPunchedIn)
            _ActionButton(
              label: l10n.letsGo,
              icon: Icons.login_outlined,
              color: (loadingType == AttendanceActionType.punchIn)
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.primary,
              onTap: loadingType != null ? null : onPunchIn,
              isLoading: loadingType == AttendanceActionType.punchIn,
              loadingLabel: l10n.processing,
            )
          else if (!isOnBreak) ...[
            _ActionButton(
              label: l10n.takeBreak,
              icon: Icons.pause_circle_outline,
              color: loadingType == AttendanceActionType.takeBreak
                  ? AppColors.warning.withValues(alpha: 0.5)
                  : AppColors.warning,
              onTap: loadingType != null ? null : onTakeBreak,
              isLoading: loadingType == AttendanceActionType.takeBreak,
              loadingLabel: l10n.processing,
            ),
            const SizedBox(width: 8),
            _ActionButton(
              label: l10n.thatsAllForToday,
              icon: Icons.history_toggle_off,
              color: loadingType == AttendanceActionType.punchOut
                  ? AppColors.error.withValues(alpha: 0.5)
                  : AppColors.error,
              onTap: loadingType != null ? null : onPunchOut,
              isLoading: loadingType == AttendanceActionType.punchOut,
              loadingLabel: l10n.processing,
            ),
          ] else ...[
            _ActionButton(
              label: l10n.resume,
              icon: Icons.play_arrow,
              color: loadingType == AttendanceActionType.endBreak
                  ? AppColors.warning.withValues(alpha: 0.5)
                  : AppColors.warning,
              onTap: loadingType != null ? null : onEndBreak,
              isLoading: loadingType == AttendanceActionType.endBreak,
              loadingLabel: l10n.processing,
            ),
            const SizedBox(width: 8),
            _ActionButton(
              label: l10n.thatsAllForToday,
              icon: Icons.history_toggle_off,
              color: loadingType == AttendanceActionType.punchOut
                  ? AppColors.error.withValues(alpha: 0.5)
                  : AppColors.error,
              onTap: loadingType != null ? null : onPunchOut,
              isLoading: loadingType == AttendanceActionType.punchOut,
              loadingLabel: l10n.processing,
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool isLoading;
  final String loadingLabel;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
    required this.isLoading,
    required this.loadingLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppConstants.r8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isLoading ? Icons.hourglass_bottom : icon,
                color: AppColors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  isLoading ? loadingLabel : label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.labelMedium.copyWith(
                    color: AppColors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
