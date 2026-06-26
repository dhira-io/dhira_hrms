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
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ApprovalsBloc, ApprovalsState>(
      builder: (context, state) {
        int selectedIndex = 0;
        int badgeCount = 0;
        if (state.status == ApprovalsStatus.success && state.data != null) { final s = state; 
            selectedIndex = s.data!.category.getIndex(s.data!.access.canAccess);
            badgeCount = s.data!.summary.totalAllPending;
           } else {  }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          child: Container(
            height: 44.h,
            decoration: BoxDecoration(
              color: colors.profileTabBg, // From design spec
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _ApprovalTabWidget(
                    label: l10n.teamApprovals,
                    isSelected: selectedIndex == 0,
                    badgeCount: badgeCount,
                    onTap: () => _handleTap(context, 0),
                  ),
                ),
                Expanded(
                  child: _ApprovalTabWidget(
                    label: l10n.raisedRequests,
                    isSelected: selectedIndex == 1,
                    badgeCount: 0,
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
    if (state.status == ApprovalsStatus.success && state.data != null) { final s = state; 
        final canAccess = s.data!.access.canAccess;
        final newCategory = ApprovalCategoryX.fromIndex(index, canAccess);
        if (s.data!.category != newCategory) {
          context.read<ApprovalsBloc>().add(
            ApprovalsEvent.categoryChanged(ApprovalType.leave, newCategory),
          );
        }
       } else {  }
  }
}

class _ApprovalTabWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onTap;

  const _ApprovalTabWidget({
    required this.label,
    required this.isSelected,
    required this.badgeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.r10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: isSelected
                  ? AppTextStyle.labelLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    )
                  : AppTextStyle.labelLarge.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
            ),
            if (badgeCount > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colors.error,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badgeCount.toString().padLeft(2, '0'),
                  style: AppTextStyle.labelSmall.copyWith(
                    color: colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
