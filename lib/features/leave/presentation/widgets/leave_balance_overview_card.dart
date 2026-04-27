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

  String _formatValue(num value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

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
        color: AppColors.earnedTrack.withOpacity(0.4),
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.leaveBg,
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_rounded,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: AppConstants.p16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                            l10n.leaveBalanceOverview,
                            style: AppTextStyle.h3.copyWith(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.normal,
                              color: AppColors.onSurface,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.availableStatus(_formatValue(widget.balance!.available)),
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppConstants.p8),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.slate500,
                    size: 24,
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
          LeaveInfoRow(
            label: l10n.allocatedLabel,
            value: _formatValue(item.allocated),
            valueFontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          LeaveInfoRow(
            label: l10n.usedLabel,
            value: _formatValue(item.pending),
            valueFontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: AppColors.outlineVariant, thickness: 0.5),
          const SizedBox(height: 12),
          LeaveInfoRow(
            label: l10n.availableLabel,
            value: _formatValue(item.available),
            valueColor: AppColors.secondary,
            valueFontWeight: FontWeight.bold,
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
