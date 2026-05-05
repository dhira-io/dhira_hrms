import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../cubit/team_evaluation/team_evaluation_filter_cubit.dart';
import '../cubit/team_evaluation/team_evaluation_filter_state.dart';

class TeamEvaluationFilterBottomSheet extends StatelessWidget {
  const TeamEvaluationFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filterCubit = context.read<TeamEvaluationFilterCubit>();

    return BlocBuilder<TeamEvaluationFilterCubit, TeamEvaluationFilterState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppConstants.r32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: AppConstants.p12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(AppConstants.r2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.p24,
                  AppConstants.p24,
                  AppConstants.p16,
                  AppConstants.p16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.filter,
                      style: AppTextStyle.h2Bold.copyWith(
                        fontSize: AppConstants.fs20,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterLabel(l10n.selectDepartment),
                    _buildBottomSheetDropdown(
                      context,
                      value: state.selectedDepartment,
                      items: state.departments,
                      onChanged: (val) => filterCubit.updateDepartment(val),
                    ),
                    const SizedBox(height: AppConstants.p24),
                    _buildFilterLabel(l10n.selectStatus),
                    _buildBottomSheetDropdown(
                      context,
                      value: state.selectedStatus,
                      items: state.statuses,
                      onChanged: (val) => filterCubit.updateStatus(val),
                    ),
                    const SizedBox(height: AppConstants.p32),

                    // Footer Buttons
                    Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.r12),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primaryContainer,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(
                              alpha: AppConstants.opacitySlight,
                            ),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.transparent,
                          foregroundColor: AppColors.white,
                          shadowColor: AppColors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.r12,
                            ),
                          ),
                        ),
                        child: Text(
                          l10n.applyFilter,
                          style: AppTextStyle.labelLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.p12),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: TextButton(
                        onPressed: () => filterCubit.resetFilters(),
                        child: Text(
                          l10n.resetAll,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.p40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.p8),
      child: Text(
        label,
        style: AppTextStyle.labelSmall.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBottomSheetDropdown(
    BuildContext context, {
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppConstants.r12),
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
                _translate(context, value),
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

  String _translate(BuildContext context, String value) {
    final l10n = AppLocalizations.of(context)!;
    if (value == PerformanceStatus.allDepartment) return l10n.allDepartment;
    if (value == PerformanceStatus.allStatus) return l10n.allStatus;
    if (value == PerformanceStatus.submitted) return l10n.submittedStatus;
    if (value == PerformanceStatus.pending) return l10n.pendingStatus;
    return value;
  }
}
