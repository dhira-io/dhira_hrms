import 'package:dhira_hrms/features/attendance/presentation/widgets/punch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_state.dart';

class WelcomeProfileCard extends StatelessWidget {
  const WelcomeProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   l10n.welcomeName,
        //   style: AppTextStyle.h1,
        // ),
        const SizedBox(height: AppConstants.p12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.p18),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppConstants.r20),
            boxShadow: [
              BoxShadow(
                color: colors.onSurface.withValues(alpha: 0.06),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final profile = state.maybeWhen(
                loaded: (profile, resume) => profile,
                orElse: () => null,
              );

              final empIdToDisplay =
                  (profile?.customPayrollId != null &&
                      profile!.customPayrollId!.isNotEmpty)
                  ? "EMP-${profile.customPayrollId}"
                  : profile?.empId;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile?.fullName ?? l10n.employeeName,
                    style: AppTextStyle.h2.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppConstants.p8),
                  Text(
                    profile?.designation ?? l10n.designation,
                    style: AppTextStyle.h2.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppConstants.p8),
                  if (empIdToDisplay != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.p12,
                        vertical: AppConstants.p6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primaryFixed,
                        borderRadius: BorderRadius.circular(AppConstants.r12),
                        border: Border.all(
                          color: AppColors.of(
                            context,
                          ).primary.withValues(alpha: AppConstants.opacityLow),
                        ),
                      ),
                      child: Text(
                        empIdToDisplay,
                        style: AppTextStyle.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colors.onPrimaryFixed,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: AppConstants.p20),
                  PunchCard(
                    showDateAndTime: false,
                    padding: EdgeInsets.zero,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

}
