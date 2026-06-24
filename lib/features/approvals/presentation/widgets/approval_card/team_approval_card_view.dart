import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/data/constants/approvals_api_constants.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/widgets/approval_card/approval_card_header.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamApprovalCardView extends StatefulWidget {
  final ApprovalRequestEntity data;
  final bool isSelected;
  final Function(bool)? onSelectionChanged;
  final Function(String) onAction;
  final bool isProcessing;

  const TeamApprovalCardView({
    super.key,
    required this.data,
    required this.isSelected,
    this.onSelectionChanged,
    required this.onAction,
    this.isProcessing = false,
  });

  @override
  State<TeamApprovalCardView> createState() => _TeamApprovalCardViewState();
}

class _TeamApprovalCardViewState extends State<TeamApprovalCardView> {
  String? _lastAction;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final titleInfo = _getTitleAndSubtitle(context);
    final l10n = AppLocalizations.of(context)!;

    final String normStatus = widget.data.status.toLowerCase();
    final bool isProcessed = [
      ApprovalStatus.approved.toLowerCase(),
      ApprovalStatus.rejected.toLowerCase(),
      ApprovalStatus.cancelled.toLowerCase(),
    ].contains(normStatus);

    bool showApprove = true;
    bool showReject = true;
    bool isApproveEnabled = false;
    bool isRejectEnabled = false;

    switch (widget.data.type) {
      case ApprovalType.leave:
        isApproveEnabled = widget.data.availableActions.contains(ApprovalActions.approve);
        isRejectEnabled = widget.data.availableActions.contains(ApprovalActions.reject);
        break;
      case ApprovalType.attendance:
      case ApprovalType.compOff:
        isApproveEnabled = !isProcessed;
        isRejectEnabled = !isProcessed;
        break;
      case ApprovalType.timesheet:
        showReject = false;
        isApproveEnabled = !isProcessed;
        isRejectEnabled = !isProcessed;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ApprovalCardHeader(
          data: widget.data,
          isSelected: widget.isSelected,
          onSelectionChanged: widget.onSelectionChanged,
        ),
        const SizedBox(height: AppConstants.p16),
        // Title format (e.g. "Casual Leave · 3 days")
        Padding(
          padding: EdgeInsets.only(left: _getLeftPadding()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleInfo.title,
                style: AppTextStyle.labelSmall.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppConstants.p8),
              Text(
                titleInfo.subtitle,
                style: AppTextStyle.bodySmall.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        if (!isProcessed && (showApprove || showReject)) ...[
          const SizedBox(height: AppConstants.p16),
          Divider(color: colors.outlineVariant, height: 1),
          const SizedBox(height: AppConstants.p16),
          Row(
            children: [
              if (showReject)
                Expanded(
                  child: OutlinedButton(
                    onPressed: isRejectEnabled && !widget.isProcessing ? () {
                      setState(() => _lastAction = ApprovalActions.reject);
                      widget.onAction(ApprovalActions.reject);
                    } : null,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      backgroundColor: AppColors.rejectedBg,
                      side: BorderSide(color: colors.error.withValues(alpha: 0.5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                    ),
                    child: widget.isProcessing && _lastAction == ApprovalActions.reject
                        ? SizedBox(height: 20.h, width: 20.w, child: CircularProgressIndicator(strokeWidth: 2, color: colors.error))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cancel_outlined, color: colors.error, size: 20),
                              SizedBox(width: 8.w),
                              Text(l10n.reject, style: AppTextStyle.labelLarge.copyWith(color: colors.error)),
                            ],
                          ),
                  ),
                ),
              if (showReject && showApprove) SizedBox(width: 16.w),
              if (showApprove)
                Expanded(
                  child: OutlinedButton(
                    onPressed: isApproveEnabled && !widget.isProcessing ? () {
                      setState(() => _lastAction = ApprovalActions.approve);
                      widget.onAction(ApprovalActions.approve);
                    } : null,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      backgroundColor: isApproveEnabled ? AppColors.approvedBg : Colors.transparent,
                      side: BorderSide(
                        color: isApproveEnabled ? colors.success.withValues(alpha: 0.5) : colors.outlineVariant,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                    ),
                    child: widget.isProcessing && _lastAction == ApprovalActions.approve
                        ? SizedBox(height: 18.h, width: 18.w, child: CircularProgressIndicator(strokeWidth: 2, color: colors.success))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline, color: isApproveEnabled ? colors.success : colors.outlineVariant, size: 20),
                              SizedBox(width: 8.w),
                              Text(l10n.approve, style: AppTextStyle.labelLarge.copyWith(color: isApproveEnabled ? colors.success : colors.outlineVariant)),
                            ],
                          ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  double _getLeftPadding() {
    // If checkbox is visible, we indent the text slightly more to align with the name
    final showCheckbox = widget.data.category == ApprovalCategory.team &&
        widget.data.status.toLowerCase().contains(ApprovalsApiConstants.statusPending);
    return showCheckbox ? 36.0 + 48.0 + 12.0 : 48.0 + 12.0; // Checkbox width + Avatar width + Spacing
  }

  _TitleInfo _getTitleAndSubtitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String title = "";
    String subtitle = "";

    if (widget.data.type == ApprovalType.leave) {
      final leaveType = widget.data.displayDetails.entries.firstWhere(
        (e) => e.key.toLowerCase().contains(RequestDetailKeys.leaveType.toLowerCase()),
        orElse: () => MapEntry('', l10n.leaveRequest),
      ).value;

      final duration = widget.data.displayDetails.entries.firstWhere(
        (e) => e.key.toLowerCase().contains('days') || e.key.toLowerCase().contains('hours'),
        orElse: () => const MapEntry('', ''),
      );

      title = duration.value.isNotEmpty ? "$leaveType · ${duration.value} ${duration.key}" : leaveType;

      if (widget.data.fromDate != null && widget.data.toDate != null) {
        final fDateStr = widget.data.fromDate!.format(DateTimeUtils.patternAbbrMonthDay);
        final tDateStr = widget.data.toDate!.format(DateTimeUtils.patternAbbrMonthDayYear);
        if (widget.data.fromDate!.isAtSameMomentAs(widget.data.toDate!)) {
          subtitle = widget.data.fromDate!.format(DateTimeUtils.patternAbbrMonthDayYear);
        } else {
          subtitle = "$fDateStr - $tDateStr";
        }
      } else {
        final fromDate = widget.data.displayDetails[RequestDetailKeys.fromDate] ?? '';
        final toDate = widget.data.displayDetails[RequestDetailKeys.toDate] ?? '';
        if (fromDate.isNotEmpty && toDate.isNotEmpty) {
          subtitle = fromDate == toDate ? fromDate : "$fromDate \u2013 $toDate";
        } else {
          subtitle = fromDate;
        }
      }
    } else if (widget.data.type == ApprovalType.attendance) {
      final type = widget.data.displayDetails['Reason'] ?? l10n.attendanceRegularization;
      final date = widget.data.displayDetails['Date'] ?? '';
      title = date.isNotEmpty ? "$type · $date" : type;
      subtitle = date;
    } else if (widget.data.type == ApprovalType.timesheet) {
      String weekName = widget.data.displayDetails['Week'] ?? '';
      if (weekName.contains('to')) {
        final parts = weekName.split('to').map((e) => e.trim()).toList();
        if (parts.length == 2) {
          try {
            final fDate = DateTime.parse(parts[0]);
            final tDate = DateTime.parse(parts[1]);
            weekName = "${fDate.format('MMM d, yyyy')} to ${tDate.format('MMM d, yyyy')}";
          } catch (_) {}
        }
      }
      title = weekName.isNotEmpty ? "${l10n.timesheet}- $weekName" : l10n.timesheet;
      subtitle = "";
    } else if (widget.data.type == ApprovalType.compOff) {
      final hoursStr = widget.data.displayDetails['Hours'] ?? '0';
      final hours = double.tryParse(hoursStr) ?? 0;
      final days = hours > 0 ? (hours / 4).round() / 2 : 1.0;
      final daysText = days == days.toInt() ? days.toInt().toString() : days.toStringAsFixed(1);
      final dayStr = daysText == '1' ? '1 day' : '$daysText days';
      title = "${l10n.compOffRequest} \u00b7 $dayStr";
      
      final dateStr = widget.data.displayDetails['Work Date'] ?? widget.data.displayDetails['Worked Date'] ?? widget.data.displayDetails['Comp-off Date'] ?? widget.data.displayDetails['Date'] ?? '';
      subtitle = dateStr;
    }

    return _TitleInfo(title: title, subtitle: subtitle);
  }
}

class _TitleInfo {
  final String title;
  final String subtitle;
  _TitleInfo({required this.title, required this.subtitle});
}
