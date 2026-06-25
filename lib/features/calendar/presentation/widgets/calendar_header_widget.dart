import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';

class CalendarHeaderWidget extends StatelessWidget {
  const CalendarHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p16,
        vertical: AppConstants.p12,
      ),
      color: AppColors.of(context).surface,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                context.read<BottomNavCubit>().changeIndex(BottomNavCubit.homeIndex);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(AppConstants.p8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.of(context).surfaceContainer,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: AppConstants.iconSmall,
                color: AppColors.of(context).onSurface,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.calendar,
                  style: AppTextStyle.titleMedium.copyWith(
                    color: AppColors.of(context).onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l10n.calendarSubtitle,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
