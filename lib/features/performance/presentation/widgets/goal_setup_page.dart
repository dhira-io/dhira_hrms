import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_state.dart';
import 'performance_widgets.dart';
import '../bottom_sheets/kra_add_bottom_sheet.dart';
import '../bottom_sheets/kpi_add_bottom_sheet.dart';
import '../../../../core/theme/app_colors.dart';
import '../dialogs/submit_goal_dialog.dart';

class GoalSetupPage extends StatefulWidget {
  const GoalSetupPage({super.key});

  @override
  State<GoalSetupPage> createState() => _GoalSetupPageState();
}

class _GoalSetupPageState extends State<GoalSetupPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Trigger initial data fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PerformanceBloc>().add(const PerformanceStarted());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(l10n.goalSetup, style: AppTextStyle.h2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: AppConstants.iconXSmall),
          onPressed: () => context.pop(),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PerformanceBloc, PerformanceState>(
            listenWhen: (previous, current) =>
                !previous.isLoading && current.isLoading,
            listener: (context, state) {
              if (_scrollController.hasClients &&
                  _scrollController.offset > 0) {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                );
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<PerformanceBloc>().add(const PerformanceStarted());
            await context
                .read<PerformanceBloc>()
                .stream
                .firstWhere((state) => !state.isLoading);
          },
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: AppConstants.p12,
              right: AppConstants.p12,
              top: AppConstants.p12,
              bottom: AppConstants.p100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Job Family Section
                BlocSelector<PerformanceBloc, PerformanceState,
                    ({String value, bool isLoading})>(
                  selector: (state) => (
                    value: state.jobFamily ?? l10n.notAssignedContactHR,
                    isLoading: state.isLoading && state.jobFamily == null,
                  ),
                  builder: (context, data) => PerformanceReadOnlyField(
                    label: l10n.jobFamily,
                    value: data.value,
                    isLoading: data.isLoading,
                  ),
                ),
                const SizedBox(height: AppConstants.p16),

                // 2. PMS Cycle Section
                BlocSelector<PerformanceBloc, PerformanceState,
                    ({String value, bool isLoading})>(
                  selector: (state) => (
                    value: state.pmsCycle ?? AppConstants.placeholderText,
                    isLoading: state.isLoading && state.pmsCycle == null,
                  ),
                  builder: (context, data) => PerformanceReadOnlyField(
                    label: l10n.pmsCycle,
                    value: data.value,
                    isLoading: data.isLoading,
                  ),
                ),
                const SizedBox(height: AppConstants.p24),

                // 3. KRAs Section
                BlocBuilder<PerformanceBloc, PerformanceState>(
                  buildWhen: (prev, curr) =>
                      prev.selectedGoal?.kras != curr.selectedGoal?.kras ||
                      prev.isLoading != curr.isLoading ||
                      prev.isEditable != curr.isEditable,
                  builder: (context, state) {
                    final isEditable = state.isEditable;
                    if (state.selectedGoal != null &&
                        state.selectedGoal!.kras.isNotEmpty) {
                      return PerformanceKraSection(
                        kraWeightages: state.kraWeightages,
                        totalWeightage: state.totalWeightage,
                        progress: state.totalProgress,
                        title: l10n.keyResultAreas,
                        isLoading:
                            state.isLoading && state.selectedGoal == null,
                        isEditable: isEditable,
                        onAdd: () async {
                          final bloc = context.read<PerformanceBloc>();
                          await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: AppColors.transparent,
                            builder: (innerContext) => BlocProvider.value(
                              value: bloc,
                              child: const KraAddBottomSheet(),
                            ),
                          );
                        },
                      );
                    }
                    return PerformanceEmptyStateCard(
                      title: l10n.keyResultAreas,
                      icon: Icons.assignment_outlined,
                      message: l10n.noDataAvailable,
                      actionLabel: l10n.addKra,
                      isEditable: isEditable,
                      onAction: () async {
                        final bloc = context.read<PerformanceBloc>();
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: AppColors.transparent,
                          builder: (innerContext) => BlocProvider.value(
                            value: bloc,
                            child: const KraAddBottomSheet(),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppConstants.p24),

                // 4. KPIs Section
                BlocBuilder<PerformanceBloc, PerformanceState>(
                  buildWhen: (prev, curr) =>
                      prev.kraGroups != curr.kraGroups ||
                      prev.isLoading != curr.isLoading ||
                      prev.isEditable != curr.isEditable,
                  builder: (context, state) {
                    final isEditable = state.isEditable;
                    if (state.selectedGoal != null &&
                        state.selectedGoal!.kras.isNotEmpty) {
                      return PerformanceKpiAccordion(
                        kraGroups: state.kraGroups,
                        title: l10n.kpiDetails,
                        subtitle: l10n.kpiSubtitle,
                        isLoading:
                            state.isLoading && state.selectedGoal == null,
                        isEditable: isEditable,
                        onAddKpi: (kra) async {
                          final bloc = context.read<PerformanceBloc>();
                          await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: AppColors.transparent,
                            builder: (innerContext) => BlocProvider.value(
                              value: bloc,
                              child: KpiAddBottomSheet(kraName: kra.name),
                            ),
                          );
                        },
                      );
                    }
                    return PerformanceEmptyStateCard(
                      title: l10n.kpiQuestions,
                      icon: Icons.search_outlined,
                      message: l10n.noDataToPreview,
                      isLoading: state.isLoading && state.selectedGoal == null,
                      isEditable: isEditable,
                    );
                  },
                ),
                const SizedBox(height: AppConstants.p24),

                // 5. Save Button Section
                BlocBuilder<PerformanceBloc, PerformanceState>(
                  buildWhen: (prev, curr) =>
                      prev.isSaving != curr.isSaving ||
                      prev.isEditable != curr.isEditable,
                  builder: (context, state) {
                    if (!state.isEditable) return const SizedBox.shrink();
                    return PerformanceSaveButton(
                      isLoading: state.isSaving,
                      onPressed: () {
                        context.read<PerformanceBloc>().add(
                              PerformanceEvent.goalSaved(l10n: l10n),
                            );
                      },
                    );
                  },
                ),

                // 6. Action Button Section (Submit)
                BlocBuilder<PerformanceBloc, PerformanceState>(
                  buildWhen: (prev, curr) =>
                      prev.isSubmitting != curr.isSubmitting ||
                      prev.isEditable != curr.isEditable ||
                      prev.selectedGoal?.status != curr.selectedGoal?.status,
                  builder: (context, state) {
                    final isEditable = state.isEditable;
                    return PerformanceActionButton(
                      label: isEditable
                          ? l10n.submitForApproval
                          : (state.selectedGoal?.status ==
                                      PerformanceStatus.completed
                                  ? PerformanceStatus.submitted
                                  : (state.selectedGoal?.status ??
                                      l10n.submitForApproval)),
                      isLoading: state.isSubmitting,
                      isEditable: isEditable,
                      onPressed: () {
                        final bloc = context.read<PerformanceBloc>();
                        showSubmitGoalDialog(
                          context: context,
                          onConfirm: () {
                            bloc.add(PerformanceEvent.goalSubmitted(l10n: l10n));
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
