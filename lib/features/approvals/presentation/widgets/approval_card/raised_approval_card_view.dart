import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/widgets/approval_card/mini_status_badge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RaisedApprovalCardView extends StatelessWidget {
  final ApprovalRequestEntity data;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isProcessing;

  const RaisedApprovalCardView({
    super.key,
    required this.data,
    required this.onEdit,
    required this.onDelete,
    this.isProcessing = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final titleInfo = _getTitleInfo(context);
    
    final String normStatus = data.status.toLowerCase();
    final bool isProcessed = [
      ApprovalStatus.approved.toLowerCase(),
      ApprovalStatus.rejected.toLowerCase(),
      ApprovalStatus.cancelled.toLowerCase(),
    ].contains(normStatus);

    bool showEditDelete = false;
    
    if (data.type == ApprovalType.leave) {
      bool isFuture = true;
      if (data.fromDate != null) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final leaveDate = DateTime(data.fromDate!.year, data.fromDate!.month, data.fromDate!.day);
        isFuture = !leaveDate.isBefore(today);
      }
      showEditDelete = !isProcessed && isFuture;
    } else if (data.type == ApprovalType.timesheet) {
      showEditDelete = !isProcessed;
    }

    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIcon(context),
            const SizedBox(width: AppConstants.p16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          titleInfo.title,
                          style: AppTextStyle.labelSmall.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppConstants.p8),
                      MiniStatusBadge(status: data.status),
                    ],
                  ),
                  const SizedBox(height: AppConstants.p4),
                  if (titleInfo.dates.isNotEmpty)
                    Text(
                      titleInfo.dates,
                      style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).onSurfaceVariant),
                    ),
                  if (titleInfo.appliedOn.isNotEmpty) ...[
                    const SizedBox(height: AppConstants.p4),
                    Text(
                      titleInfo.appliedOn,
                      style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).onSurfaceVariant),
                    ),
                  ],
                  if (titleInfo.duration.isNotEmpty) ...[
                    const SizedBox(height: AppConstants.p4),
                    Text(
                      titleInfo.duration,
                      style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).primary), // Blue color
                    ),
                  ],
                  if (titleInfo.rejectionReason.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: const EdgeInsets.all(AppConstants.p8),
                      decoration: BoxDecoration(
                        color: AppColors.of(context).error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppConstants.p8),
                      ),
                      child: Text(
                        '${l10n.rejected}: ${titleInfo.rejectionReason}',
                        style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).error),
                      ),
                    ),
                  ],
                  if (data.fileUrl != null && data.fileUrl!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.attach_file, size: 16, color: AppColors.of(context).onSurfaceVariant),
                        SizedBox(width: 4.w),
                        Text(l10n.attachment, style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).onSurfaceVariant)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),

        if (showEditDelete)
          Positioned(
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                if (isProcessing)
                  SizedBox(height: 16.h, width: 16.w, child: CircularProgressIndicator(strokeWidth: 2))
                else ...[
                  InkWell(
                    onTap: onEdit,
                    child: Icon(Icons.edit, size: 20, color: AppColors.of(context).primary),
                  ),
                  const SizedBox(width: AppConstants.p16),
                  InkWell(
                    onTap: onDelete,
                    child: Icon(Icons.delete_outline, size: 20, color: AppColors.of(context).error),
                  ),
                ]
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    IconData iconData;
    Color color;

    if (data.type == ApprovalType.leave) {
      iconData = Icons.description_outlined;
      color = AppColors.of(context).success;
    } else if (data.type == ApprovalType.attendance) {
      iconData = Icons.access_time;
      color = AppColors.of(context).attendanceicon;
    } else if (data.type == ApprovalType.timesheet) {
      iconData = Icons.calendar_today; // Matches image better than calendar_month
      color = AppColors.of(context).timesheeticon;
    } else if (data.type == ApprovalType.compOff) {
      iconData = Icons.local_cafe_outlined;
      color = AppColors.of(context).compofficon;
    } else {
      iconData = Icons.event_available;
      color = AppColors.of(context).warning;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(iconData, color: color, size: 24),
    );
  }

  _TitleInfo _getTitleInfo(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String title = "";
    String dates = "";
    String appliedOn = "";
    String duration = "";
    String rejectionReason = "";

    if (data.status.toLowerCase() == ApprovalStatus.rejected.toLowerCase()) {
      rejectionReason = data.displayDetails['Reason'] ?? data.displayDetails['Comments'] ?? '';
    }

    if (data.type == ApprovalType.leave) {
      title = data.displayDetails.entries.firstWhere(
        (e) => e.key.toLowerCase().contains(RequestDetailKeys.leaveType.toLowerCase()),
        orElse: () => MapEntry('', l10n.leaveRequest),
      ).value;

      if (data.fromDate != null && data.toDate != null) {
        final fDateStr = data.fromDate!.format(DateTimeUtils.patternAbbrMonthDay);
        final tDateStr = data.toDate!.format(DateTimeUtils.patternAbbrMonthDayYear);
        if (data.fromDate!.isAtSameMomentAs(data.toDate!)) {
          dates = data.fromDate!.format(DateTimeUtils.patternAbbrMonthDayYear);
        } else {
          dates = "$fDateStr - $tDateStr";
        }
      } else {
        final fromDate = data.displayDetails[RequestDetailKeys.fromDate] ?? '';
        final toDate = data.displayDetails[RequestDetailKeys.toDate] ?? '';
        if (fromDate.isNotEmpty && toDate.isNotEmpty) {
          dates = fromDate == toDate ? fromDate : "$fromDate \u2013 $toDate";
        } else {
          dates = fromDate;
        }
      }

      final dVal = data.displayDetails.entries.firstWhere(
        (e) => e.key.toLowerCase().contains('days') || e.key.toLowerCase().contains('hours'),
        orElse: () => const MapEntry('', ''),
      );
      if (dVal.value.isNotEmpty) {
        duration = "${l10n.duration}: ${dVal.value} ${dVal.key}";
      }
    } else if (data.type == ApprovalType.attendance) {
      title = data.displayDetails['Reason'] ?? l10n.attendanceRegularization;
      dates = data.displayDetails['Date'] ?? '';
    } else if (data.type == ApprovalType.timesheet) {
      title = l10n.timesheet;
      dates = data.displayDetails['Week'] ?? data.displayDetails['Date'] ?? '';
    } else if (data.type == ApprovalType.compOff) {
      title = l10n.comOff;
      dates = data.displayDetails['Work Date'] ?? data.displayDetails['Comp-off Date'] ?? data.displayDetails['Date'] ?? '';
    }

    // Try to extract submitted date (Applied on)
    final submitted = data.displayDetails['Submitted Date'];
    if (submitted != null && submitted.isNotEmpty) {
      appliedOn = "${l10n.applied} on - $submitted";
    }

    return _TitleInfo(title: title, dates: dates, appliedOn: appliedOn, duration: duration, rejectionReason: rejectionReason);
  }
}

class _TitleInfo {
  final String title;
  final String dates;
  final String appliedOn;
  final String duration;
  final String rejectionReason;
  _TitleInfo({required this.title, required this.dates, required this.appliedOn, required this.duration, required this.rejectionReason});
}
