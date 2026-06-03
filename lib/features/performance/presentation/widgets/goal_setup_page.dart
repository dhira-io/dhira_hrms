import 'package:dhira_hrms/features/performance/presentation/bloc/performance_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_state.dart';
import 'performance_widgets.dart';
import '../bottom_sheets/kra_add_bottom_sheet.dart';
import '../bottom_sheets/kpi_add_bottom_sheet.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../dialogs/submit_goal_dialog.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../core/widgets/generic_error_widget.dart';
import '../utils/performance_error_utils.dart';

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
      backgroundColor: AppColors.of(context).background,
      appBar: CommonAppBar(
        title: l10n.goalSetup,
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
        child: BlocBuilder<PerformanceBloc, PerformanceState>(
          builder: (context, state) {
            if (state.maybeMap(
              error: (errorState) => PerformanceErrorUtils
                  .isServerErrorMessage(errorState.errorMessage),
              orElse: () => false,
            )) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<PerformanceBloc>().add(const PerformanceStarted());
                  await context
                      .read<PerformanceBloc>()
                      .stream
                      .firstWhere((state) => !state.isLoading);
                },
                color: AppColors.of(context).primary,
                backgroundColor: AppColors.of(context).surface,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: GenericErrorWidget(
                        onRetry: () {
                          context.read<PerformanceBloc>().add(
                                const PerformanceStarted(),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            final isEditable = state.isEditable &&
                state.jobFamily != null &&
                state.jobFamily!.isNotEmpty;

            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<PerformanceBloc>().add(const PerformanceStarted());
                      await context
                          .read<PerformanceBloc>()
                          .stream
                          .firstWhere((state) => !state.isLoading);
                    },
                    color: AppColors.of(context).primary,
                    backgroundColor: AppColors.of(context).surface,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                        left: AppConstants.p12,
                        right: AppConstants.p12,
                        top: AppConstants.p12,
                        bottom: AppConstants.p24,
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
                                prev.isEditable != curr.isEditable ||
                                prev.jobFamily != curr.jobFamily,
                            builder: (context, state) {
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
                                      backgroundColor: AppColors.of(context).transparent,
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
                                    backgroundColor: AppColors.of(context).transparent,
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
                              final isEditable = state.isEditable &&
                                  state.jobFamily != null &&
                                  state.jobFamily!.isNotEmpty;
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
                                      backgroundColor: AppColors.of(context).transparent,
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
                        ],
                      ),
                    ),
                  ),
                ),
                GoalSetupBottomSection(
                  state: state,
                  l10n: l10n,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class GoalSetupBottomSection extends StatelessWidget {
  final PerformanceState state;
  final AppLocalizations l10n;

  const GoalSetupBottomSection({
    super.key,
    required this.state,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    if (state.selectedGoal == null) {
      return const SizedBox.shrink();
    }

    final isEditable = state.isEditable;
    if (!isEditable) {
      return GoalSetupStatusView(
        status: state.selectedGoal?.status ?? PerformanceStatus.submitted,
      );
    }

    final krasCount = state.selectedGoal?.kras.length ?? 0;
    final hasMinimumKras = krasCount >= 3;
    final isEnabled = hasMinimumKras;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.1),
            blurRadius: AppConstants.r10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CommonButton(
              text: l10n.save,
              onPressed: () {
                if (state.isSaving || state.isSubmitting) return;
                context.read<PerformanceBloc>().add(
                      PerformanceEvent.goalSaved(l10n: l10n),
                    );
              },
              variant: ButtonVariant.outlined,
              isLoading: state.isSaving,
            ),
          ),
          const SizedBox(width: AppConstants.p16),
          Expanded(
            flex: 2,
            child: CommonButton(
              text: l10n.submitForApproval,
              onPressed: isEnabled
                  ? () {
                      if (state.isSaving || state.isSubmitting) return;
                      final bloc = context.read<PerformanceBloc>();
                      showSubmitGoalDialog(
                        context: context,
                        onConfirm: () {
                          bloc.add(PerformanceEvent.goalSubmitted(l10n: l10n));
                        },
                      );
                    }
                  : null,
              isLoading: state.isSubmitting,
            ),
          ),
        ],
      ),
    );
  }
}

class GoalSetupStatusView extends StatelessWidget {
  final String status;

  const GoalSetupStatusView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isSubmitted = status.toLowerCase() == PerformanceStatus.submitted.toLowerCase() ||
        status.toLowerCase() == PerformanceStatus.approved.toLowerCase() ||
        status.toLowerCase() == PerformanceStatus.completed.toLowerCase();

    final isRejected = status.toLowerCase() == PerformanceStatus.rejected.toLowerCase();

    final bgColor = isSubmitted
        ? AppColors.of(context).successBg
        : (isRejected ? AppColors.of(context).errorBg : AppColors.of(context).warningBg);

    final borderColor = isSubmitted
        ? AppColors.of(context).successBorder
        : (isRejected ? AppColors.of(context).errorBorder : AppColors.of(context).warningBorder);

    final textColor = isSubmitted
        ? AppColors.of(context).successDark
        : (isRejected ? AppColors.of(context).error : AppColors.of(context).warning);

    final icon = isSubmitted
        ? Icons.check_circle_outline
        : (isRejected ? Icons.error_outline : Icons.pending_outlined);

    final displayStatus = status.toLowerCase() == PerformanceStatus.completed.toLowerCase()
        ? PerformanceStatus.submitted
        : status;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.05),
            blurRadius: AppConstants.r8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppConstants.r12),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: textColor,
                size: AppConstants.iconSmall,
              ),
              const SizedBox(width: AppConstants.p8),
              Text(
                displayStatus.toUpperCase(),
                style: AppTextStyle.labelMedium.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
