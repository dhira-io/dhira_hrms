import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/team_leave_entity.dart';

class OnLeaveTodaySection extends StatelessWidget {
  final List<TeamLeaveEntity>? leaves;

  const OnLeaveTodaySection({super.key, this.leaves});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
          child: Text(
            l10n.teamOnLeave,
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (leaves == null)
          const Center(child: CircularProgressIndicator())
        else if (leaves!.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.p20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppConstants.r16),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textPrimary.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                l10n.noOneOnLeaveToday,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
            itemCount: leaves!.length,
            itemBuilder: (context, index) {
              final leave = leaves![index];
              return _TeamLeaveCard(leave: leave);
            },
          ),
        const SizedBox(height: AppConstants.p24),
      ],
    );
  }
}

class _TeamLeaveCard extends StatelessWidget {
  final TeamLeaveEntity leave;

  const _TeamLeaveCard({required this.leave});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: leave.image != null ? NetworkImage(leave.image!) : null,
            child: leave.image == null ? const Icon(Icons.person) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leave.employeeName,
                  style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  leave.leaveType,
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
