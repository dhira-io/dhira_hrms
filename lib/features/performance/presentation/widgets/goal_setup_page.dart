import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<PerformanceBloc, PerformanceState>(
          listenWhen: (previous, current) =>
              !previous.isLoading && current.isLoading,
          listener: (context, state) {
            if (_scrollController.hasClients && _scrollController.offset > 0) {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn,
              );
            }
          },
        ),
        BlocListener<BottomNavCubit, int>(
          listener: (context, state) {
            if (state == BottomNavCubit.performanceIndex) {
              // Reset scroll to top
              if (_scrollController.hasClients &&
                  _scrollController.offset > 0) {
                _scrollController.jumpTo(0);
              }
              // Close any open bottom sheets or alert dialogs
              // We use rootNavigator: true as dialogs are pushed onto the root navigator
              Navigator.of(
                context,
                rootNavigator: true,
              ).popUntil((route) => route is! PopupRoute);
            }
          },
        ),
      ],
      child: BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (context, state) {
          final String jobFamilyValue =
              state.jobFamily ?? l10n.notAssignedContactHR;
          final String pmsCycleValue =
              state.pmsCycle ?? AppConstants.placeholderText;
          final bool isEditable = state.isEditable;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: AppConstants.p12,
                    right: AppConstants.p12,
                    top: AppConstants.p24,
                    bottom: AppConstants.p100, // Extra space at bottom
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Job Family (Uneditable)
                      PerformanceReadOnlyField(
                        label: l10n.jobFamily,
                        value: jobFamilyValue,
                        isLoading: state.isLoading && state.jobFamily == null,
                      ),
                      const SizedBox(height: AppConstants.p16),

                      // PMS Cycle (Uneditable)
                      PerformanceReadOnlyField(
                        label: l10n.pmsCycle,
                        value: pmsCycleValue,
                        isLoading: state.isLoading && state.pmsCycle == null,
                      ),
                      const SizedBox(height: AppConstants.p24),

                      // KRAs Section
                      if (state.selectedGoal != null &&
                          state.selectedGoal!.kpis.isNotEmpty)
                        PerformanceKraSection(
                          kraWeightages: state.kraWeightages,
                          totalWeightage: state.totalWeightage,
                          progress: state.totalProgress,
                          title: l10n.keyResultAreas,
                          isLoading: state.isLoading,
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
                        )
                      else
                        PerformanceEmptyStateCard(
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
                        ),
                      const SizedBox(height: AppConstants.p24),

                      // KPIs Section
                      if (state.selectedGoal != null &&
                          state.selectedGoal!.kpis.isNotEmpty)
                        PerformanceKpiAccordion(
                          kraGroups: state.kraGroups,
                          title: l10n.kpiDetails,
                          subtitle: l10n.kpiSubtitle,
                          isLoading: state.isLoading,
                          isEditable: isEditable,
                          onAddKpi: (kraName) async {
                            final bloc = context.read<PerformanceBloc>();
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: AppColors.transparent,
                              builder: (innerContext) => BlocProvider.value(
                                value: bloc,
                                child: KpiAddBottomSheet(kraName: kraName),
                              ),
                            );
                          },
                        )
                      else
                        PerformanceEmptyStateCard(
                          title: l10n.kpiQuestions,
                          icon: Icons.search_outlined,
                          message: l10n.noDataToPreview,
                          isLoading: state.isLoading,
                          isEditable: isEditable,
                        ),
                      const SizedBox(height: AppConstants.p24),
                      if (isEditable) ...[
                        PerformanceSaveButton(
                          isLoading: state.isSaving,
                          onPressed: () {
                            context.read<PerformanceBloc>().add(
                              PerformanceEvent.goalSaved(l10n: l10n),
                            );
                          },
                        ),
                      ],
                      PerformanceActionButton(
                        label: isEditable
                            ? l10n.submitForApproval
                            : (state.selectedGoal?.status ??
                                  l10n.submitForApproval),
                        isLoading: state.isSubmitting,
                        isEditable: isEditable,
                        onPressed: () {
                          final bloc = context.read<PerformanceBloc>();
                          showSubmitGoalDialog(
                            context: context,
                            onConfirm: () {
                              bloc.add(
                                PerformanceEvent.goalSubmitted(l10n: l10n),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
