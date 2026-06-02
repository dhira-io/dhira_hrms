import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_button.dart';
import '../cubit/team_evaluation/team_evaluation_filter_cubit.dart';
import '../cubit/team_evaluation/team_evaluation_filter_state.dart';

class TeamEvaluationFilterBottomSheet extends StatefulWidget {
  const TeamEvaluationFilterBottomSheet({super.key});

  @override
  State<TeamEvaluationFilterBottomSheet> createState() =>
      _TeamEvaluationFilterBottomSheetState();
}

class _TeamEvaluationFilterBottomSheetState
    extends State<TeamEvaluationFilterBottomSheet> {
  String? _tempDepartment;
  String? _tempStatus;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filterCubit = context.read<TeamEvaluationFilterCubit>();

    return BlocBuilder<TeamEvaluationFilterCubit, TeamEvaluationFilterState>(
      builder: (context, state) {
        _tempDepartment ??= state.selectedDepartment;
        _tempStatus ??= state.selectedStatus;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
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
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.of(context).outlineVariant,
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
                    _FilterLabel(label: l10n.selectDepartment),
                    _BottomSheetDropdown(
                      value: _tempDepartment!,
                      items: state.departments,
                      onChanged: (val) {
                        setState(() {
                          _tempDepartment = val;
                        });
                      },
                    ),
                    const SizedBox(height: AppConstants.p24),
                    _FilterLabel(label: l10n.selectStatus),
                    _BottomSheetDropdown(
                      value: _tempStatus!,
                      items: state.statuses,
                      onChanged: (val) {
                        setState(() {
                          _tempStatus = val;
                        });
                      },
                    ),
                    const SizedBox(height: AppConstants.p32),

                    // Footer Buttons
                    CommonButton(
                      text: l10n.applyFilter,
                      onPressed: () {
                        filterCubit.applyFilters(
                          department: _tempDepartment!,
                          status: _tempStatus!,
                        );
                        Navigator.pop(context);
                      },
                      width: double.infinity,
                    ),
                    const SizedBox(height: AppConstants.p12),
                    SizedBox(
                      width: double.infinity,
                      height: 54.h,
                      child: TextButton(
                        onPressed: () {
                          filterCubit.resetFilters();
                          Navigator.pop(context);
                        },
                        child: Text(
                          l10n.resetAll,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: AppColors.of(context).primary,
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
}

class _FilterLabel extends StatelessWidget {
  final String label;

  const _FilterLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.p8),
      child: Text(
        label,
        style: AppTextStyle.labelSmall.copyWith(
          color: AppColors.of(context).onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _BottomSheetDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String) onChanged;

  const _BottomSheetDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  String _translate(BuildContext context, String value) {
    final l10n = AppLocalizations.of(context)!;
    if (value == PerformanceStatus.allDepartment) return l10n.allDepartment;
    if (value == PerformanceStatus.allStatus) return l10n.allStatus;
    if (value == PerformanceStatus.submitted) return l10n.submittedStatus;
    if (value == PerformanceStatus.pending) return l10n.pendingStatus;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainer,
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.of(context).outline,
          ),
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
                  color: AppColors.of(context).onSurface,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
