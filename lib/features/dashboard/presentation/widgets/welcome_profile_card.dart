import 'package:dhira_hrms/features/attendance/presentation/widgets/punch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';

class WelcomeProfileCard extends StatelessWidget {
  const WelcomeProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state.maybeWhen(
          authenticated: (user) => user,
          orElse: () => null,
        );

        final l10n = AppLocalizations.of(context)!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.helloLabel,
              style: AppTextStyle.bodySmall,
            ),
            const SizedBox(height: AppConstants.p4),
            Text(
              l10n.welcomeName(user?.fullName.split(' ').first ?? l10n.user),
              style: AppTextStyle.h1,
            ),
            const SizedBox(height: AppConstants.p20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.p24),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppConstants.r20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.onSurface.withValues(alpha: 0.06),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -40,
                    right: -40,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primaryFixed.withValues(alpha: AppConstants.opacityMedium),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.fullName ?? l10n.employeeName,
                        style: AppTextStyle.h2.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: AppConstants.p4),
                      Text(
                        user?.department ?? l10n.notAssigned,
                        style: AppTextStyle.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppConstants.p12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.p12,
                          vertical: AppConstants.p4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryFixed,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          l10n.empIdLabel(user?.empId ?? l10n.notAvailable),
                          style: AppTextStyle.labelSmall.copyWith(
                            color: AppColors.onPrimaryFixed,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppConstants.p24),
                      const PunchCard(
                        showBackground: true,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
