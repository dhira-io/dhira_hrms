import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/leave_balance_entity.dart';
import 'leave_info_row.dart';

class LeaveBalanceOverviewCard extends StatefulWidget {
  final LeaveBalanceEntity? balance;
  final bool isLoading;

  const LeaveBalanceOverviewCard({
    super.key,
    this.balance,
    this.isLoading = false,
  });

  @override
  State<LeaveBalanceOverviewCard> createState() => _LeaveBalanceOverviewCardState();
}

class _LeaveBalanceOverviewCardState extends State<LeaveBalanceOverviewCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading || widget.balance == null) {
      return const LeaveBalanceOverviewShimmer();
    }

    final l10n = AppLocalizations.of(context)!;
    final details = widget.balance!.details;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(AppConstants.r12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        l10n.leaveBalanceOverview,
                        style: AppTextStyle.h3.copyWith(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: AppConstants.p12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.secondary.withOpacity(0.1)),
                        ),
                        child: Text(
                          l10n.availableStatus(widget.balance!.available.toString()),
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: AppColors.outline,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Detailed Content
          if (_isExpanded) ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppConstants.p16),
              itemCount: details.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppConstants.p16),
              itemBuilder: (context, index) {
                final item = details[index];
                return _buildDetailCard(item);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailCard(LeaveDetailedBalanceEntity item) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.slate50.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.leaveType,
            style: AppTextStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 16),
          LeaveInfoRow(label: l10n.allocatedLabel, value: item.allocated.toString()),
          const SizedBox(height: 8),
          LeaveInfoRow(label: l10n.usedLabel, value: item.used.toString()),
          const SizedBox(height: 8),
          const Divider(height: 1, color: AppColors.outlineVariant, thickness: 0.5),
          const SizedBox(height: 12),
          LeaveInfoRow(
            label: l10n.availableLabel,
            value: item.available.toString(),
            valueColor: AppColors.secondary,
            isBold: true,
          ),
        ],
      ),
    );
  }



}

class LeaveBalanceOverviewShimmer extends StatelessWidget {
  const LeaveBalanceOverviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: AppColors.surface,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
      ),
    );
  }
}
