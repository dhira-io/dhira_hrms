import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/team_evaluation/team_evaluation_cubit.dart';
import '../cubit/team_evaluation/team_evaluation_filter_cubit.dart';
import '../cubit/team_evaluation/team_evaluation_filter_state.dart';
import '../cubit/team_evaluation/team_evaluation_state.dart';
import 'team_evaluation_widgets.dart';

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
      context.read<TeamEvaluationCubit>().fetchEvaluations();
    });
    _searchController.addListener(() {
      context.read<TeamEvaluationFilterCubit>().updateSearch(_searchController.text);
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
            context.read<TeamEvaluationFilterCubit>().setInitialData(evaluations);
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
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Search Bar & Filter Button
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(12),
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
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () => _showFilterBottomSheet(context),
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.filter_list,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Header
                      Text(
                        l10n.teamEvaluation,
                        style: AppTextStyle.h1.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.reviewSelfAssessments,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Quick Stats Bento Grid
                      Row(
                        children: [
                          Expanded(
                            child: TeamEvaluationMetricCard(
                              title: l10n.totalEmployees,
                              value: state.totalCount.toString().padLeft(2, '0'),
                              icon: Icons.group,
                              iconBgColor: AppColors.primaryFixed,
                              iconColor: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TeamEvaluationMetricCard(
                              title: l10n.submitted,
                              value: state.submittedCount.toString().padLeft(2, '0'),
                              icon: Icons.check_circle,
                              iconBgColor: const Color(0xFFD1FAE5),
                              iconColor: const Color(0xFF059669),
                              accentBarColor: const Color(0xFF10B981),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TeamEvaluationMetricCard(
                        title: l10n.pending,
                        value: state.pendingCount.toString().padLeft(2, '0'),
                        icon: Icons.schedule,
                        iconBgColor: const Color(0xFFFEF3C7),
                        iconColor: const Color(0xFFD97706),
                        accentBarColor: const Color(0xFFF59E0B),
                        isFullWidth: true,
                      ),
                      const SizedBox(height: 32),
                    ]),
                  ),
                ),
                BlocBuilder<TeamEvaluationCubit, TeamEvaluationState>(
                  builder: (context, fetchState) {
                    return fetchState.maybeWhen(
                      loading: () => SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildShimmerLoader(),
                            childCount: 5,
                          ),
                        ),
                      ),
                      failure: (message) => SliverFillRemaining(
                        child: Center(child: Text(message)),
                      ),
                      orElse: () {
                        if (state.filteredEvaluations.isEmpty) {
                          return const SliverFillRemaining(
                            child: Center(child: Text('No evaluations found')),
                          );
                        }
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final eval = state.filteredEvaluations[index];
                                return TeamEvaluationEmployeeCard(
                                  name: eval.employee,
                                  role: eval.department,
                                  empId: eval.name,
                                  status: eval.docstatus == 1
                                      ? 'Submitted'
                                      : 'Pending',
                                  onReview: () {
                                    // Navigate to review details
                                  },
                                );
                              },
                              childCount: state.filteredEvaluations.length,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 80,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final filterCubit = context.read<TeamEvaluationFilterCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: filterCubit,
          child: BlocBuilder<TeamEvaluationFilterCubit, TeamEvaluationFilterState>(
            builder: (context, state) {
              return Container(
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter',
                          style: AppTextStyle.h2.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilterLabel('Select Department'),
                        _buildBottomSheetDropdown(
                          value: state.selectedDepartment,
                          items: state.departments,
                          onChanged: (val) => filterCubit.updateDepartment(val),
                        ),
                        const SizedBox(height: 24),
                        _buildFilterLabel('Select Status'),
                        _buildBottomSheetDropdown(
                          value: state.selectedStatus,
                          items: state.statuses,
                          onChanged: (val) => filterCubit.updateStatus(val),
                        ),
                        const SizedBox(height: 32),

                        // Footer Buttons
                        Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primaryContainer,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Apply Filter',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: TextButton(
                            onPressed: () => filterCubit.resetFilters(),
                            child: const Text(
                              'Reset All',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

  Widget _buildFilterLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: AppTextStyle.labelSmall.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBottomSheetDropdown({
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.outline),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.onSurface,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
