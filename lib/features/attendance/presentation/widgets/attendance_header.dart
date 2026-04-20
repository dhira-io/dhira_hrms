import 'package:flutter/material.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class AttendanceHeader extends StatelessWidget {
  const AttendanceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final today = DateTimeUtils.todayDate(pattern: 'EEEE, d MMM yyyy');

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p20,
        vertical: AppConstants.p15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo placeholder
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.companyName,
                    style: TextStyle(
                      fontFamily: 'Serif', // Fallback for a logo font
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    l10n.companyWebsite,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              // Right actions
              Row(
                children: [
                  Stack(
                    children: [
                       Icon(Icons.notifications_none, size: 28, color: AppColors.textPrimary),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: AppConstants.p15),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.border,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/100'), // Dummy avatar
                  ),
                  const SizedBox(width: AppConstants.p15),
                   Icon(Icons.menu, size: 28, color: AppColors.textPrimary),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p10),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: AppConstants.p20),
          Text(
            l10n.attendance,
            style: AppTextStyle.h2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.p4),
          Text(
            today,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
