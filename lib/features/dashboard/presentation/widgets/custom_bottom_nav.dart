import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/bottom_nav_cubit.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: AppColors.of(context).surface,
              border: Border(
                top: BorderSide(color: AppColors.bordergrey, width: 1),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomNavItemWidget(
                  index: BottomNavCubit.homeIndex,
                  currentIndex: state,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_outlined,
                  label: l10n.home,
                ),
                _BottomNavItemWidget(
                  index: BottomNavCubit.attendanceIndex,
                  currentIndex: state,
                  icon: Icons.calendar_today_outlined,
                  activeIcon: Icons.calendar_today_outlined,
                  label: l10n.calendar,
                ),
                _BottomNavItemWidget(
                  index: BottomNavCubit.approvalsIndex,
                  currentIndex: state,
                  icon: Icons.assignment_outlined,
                  activeIcon: Icons.assignment_outlined,
                  label: l10n.approvals,
                ),
                _BottomNavItemWidget(
                  index: BottomNavCubit.payslipIndex,
                  currentIndex: state,
                  icon: Icons.payments_outlined,
                  activeIcon: Icons.payments_outlined,
                  label: l10n.payslip,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}

class _BottomNavItemWidget extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _BottomNavItemWidget({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () {
        context.read<BottomNavCubit>().changeIndex(index);
        if (index == BottomNavCubit.approvalsIndex) {
          final approvalsBloc = context.read<ApprovalsBloc>();
          final currentState = approvalsBloc.state;

          currentState.maybeMap(
            success: (s) {
              final targetCategory = s.data.access.canAccess
                  ? ApprovalCategory.team
                  : ApprovalCategory.raised;

              approvalsBloc.add(
                ApprovalsEvent.categoryChanged(
                  ApprovalType.leave,
                  targetCategory,
                ),
              );
              approvalsBloc.add(const ApprovalsEvent.refreshSummary());
            },
            orElse: () {
              approvalsBloc.add(const ApprovalsEvent.started());
            },
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p16,
          vertical: AppConstants.p8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.of(context).primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive
                  ? AppColors.of(context).onPrimary
                  : AppColors.of(context).onSurfaceVariant,
              size: AppConstants.iconMedium,
            ),
            if (isActive) ...[
              SizedBox(height: 2.h),
              Text(
                label,
                style: AppTextStyle.labelSmall.copyWith(
                  color: AppColors.of(context).onPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
