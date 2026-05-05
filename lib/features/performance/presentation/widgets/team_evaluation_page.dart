import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/team_evaluation/team_evaluation_cubit.dart';
import '../cubit/team_evaluation/team_evaluation_filter_cubit.dart';
import '../cubit/team_evaluation/team_evaluation_filter_state.dart';
import '../cubit/team_evaluation/team_evaluation_state.dart';
import 'team_evaluation_widgets.dart';
import '../bottom_sheets/team_evaluation_filter_bottom_sheet.dart';
import '../../../../core/constants/app_constants.dart';
import '../utils/performance_ui_extensions.dart';
import '../../../../core/routing/app_router.dart';

class TeamEvaluationPage extends StatefulWidget {
  const TeamEvaluationPage({super.key});

  @override
  State<TeamEvaluationPage> createState() => _TeamEvaluationPageState();
}

class _TeamEvaluationPageState extends State<TeamEvaluationPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TeamEvaluationCubit>().fetchEvaluations();
      }
    });
    _searchController.addListener(() {
      if (mounted) {
        context.read<TeamEvaluationFilterCubit>().updateSearch(
          _searchController.text,
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const SizedBox.shrink();

    return BlocListener<TeamEvaluationCubit, TeamEvaluationState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (evaluations) {
            context.read<TeamEvaluationFilterCubit>().setInitialData(
              evaluations,
            );
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<TeamEvaluationFilterCubit, TeamEvaluationFilterState>(
        builder: (context, state) {
          return Material(
            color: AppColors.background,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(AppConstants.p16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Search Bar & Filter Button
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.r12,
                                ),
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: l10n.searchByEmpNameOrId,
                                  hintStyle: AppTextStyle.bodySmall.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: AppConstants.p14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppConstants.p12),
                          GestureDetector(
                            onTap: () => _showFilterBottomSheet(context),
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: AppConstants.opacityLow,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppConstants.r12,
                                ),
                              ),
                              child: const Icon(
                                Icons.filter_list,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.p12),

                      // Header
                      Text(
                        l10n.teamEvaluation,
                        style: AppTextStyle.h1Bold.copyWith(
                          fontSize: AppConstants.fs24,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: AppConstants.p4),
                      Text(
                        l10n.reviewSelfAssessments,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppConstants.p12),

                      // Quick Stats Bento Grid
                      Row(
                        children: [
                          Expanded(
                            child: TeamEvaluationMetricCard(
                              title: l10n.totalEmployees,
                              value: state.totalCount.toString().padLeft(
                                2,
                                '0',
                              ),
                              icon: Icons.group,
                              iconBgColor: AppColors.primaryFixed,
                              iconColor: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: AppConstants.p12),
                          Expanded(
                            child: TeamEvaluationMetricCard(
                              title: l10n.submitted,
                              value: state.submittedCount.toString().padLeft(
                                2,
                                '0',
                              ),
                              icon: Icons.check_circle,
                              iconBgColor: AppColors.successBg,
                              iconColor: AppColors.success,
                              accentBarColor: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.p12),
                      TeamEvaluationMetricCard(
                        title: l10n.pending,
                        value: state.pendingCount.toString().padLeft(2, '0'),
                        icon: Icons.schedule,
                        iconBgColor: AppColors.warningBg,
                        iconColor: AppColors.warning,
                        accentBarColor: AppColors.warning,
                        isFullWidth: true,
                      ),
                      const SizedBox(height: AppConstants.p12),
                    ]),
                  ),
                ),
                BlocBuilder<TeamEvaluationCubit, TeamEvaluationState>(
                  builder: (context, fetchState) {
                    return fetchState.maybeWhen(
                      loading: () => SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.p16,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => const TeamEvaluationShimmerLoader(),
                            childCount: 5,
                          ),
                        ),
                      ),
                      failure: (message) => SliverFillRemaining(
                        child: Center(child: Text(message)),
                      ),
                      orElse: () {
                        if (state.filteredEvaluations.isEmpty) {
                          return SliverFillRemaining(
                            child: Center(child: Text(l10n.noEvaluationsFound)),
                          );
                        }
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.p16,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final eval = state.filteredEvaluations[index];
                              return TeamEvaluationEmployeeCard(
                                name: eval.employeeName,
                                empId: eval.employee,
                                role: eval.department,
                                status: eval.statusLabel,
                                submittedAt: eval.modified,
                                onReview: () {
                                  context.push(
                                    AppRouter.teamEvaluationReviewPath,
                                    extra: {
                                      'employeeName':
                                          eval.employeeName ?? eval.employee,
                                      'employeeId': eval.employee,
                                      'department': eval.department,
                                      'status': eval.employeeStatus ??
                                          PerformanceStatus.statusActive,
                                      'evaluationStatus': eval.statusLabel,
                                      'evaluationId': eval.name,
                                      'selfAssessmentId': eval.selfAssessment,
                                    },
                                  );
                                },
                              );
                            }, childCount: state.filteredEvaluations.length),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppConstants.p12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) async {
    final filterCubit = context.read<TeamEvaluationFilterCubit>();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: filterCubit,
          child: const TeamEvaluationFilterBottomSheet(),
        );
      },
    );
  }
}

class TeamEvaluationShimmerLoader extends StatelessWidget {
  const TeamEvaluationShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p16),
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r20),
      ),
      child: Row(
        children: [
          Container(
            width: AppConstants.p48,
            height: AppConstants.p48,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppConstants.p16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppConstants.p120,
                  height: AppConstants.p16,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppConstants.r4),
                  ),
                ),
                const SizedBox(height: AppConstants.p8),
                Container(
                  width: AppConstants.p80,
                  height: AppConstants.p12,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppConstants.r4),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: AppConstants.p60,
            height: AppConstants.p24,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
          ),
        ],
      ),
    );
  }
}
