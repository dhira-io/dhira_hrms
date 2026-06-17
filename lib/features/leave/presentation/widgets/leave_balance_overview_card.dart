import 'package:dhira_hrms/core/widgets/generic_error_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/leave_balance_entity.dart';
import 'leave_info_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';

class LeaveBalanceOverviewCard extends StatefulWidget {
  final String employeeId;
  final String gender;

  const LeaveBalanceOverviewCard({
    super.key,
    required this.employeeId,
    required this.gender,
  });

  @override
  State<LeaveBalanceOverviewCard> createState() =>
      _LeaveBalanceOverviewCardState();
}

class _LeaveBalanceOverviewCardState extends State<LeaveBalanceOverviewCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(
      buildWhen: (previous, current) =>
          previous.balance != current.balance ||
          previous.balanceError != current.balanceError ||
          previous.isInitialLoading != current.isInitialLoading ||
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.balanceError != null) {
          return GenericErrorWidget(
            onRetry: () {
              context.read<LeaveBloc>().add(
                LeaveEvent.balanceRequested(
                  employeeId: widget.employeeId,
                  todayDate: DateTimeUtils.todayDate(),
                  gender: widget.gender,
                ),
              );
            },
            message: state.balanceError,
          );
        }

        if (state.isInitialLoading) {
          return const LeaveBalanceOverviewShimmer();
        }

        final l10n = AppLocalizations.of(context)!;
        final details = state.balance.details;
        final double totalAvailable = details.fold(
          0.0,
          (sum, item) => sum + item.available,
        );

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: AppColors.of(context).earnedTrack.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(AppConstants.r12),
            border: Border.all(
              color: AppColors.of(context).primary.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.of(context).black.withValues(alpha: 0.02),
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
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.of(context).leaveBg,
                          borderRadius: BorderRadius.circular(AppConstants.r12),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet_rounded,
                          color: AppColors.of(context).primary,
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
                                fontFamily: AppTextStyle.headingFont,
                                fontWeight: FontWeight.normal,
                                color: AppColors.of(context).onSurface,
                                fontSize: AppConstants.fs14.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              l10n.availableStatus(
                                _formatLeaveValue(totalAvailable),
                              ),
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.of(context).primary,
                                fontWeight: FontWeight.w600,
                                fontSize: AppConstants.fs13.sp,
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
                        color: AppColors.of(context).slate500,
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
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppConstants.p16),
                  itemBuilder: (context, index) {
                    final item = details[index];
                    return LeaveDetailCard(item: item);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class LeaveDetailCard extends StatelessWidget {
  final LeaveDetailedBalanceEntity item;

  const LeaveDetailCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).slate50.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(
          color: AppColors.of(context).outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.leaveType,
            style: AppTextStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.of(context).onSurface,
              fontSize: AppConstants.fs15.sp,
            ),
          ),
          SizedBox(height: 16.h),
          LeaveInfoRow(
            label: l10n.allocatedLabel,
            value: _formatLeaveValue(item.allocated),
            valueFontWeight: FontWeight.w500,
          ),
          SizedBox(height: 8.h),
          LeaveInfoRow(
            label: l10n.usedLabel,
            value: _formatLeaveValue(item.used),
            valueFontWeight: FontWeight.w500,
          ),
          SizedBox(height: 8.h),
          Divider(
            height: 1.h,
            color: AppColors.of(context).outlineVariant,
            thickness: 0.5,
          ),
          SizedBox(height: 12.h),
          LeaveInfoRow(
            label: l10n.availableLabel,
            value: _formatLeaveValue(item.available),
            valueColor: AppColors.of(context).secondary,
            valueFontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}

String _formatLeaveValue(num value) {
  if (value == value.toInt()) {
    return value.toInt().toString();
  }
  return value.toString();
}

class LeaveBalanceOverviewShimmer extends StatelessWidget {
  const LeaveBalanceOverviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.of(context).border,
      highlightColor: AppColors.of(context).surface,
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppColors.of(context).white,
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
      ),
    );
  }
}
