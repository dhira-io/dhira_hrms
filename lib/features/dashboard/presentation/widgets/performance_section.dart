import 'package:dhira_hrms/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';

class PerformanceSection extends StatelessWidget {
  const PerformanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.performance,
          style: AppTextStyle.h3.copyWith(
            fontSize: AppConstants.p18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.p16),
        BlocBuilder<PerformanceBloc, PerformanceState>(
          builder: (context, state) {
            return Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _PerformanceActionCard(
                          icon: Icons.track_changes_outlined,
                          label: l10n.goalSetup,
                          subtitle: l10n.goalSetupSubtitle,
                          iconBgColor: AppColors.of(context).iconbgblue,
                          iconColor: AppColors.of(context).primary,
                          onTap: () =>
                              context.push(AppRouter.performanceGoalSetupPath),
                        ),
                      ),
                      const SizedBox(width: AppConstants.p16),
                      Expanded(
                        child: _PerformanceActionCard(
                          icon: Icons.rate_review_outlined,
                          label: l10n.selfAssessment,
                          subtitle: l10n.selfAssessmentSubtitle,
                          iconBgColor: AppColors.of(context).iconbgred,
                          iconColor: AppColors.of(context).error,
                          onTap: () => context.push(
                            AppRouter.performanceSelfAssessmentPath,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.isManager) ...[
                  const SizedBox(height: AppConstants.p16),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _PerformanceActionCard(
                            icon: Icons.groups_outlined,
                            label: l10n.teamEvaluation,
                            subtitle: l10n.teamEvaluationSubtitle,
                            iconBgColor: AppColors.of(context).iconbgviolet,
                            iconColor: AppColors.of(context).brandBlue,
                            onTap: () => context.push(
                              AppRouter.performanceTeamEvaluationPath,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.p16),
                        const Spacer(), // Empty space for the 2nd column
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _PerformanceActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _PerformanceActionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        child: Ink(
          padding: const EdgeInsets.all(AppConstants.p10),
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppConstants.r16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: AppConstants.iconXXSmall,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.p16),
              Text(
                label,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.p14,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConstants.p4),
              Text(
                subtitle,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.of(context).textSecondary,
                  fontSize: 11,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
