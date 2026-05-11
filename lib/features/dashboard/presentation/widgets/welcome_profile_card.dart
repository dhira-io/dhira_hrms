import 'package:dhira_hrms/features/attendance/presentation/widgets/punch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.welcomeName,
          style: AppTextStyle.h1,
        ),
        const SizedBox(height: AppConstants.p12),
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
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final profile = state.maybeWhen(
                loaded: (profile) => profile,
                orElse: () => null,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile?.fullName ?? l10n.employeeName,
                    style: AppTextStyle.h2.copyWith(
                      fontSize: AppConstants.p24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppConstants.p8),
                  Text(
                    profile?.designation ?? l10n.designation,
                    style: AppTextStyle.h2.copyWith(
                      fontSize: AppConstants.p14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppConstants.p8),
                  if (profile?.empId != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.p12,
                        vertical: AppConstants.p6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryFixed,
                        borderRadius: BorderRadius.circular(AppConstants.r12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: AppConstants.opacityLow),
                        ),
                      ),
                      child: Text(
                        profile!.empId!,
                        style: AppTextStyle.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: AppConstants.p20),
                  const PunchCard(
                    showDateAndTime: false,
                    padding: EdgeInsets.zero,
                    breakButtonColor: AppColors.punchBreak,
                    punchOutColor: AppColors.punchOut,
                  ),

                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p12,
        vertical: AppConstants.p8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.r10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppConstants.p16,
            color: color,
          ),
          const SizedBox(width: AppConstants.p8),
          Text(
            label.toUpperCase(),
            style: AppTextStyle.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

