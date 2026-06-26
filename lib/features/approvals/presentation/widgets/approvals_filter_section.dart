import 'package:dhira_hrms/features/approvals/data/constants/approvals_api_constants.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class ApprovalsFilterSection extends StatelessWidget {
  const ApprovalsFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ApprovalsBloc, ApprovalsState>(
      builder: (context, state) {
        if (state is! Success) return const SizedBox.shrink();
        final successData = state.data;
        final isTeam = successData.category == ApprovalCategory.team;

        final typeItems = [
          ApprovalType.leave,
          ApprovalType.attendance,
          ApprovalType.timesheet,
          ApprovalType.compOff,
        ];

        final statusItems = [
          ApprovalStatus.allRequests,
          ApprovalStatus.pending,
          ApprovalStatus.approved,
          ApprovalStatus.rejected,
          ApprovalStatus.cancelled,
        ];

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.p16,
            vertical: AppConstants.p8,
          ),
          decoration: BoxDecoration(
            color: colors.background,
            border: Border(
              bottom: BorderSide(
                color: colors.primary.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                height: 32.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                  border: Border.all(
                    color: colors.outlineVariant,
                  ),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  onChanged: (value) {
                    context.read<ApprovalsBloc>().add(
                          ApprovalsEvent.searchQueryChanged(value),
                        );
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: l10n.searchByDateName,
                    hintStyle: AppTextStyle.bodyMedium.copyWith(
                      color: colors.onSecondaryContainer,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 6.w),
                      child: Icon(
                        Icons.search,
                        color: colors.outlineVariant,
                        size: 20.w,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 34.w,
                      maxHeight: 36.h,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.only(
                      right: AppConstants.p12,
                      top: 8.h,
                      bottom: 8.h,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.p16),
              // Dropdowns Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.typeLabel,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: colors.username,
                          ),
                        ),
                        const SizedBox(height: AppConstants.p4),
                        Container(
                          height: 32.h,
                          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12),
                          decoration: BoxDecoration(
                            color: colors.surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(AppConstants.r8),
                            border: Border.all(
                              color: colors.outlineVariant,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<ApprovalType>(
                              isExpanded: true,
                              value: successData.type,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: typeItems.map((ApprovalType type) {
                                return DropdownMenuItem<ApprovalType>(
                                  value: type,
                                  child: Text(
                                    _getTypeLabel(type, context),
                                    style: AppTextStyle.labelLarge.copyWith(
                                      color: colors.onSurface,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (ApprovalType? newValue) {
                                if (newValue != null && newValue != successData.type) {
                                  context.read<ApprovalsBloc>().add(
                                        ApprovalsEvent.categoryChanged(
                                          newValue,
                                          successData.category,
                                        ),
                                      );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppConstants.p12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.statusLabel,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: colors.username,
                          ),
                        ),
                        const SizedBox(height: AppConstants.p4),
                        Container(
                          height: 32.h,
                          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12),
                          decoration: BoxDecoration(
                            color: colors.surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(AppConstants.r8),
                            border: Border.all(
                              color: colors.outlineVariant,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: successData.statusFilter,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: statusItems.map((String status) {
                                return DropdownMenuItem<String>(
                                  value: status,
                                  child: Text(
                                    status,
                                    style: AppTextStyle.labelLarge.copyWith(
                                      color: colors.onSurface,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  context.read<ApprovalsBloc>().add(
                                        ApprovalsEvent.statusFilterChanged(newValue),
                                      );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        );
      },
    );
  }

  String _getTypeLabel(ApprovalType type, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case ApprovalType.leave:
        return l10n.leave;
      case ApprovalType.attendance:
        return l10n.attendance;
      case ApprovalType.timesheet:
        return l10n.timesheet;
      case ApprovalType.compOff:
        return l10n.comOff;
    }
  }
}
