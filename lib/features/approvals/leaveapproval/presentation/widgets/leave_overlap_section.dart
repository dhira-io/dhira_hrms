import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_bloc.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaveOverlapSection extends StatefulWidget {
  final bool hideOverlapAfterSubmit;

  const LeaveOverlapSection({
    super.key,
    required this.hideOverlapAfterSubmit,
  });

  @override
  State<LeaveOverlapSection> createState() => _LeaveOverlapSectionState();
}

class _LeaveOverlapSectionState extends State<LeaveOverlapSection> {
  bool _showOverlapDetails = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveApprovalBloc, LeaveApprovalState>(
      builder: (context, state) {
        if (state.loadingOverlap) {
          return _buildShimmer();
        }

        if (state.overlapLeaves.isEmpty || widget.hideOverlapAfterSubmit) {
          return const SizedBox.shrink();
        }

        final l10n = AppLocalizations.of(context)!;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppConstants.r16),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConstants.p16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Text(
                        state.overlapLeaves.first.employeeName.isNotEmpty
                            ? state.overlapLeaves.first.employeeName
                            .trim()
                            .split(' ')
                            .where((e) => e.isNotEmpty)
                            .take(2)
                            .map((e) => e[0].toUpperCase())
                            .join()
                            : "",
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: AppConstants.p12),
                    Expanded(
                      child: Text(
                        l10n.teamMembersOnLeaveOverlap(
                          state.overlapLeaves.length == 1
                              ? state.overlapLeaves.first.employeeName
                              : state.overlapLeaves.first.employeeName,
                        ),
                        style: AppTextStyle.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showOverlapDetails = !_showOverlapDetails;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            _showOverlapDetails
                                ? l10n.hideDetails
                                : l10n.showDetails,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          Icon(
                            _showOverlapDetails
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (_showOverlapDetails) ...[
                const Divider(height: 1),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppConstants.p16),
                  itemCount: state.overlapLeaves.length,
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: AppConstants.p16),
                  itemBuilder: (context, index) {
                    final leave = state.overlapLeaves[index];
                    return Container(
                      padding: const EdgeInsets.all(AppConstants.p16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppConstants.r12),
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                AppColors.primary.withValues(alpha: 0.05),
                                child: Text(
                                  leave.employeeName.isNotEmpty
                                      ? leave.employeeName
                                      .trim()
                                      .split(' ')
                                      .where((e) => e.isNotEmpty)
                                      .take(2)
                                      .map((e) => e[0].toUpperCase())
                                      .join()
                                      : "",
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: AppConstants.p12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      leave.employeeName,
                                      style: AppTextStyle.bodyMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      leave.designation,
                                      style: AppTextStyle.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.leaveTypeLabel,
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppConstants.p12,
                                  vertical: AppConstants.p4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.05),
                                  borderRadius:
                                  BorderRadius.circular(AppConstants.r20),
                                  border: Border.all(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                  ),
                                ),
                                child: Text(
                                  leave.leaveType,
                                  style: AppTextStyle.bodySmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.p12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.leavePeriod,
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                DateTimeUtils.formatDateRange(
                                    leave.fromDate, leave.toDate),
                                style: AppTextStyle.bodySmall.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(AppConstants.p16),
                child: Text(
                  l10n.planningTip(state.overlapLeaves.length),
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.primary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmer() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.p8),
      child: const ShimmerLoading(
        height: 80,
        width: double.infinity,
        borderRadius: AppConstants.r16,
      ),
    );
  }
}
