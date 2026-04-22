import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import '../../domain/entities/leave_balance_entity.dart';

class LeaveStatsGrid extends StatelessWidget {
  final LeaveBalanceEntity? balance;
  final bool isLoading;

  const LeaveStatsGrid({
    super.key,
    this.balance,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (isLoading || balance == null) {
      return _buildShimmerGrid();
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppConstants.p12,
      mainAxisSpacing: AppConstants.p12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          title: l10n.applied,
          value: balance!.applied.toString(),
          subtitle: l10n.daysLabel,
          icon: Icons.calendar_today_outlined,
          themeColor: AppColors.info,
          bgColor: AppColors.infoBg,
          borderColor: AppColors.infoBorder,
        ),
        _buildStatCard(
          title: l10n.approved,
          value: balance!.approved.toString(),
          subtitle: l10n.approved,
          icon: Icons.event_available_outlined,
          themeColor: AppColors.success,
          bgColor: AppColors.successBg,
          borderColor: AppColors.successBorder,
        ),
        _buildStatCard(
          title: l10n.approvalPending,
          value: balance!.pending.toString(),
          subtitle: l10n.pendingApproval,
          icon: Icons.pending_actions_outlined,
          themeColor: AppColors.warning,
          bgColor: AppColors.warningBg,
          borderColor: AppColors.warningBorder,
        ),
        _buildStatCard(
          title: l10n.rejected,
          value: (balance!.rejected ?? 0).toString(),
          subtitle: l10n.leavesRejected,
          icon: Icons.cancel_outlined,
          themeColor: AppColors.error,
          bgColor: AppColors.errorBg,
          borderColor: AppColors.errorBorder,
        ),
      ],
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
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: borderColor),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.slate800,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title == 'Rejected' ? value : '$value days',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: themeColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.slate600,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ],
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

  Widget _buildShimmerGrid() {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: AppColors.surface,
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: AppConstants.p12,
        mainAxisSpacing: AppConstants.p12,
        childAspectRatio: 1.6,
        children: List.generate(4, (index) => Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
        )),
      ),
    );
  }
}
