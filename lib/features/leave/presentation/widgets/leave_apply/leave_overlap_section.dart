import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/utils/date_time_utils.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/entities/overlap_leave_entity.dart';

class LeaveOverlapSection extends StatefulWidget {
  final List<OverlapLeaveEntity> overlapLeaves;
  final bool hideOverlapAfterSubmit;

  const LeaveOverlapSection({
    super.key,
    required this.overlapLeaves,
    required this.hideOverlapAfterSubmit,
  });

  @override
  State<LeaveOverlapSection> createState() => _LeaveOverlapSectionState();
}

class _LeaveOverlapSectionState extends State<LeaveOverlapSection> {
  bool _showOverlapDetails = false;

  @override
  Widget build(BuildContext context) {
    if (widget.overlapLeaves.isEmpty || widget.hideOverlapAfterSubmit) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(
          color: AppColors.of(context).primary.withValues(alpha: 0.1),
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
                  backgroundColor: AppColors.of(context).primary.withValues(alpha: 0.1),
                  child: Text(
                    widget.overlapLeaves.first.employeeName.isNotEmpty
                        ? widget.overlapLeaves.first.employeeName
                            .trim()
                            .split(' ')
                            .where((e) => e.isNotEmpty)
                            .take(2)
                            .map((e) => e[0].toUpperCase())
                            .join()
                        : "",
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: AppColors.of(context).primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.p12),
                Expanded(
                  child: Text(
                    l10n.teamMembersOnLeaveOverlap(
                      widget.overlapLeaves.length == 1
                          ? widget.overlapLeaves.first.employeeName
                          : widget.overlapLeaves.first.employeeName,
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
                          color: AppColors.of(context).primary,
                        ),
                      ),
                      Icon(
                        _showOverlapDetails
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 18,
                        color: AppColors.of(context).primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_showOverlapDetails) ...[
            Divider(height: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppConstants.p16),
              itemCount: widget.overlapLeaves.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppConstants.p16),
              itemBuilder: (context, index) {
                final leave = widget.overlapLeaves[index];
                return Container(
                  padding: const EdgeInsets.all(AppConstants.p16),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                    border: Border.all(
                      color: AppColors.of(context).outlineVariant.withValues(alpha: 0.5),
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
                                AppColors.of(context).primary.withValues(alpha: 0.05),
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
                                color: AppColors.of(context).primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppConstants.p12),
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
                                    color: Colors.grey,
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
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.p12,
                              vertical: AppConstants.p4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.of(context).primary.withValues(alpha: 0.05),
                              borderRadius:
                                  BorderRadius.circular(AppConstants.r20),
                              border: Border.all(
                                color: AppColors.of(context).primary.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Text(
                              leave.leaveType,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.of(context).primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.p12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.leavePeriod,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: Colors.grey,
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
              l10n.planningTip(widget.overlapLeaves.length),
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.of(context).primary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
