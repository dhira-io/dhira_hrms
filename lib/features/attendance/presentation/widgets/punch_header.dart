import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';

class PunchHeader extends StatelessWidget {
  final bool isPunchedIn;
  final bool isOnBreak;
  final String? firstIn;
  final String timeFormatted;
  final String dateFormatted;

  const PunchHeader({
    super.key,
    required this.isPunchedIn,
    required this.isOnBreak,
    this.firstIn,
    required this.timeFormatted,
    required this.dateFormatted,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppConstants.p8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p24),
        decoration: BoxDecoration(
          color: AppColors.profileHeaderBg.withValues(alpha: 0.5),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppConstants.r16),
            topRight: Radius.circular(AppConstants.r16),
          ),
        ),
        child: Column(
          children: [
            if (isPunchedIn && firstIn != null)
              Text(
                l10n.startedDayAt(
                  DateTimeUtils.convertDateStringToTime(firstIn!),
                ),
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              )
            else if (!isPunchedIn)
              Text(
                dateFormatted,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),

            if (isPunchedIn) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timeFormatted,
                    style: GoogleFonts.manrope(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: isOnBreak ? AppColors.warning : AppColors.primary,
                      letterSpacing: 1.5,
                    ),
                  ),
                  if (isOnBreak) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.pause,
                      color: AppColors.warning,
                      size: AppConstants.iconXXSmall,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                isOnBreak ? l10n.onBreak : l10n.timeElapsed,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
