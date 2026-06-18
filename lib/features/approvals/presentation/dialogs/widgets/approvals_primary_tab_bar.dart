import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/approvals_bloc.dart';
import '../../bloc/approvals_event.dart';
import '../../bloc/approvals_state.dart';
import '../../../domain/entities/approval_type.dart';
import '../../../domain/entities/approval_request_entity.dart';

class ApprovalsPrimaryTabBar extends StatelessWidget {
  const ApprovalsPrimaryTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocSelector<ApprovalsBloc, ApprovalsState, int>(
      selector: (state) => state.maybeMap(
        success: (s) => s.data.category.getIndex(s.data.access.canAccess),
        orElse: () => 0,
      ),
      builder: (context, selectedIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildTab(
                    context,
                    label: l10n.teamApprovals,
                    isSelected: selectedIndex == 0,
                    onTap: () => _handleTap(context, 0),
                  ),
                ),
                Expanded(
                  child: _buildTab(
                    context,
                    label: l10n.raisedRequests,
                    isSelected: selectedIndex == 1,
                    onTap: () => _handleTap(context, 1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleTap(BuildContext context, int index) {
    final state = context.read<ApprovalsBloc>().state;
    state.maybeMap(
      success: (s) {
        final canAccess = s.data.access.canAccess;
        final newCategory = ApprovalCategoryX.fromIndex(index, canAccess);
        if (s.data.category != newCategory) {
          context.read<ApprovalsBloc>().add(
            ApprovalsEvent.categoryChanged(ApprovalType.leave, newCategory),
          );
        }
      },
      orElse: () {},
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:       EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.of(context).surfaceContainerLowest
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.r10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.of(context).black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: isSelected
              ? AppTextStyle.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.of(context).primary,
                )
              : AppTextStyle.labelLarge.copyWith(
                  color: AppColors.of(context).onSurfaceVariant,
                ),
        ),
      ),
    );
  }
}
