import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_state.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class PunchActionButtonRow extends StatelessWidget {
  final bool isPunchedIn;
  final bool isOnBreak;
  final AttendanceActionType? loadingType;
  final VoidCallback onPunchIn;
  final VoidCallback onTakeBreak;
  final VoidCallback onPunchOut;
  final VoidCallback onEndBreak;
  final EdgeInsets? padding;
  final Color? breakButtonColor;
  final Color? punchOutColor;

  const PunchActionButtonRow({
    super.key,
    required this.isPunchedIn,
    required this.isOnBreak,
    this.loadingType,
    required this.onPunchIn,
    required this.onTakeBreak,
    required this.onPunchOut,
    required this.onEndBreak,
    this.padding,
    this.breakButtonColor,
    this.punchOutColor,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding:
          padding ??
          const EdgeInsets.fromLTRB(
            AppConstants.p16,
            0,
            AppConstants.p16,
            AppConstants.p16,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isPunchedIn) ...[
            Text(
              l10n.readyToStartDay,
              style: AppTextStyle.bodyMedium.copyWith(
                fontSize: AppConstants.fs14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              if (!isPunchedIn)
                _ActionButton(
                  label: l10n.letsGo,
                  icon: Icons.login_outlined,
                  color: (loadingType == AttendanceActionType.punchIn)
                      ? AppColors.primaryContainer.withValues(alpha: 0.5)
                      : AppColors.primaryContainer,
                  onTap: loadingType != null ? null : onPunchIn,
                  isLoading: loadingType == AttendanceActionType.punchIn,
                  loadingLabel: l10n.punchingIn,
                )
              else if (!isOnBreak) ...[
                _ActionButton(
                  label: l10n.takeBreak,
                  icon: Icons.pause_circle_outline,
                  color: loadingType == AttendanceActionType.takeBreak
                      ? (breakButtonColor ?? AppColors.warning).withValues(
                          alpha: 0.5,
                        )
                      : (breakButtonColor ?? AppColors.warning),
                  onTap: loadingType != null ? null : onTakeBreak,
                  isLoading: loadingType == AttendanceActionType.takeBreak,
                  loadingLabel: l10n.takingBreak,
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  label: l10n.thatsAllForToday,
                  icon: Icons.history_toggle_off,
                  color: loadingType == AttendanceActionType.punchOut
                      ? (punchOutColor ?? AppColors.error).withValues(
                          alpha: 0.5,
                        )
                      : (punchOutColor ?? AppColors.error),
                  onTap: loadingType != null ? null : onPunchOut,
                  isLoading: loadingType == AttendanceActionType.punchOut,
                  loadingLabel: l10n.punchingOut,
                ),
              ] else ...[
                _ActionButton(
                  label: l10n.resume,
                  icon: Icons.play_arrow,
                  color: loadingType == AttendanceActionType.endBreak
                      ? (breakButtonColor ?? AppColors.warning).withValues(
                          alpha: 0.5,
                        )
                      : (breakButtonColor ?? AppColors.warning),
                  onTap: loadingType != null ? null : onEndBreak,
                  isLoading: loadingType == AttendanceActionType.endBreak,
                  loadingLabel: l10n.resuming,
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  label: l10n.thatsAllForToday,
                  icon: Icons.history_toggle_off,
                  color: loadingType == AttendanceActionType.punchOut
                      ? (punchOutColor ?? AppColors.error).withValues(
                          alpha: 0.5,
                        )
                      : (punchOutColor ?? AppColors.error),
                  onTap: loadingType != null ? null : onPunchOut,
                  isLoading: loadingType == AttendanceActionType.punchOut,
                  loadingLabel: l10n.punchingOut,
                ),
              ],
            ],
          ),
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
                    fontSize: AppConstants.fs14,
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
