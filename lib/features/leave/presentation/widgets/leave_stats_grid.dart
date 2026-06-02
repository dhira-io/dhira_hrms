import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/widgets/generic_error_widget.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'leave_stats_shimmer.dart';

class LeaveStatsGrid extends StatelessWidget {
  final String employeeId;

  const LeaveStatsGrid({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) =>
          previous.statistics != current.statistics ||
          previous.statsError != current.statsError ||
          previous.isInitialLoading != current.isInitialLoading ||
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.statsError != null) {
          return GenericErrorWidget(
            onRetry: () {
              final now = DateTime.now();
              context.read<LeaveBloc>().add(
                LeaveEvent.statisticsRequested(
                  employeeId: employeeId,
                  fromDate: now.firstDayOfMonth.format(),
                  toDate: now.lastDayOfMonth.format(),
                ),
              );
            },
            message: state.statsError,
          );
        }

        if (state.isInitialLoading || state.statistics == null) {
          return const LeaveStatsShimmer();
        }

        final statistics = state.statistics!.statistics;
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppConstants.p12,
          mainAxisSpacing: AppConstants.p12,
          childAspectRatio: 1.3,
          children: [
            _buildStatCard(
              title: l10n.applied,
              value: l10n.daysCount(_formatLeaveValue(statistics.appliedDays)),
              subtitle: l10n.daysLabel,
              icon: Icons.calendar_today_outlined,
              themeColor: AppColors.info,
              bgColor: AppColors.infoBg,
              borderColor: AppColors.infoBorder,
            ),
            _buildStatCard(
              title: l10n.approved,
              value: l10n.daysCount(_formatLeaveValue(statistics.approvedDays)),
              subtitle: l10n.approved,
              icon: Icons.event_available_outlined,
              themeColor: AppColors.success,
              bgColor: AppColors.successBg,
              borderColor: AppColors.successBorder,
            ),
            _buildStatCard(
              title: l10n.approvalPending,
              value: l10n.daysCount(_formatLeaveValue(statistics.pendingDays)),
              subtitle: l10n.pendingApproval,
              icon: Icons.pending_actions_outlined,
              themeColor: AppColors.warning,
              bgColor: AppColors.warningBg,
              borderColor: AppColors.warningBorder,
            ),
            _buildStatCard(
              title: l10n.rejected,
              value: l10n.daysCount(
                _formatLeaveValue(statistics.cancelledDays),
              ),
              subtitle: l10n.leavesRejected,
              icon: Icons.cancel_outlined,
              themeColor: AppColors.error,
              bgColor: AppColors.errorBg,
              borderColor: AppColors.errorBorder,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color themeColor,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: borderColor),
      ),
      child: Stack(
        children: [
          Padding(
            padding:       EdgeInsets.only(right: 32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.slate800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: AppTextStyle.h1.copyWith(
                        fontSize: 22.sp,
                        color: themeColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                          SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.slate600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.w,
            top: 0.h,
            bottom: 0.h,
            child: Icon(icon, color: themeColor, size: 32),
          ),
        ],
      ),
    );
  }

  String _formatLeaveValue(num value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }
}
