import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/generic_error_widget.dart';
import '../cubit/team_evaluation/team_evaluation_cubit.dart';
import '../cubit/team_evaluation/team_evaluation_filter_cubit.dart';
import '../cubit/team_evaluation/team_evaluation_filter_state.dart';
import '../cubit/team_evaluation/team_evaluation_state.dart';
import 'team_evaluation_widgets.dart';
import '../bottom_sheets/team_evaluation_filter_bottom_sheet.dart';
import '../../../../core/constants/app_constants.dart';
import '../utils/performance_ui_extensions.dart';
import '../utils/performance_error_utils.dart';
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
        context.read<TeamEvaluationFilterCubit>().clearData();
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
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        appBar: AppBar(
          backgroundColor: AppColors.of(context).background,
          elevation: 0,
          title: Text(l10n.teamEvaluation, style: AppTextStyle.h2),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: AppConstants.iconXSmall,
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.pop();
            },
          ),
        ),
        body: BlocListener<TeamEvaluationCubit, TeamEvaluationState>(
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
          child: RefreshIndicator(
            onRefresh: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              final cubit = context.read<TeamEvaluationCubit>();
              cubit.fetchEvaluations();
              // Wait for the next state that is not loading
              await cubit.stream.firstWhere((state) => !state.isLoading);
            },
            color: AppColors.of(context).primary,
            backgroundColor: AppColors.of(context).surface,
            child:
                BlocBuilder<TeamEvaluationFilterCubit, TeamEvaluationFilterState>(
                  buildWhen: (prev, curr) =>
                      prev.filteredEvaluations != curr.filteredEvaluations ||
                      prev.totalCount != curr.totalCount ||
                      prev.submittedCount != curr.submittedCount ||
                      prev.pendingCount != curr.pendingCount,
                  builder: (context, state) {
                    return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                                        color: AppColors.of(context).surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(
                                          AppConstants.r12,
                                        ),
                                      ),
                                      child: TextField(
                                        controller: _searchController,
                                        decoration: InputDecoration(
                                          hintText: l10n.searchByEmpNameOrId,
                                          hintStyle: AppTextStyle.bodySmall
                                              .copyWith(
                                                color: AppColors.of(context).onSurfaceVariant,
                                              ),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: AppColors.of(context).onSurfaceVariant,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                vertical: AppConstants.p14,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: AppConstants.p12),
                                  BlocBuilder<TeamEvaluationFilterCubit, TeamEvaluationFilterState>(
                                    buildWhen: (prev, curr) =>
                                        prev.selectedDepartment != curr.selectedDepartment ||
                                        prev.selectedStatus != curr.selectedStatus,
                                    builder: (context, filterState) {
                                      final isFilterApplied = filterState.selectedDepartment != PerformanceStatus.allDepartment ||
                                          filterState.selectedStatus != PerformanceStatus.allStatus;

                                      return Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              _showFilterBottomSheet(context);
                                            },
                                            child: Container(
                                              height: 48,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                color: AppColors.of(context).primary.withValues(
                                                  alpha: AppConstants.opacityLow,
                                                ),
                                                borderRadius: BorderRadius.circular(
                                                  AppConstants.r12,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.filter_list,
                                                color: AppColors.of(context).primary,
                                              ),
                                            ),
                                          ),
                                          if (isFilterApplied)
                                            Positioned(
                                              top: -2,
                                              right: -2,
                                              child: Container(
                                                width: 12,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  color: AppColors.of(context).error,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppColors.of(context).background,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
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
                                  color: AppColors.of(context).onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: AppConstants.p12),

                              // Quick Stats Bento Grid
                              Row(
                                children: [
                                  Expanded(
                                    child:
                                        BlocSelector<
                                          TeamEvaluationFilterCubit,
                                          TeamEvaluationFilterState,
                                          int
                                        >(
                                          selector: (state) => state.totalCount,
                                          builder: (context, count) {
                                            return TeamEvaluationMetricCard(
                                              title: l10n.totalEmployees,
                                              value: count.toString().padLeft(
                                                2,
                                                '0',
                                              ),
                                              icon: Icons.group,
                                              iconBgColor: AppColors.of(context).primaryFixed,
                                              iconColor: AppColors.of(context).primary,
                                            );
                                          },
                                        ),
                                  ),
                                  const SizedBox(width: AppConstants.p12),
                                  Expanded(
                                    child:
                                        BlocSelector<
                                          TeamEvaluationFilterCubit,
                                          TeamEvaluationFilterState,
                                          int
                                        >(
                                          selector: (state) =>
                                              state.submittedCount,
                                          builder: (context, count) {
                                            return TeamEvaluationMetricCard(
                                              title: l10n.submitted,
                                              value: count.toString().padLeft(
                                                2,
                                                '0',
                                              ),
                                              icon: Icons.check_circle,
                                              iconBgColor: AppColors.of(context).successBg,
                                              iconColor: AppColors.of(context).success,
                                              accentBarColor: AppColors.of(context).success,
                                            );
                                          },
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppConstants.p12),
                              BlocSelector<
                                TeamEvaluationFilterCubit,
                                TeamEvaluationFilterState,
                                int
                              >(
                                selector: (state) => state.pendingCount,
                                builder: (context, count) {
                                  return TeamEvaluationMetricCard(
                                    title: l10n.pending,
                                    value: count.toString().padLeft(2, '0'),
                                    icon: Icons.schedule,
                                    iconBgColor: AppColors.of(context).warningBg,
                                    iconColor: AppColors.of(context).warning,
                                    accentBarColor: AppColors.of(context).warning,
                                    isFullWidth: true,
                                  );
                                },
                              ),
                              const SizedBox(height: AppConstants.p12),
                            ]),
                          ),
                        ),
                        BlocBuilder<TeamEvaluationCubit, TeamEvaluationState>(
                          buildWhen: (prev, curr) =>
                              prev.isLoading != curr.isLoading || prev != curr,
                          builder: (context, fetchState) {
                            return fetchState.maybeWhen(
                              loading: () => SliverPadding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppConstants.p16,
                                ),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) =>
                                        const TeamEvaluationShimmerLoader(),
                                    childCount: 5,
                                  ),
                                ),
                              ),
                              failure: (message) => SliverFillRemaining(
                                child: PerformanceErrorUtils.isServerErrorMessage(
                                      message,
                                    )
                                    ? GenericErrorWidget(
                                        onRetry: () {
                                          context
                                              .read<TeamEvaluationCubit>()
                                              .fetchEvaluations();
                                        },
                                      )
                                    : Center(child: Text(message)),
                              ),
                              orElse: () {
                                if (state.filteredEvaluations.isEmpty) {
                                  return SliverFillRemaining(
                                    child: Center(
                                      child: Text(l10n.noEvaluationsFound),
                                    ),
                                  );
                                }
                                return SliverPadding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.p16,
                                  ),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        final eval =
                                            state.filteredEvaluations[index];
                                        return TeamEvaluationEmployeeCard(
                                          name: eval.employeeName,
                                          empId: eval.employee,
                                          role: eval.department,
                                          status: eval.statusLabel,
                                          submittedAt: eval.modified,
                                          onReview: () async {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            await context.push(
                                              AppRouter.teamEvaluationReviewPath,
                                              extra: {
                                                AppRouter.argEmployeeName:
                                                    eval.employeeName ??
                                                    eval.employee,
                                                AppRouter.argEmployeeId:
                                                    eval.employee,
                                                AppRouter.argDepartment:
                                                    eval.department,
                                                AppRouter.argStatus:
                                                    eval.employeeStatus ??
                                                    PerformanceStatus
                                                        .statusActive,
                                                AppRouter.argEvaluationStatus:
                                                    eval.statusLabel,
                                                AppRouter.argEvaluationId:
                                                    eval.name,
                                                AppRouter.argSelfAssessmentId:
                                                    eval.selfAssessment,
                                              },
                                            );
                                            if (context.mounted) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              context
                                                  .read<TeamEvaluationCubit>()
                                                  .fetchEvaluations();
                                            }
                                          },
                                        );
                                      },
                                      childCount:
                                          state.filteredEvaluations.length,
                                    ),
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
                    );
                  },
                ),
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) async {
    final filterCubit = context.read<TeamEvaluationFilterCubit>();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.of(context).transparent,
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
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r20),
      ),
      child: Row(
        children: [
          Container(
            width: AppConstants.p48,
            height: AppConstants.p48,
            decoration:  BoxDecoration(
              color: AppColors.of(context).surfaceContainerLow,
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
                    color: AppColors.of(context).surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppConstants.r4),
                  ),
                ),
                const SizedBox(height: AppConstants.p8),
                Container(
                  width: AppConstants.p80,
                  height: AppConstants.p12,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surfaceContainerLow,
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
              color: AppColors.of(context).surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
          ),
        ],
      ),
    );
  }
}
