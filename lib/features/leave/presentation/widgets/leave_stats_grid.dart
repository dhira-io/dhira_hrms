import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/generic_error_widget.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_statistics_entity.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import '../../domain/entities/leave_balance_entity.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/widgets/no_internet_widget.dart';

class LeaveStatsGrid extends StatelessWidget {
  final String employeeId;

  const LeaveStatsGrid({
    super.key,
    required this.employeeId,
  });

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
              context.read<LeaveBloc>().add(LeaveEvent.statisticsRequested(
                    employeeId: employeeId,
                    fromDate: now.firstDayOfMonth.format(),
                    toDate: now.lastDayOfMonth.format(),
                  ));
            },
            message: state.statsError,
          );
        }

        if (state.isInitialLoading || state.statistics == null) {
          return _buildShimmerGrid(context);
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
              value: l10n.daysCount(_formatLeaveValue(statistics.cancelledDays)),
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
            padding: const EdgeInsets.only(right: 32),
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
                        fontSize: 22,
                        color: themeColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
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
            right: 0,
            top: 0,
            bottom: 0,
            child: Icon(
              icon,
              color: themeColor,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerGrid(BuildContext context) {
    final colors = AppColors.of(context);
    return Shimmer.fromColors(
      baseColor: colors.surfaceContainerHigh,
      highlightColor: colors.surfaceContainerLowest,
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: AppConstants.p12,
        mainAxisSpacing: AppConstants.p12,
        childAspectRatio: 1.3,
        children: List.generate(4, (index) => Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
        )),
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
