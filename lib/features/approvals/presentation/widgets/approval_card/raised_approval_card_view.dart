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
    final colors = AppColors.of(context);
    
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
            RaisedApprovalIcon(type: data.type),
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
                          style: AppTextStyle.titleSmall.copyWith(
                            color: colors.slate950,
                          ),
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
                      style: AppTextStyle.labelLarge.copyWith(
                        color: colors.gray400,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  if (titleInfo.appliedOn.isNotEmpty) ...[
                    const SizedBox(height: AppConstants.p4),
                    Text(
                      titleInfo.appliedOn,
                      style: AppTextStyle.labelMedium.copyWith(
                        color: colors.gray400,
                      ),
                    ),
                  ],
                  if (titleInfo.duration.isNotEmpty) ...[
                    const SizedBox(height: AppConstants.p4),
                    Text(
                      titleInfo.duration,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: colors.slate500Confirmation,
                      ),
                    ),
                  ],
                  if (titleInfo.rejectionReason.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: const EdgeInsets.all(AppConstants.p8),
                      decoration: BoxDecoration(
                        color: colors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppConstants.p8),
                      ),
                      child: Text(
                        '${l10n.rejected}: ${titleInfo.rejectionReason}',
                        style: AppTextStyle.bodySmall.copyWith(color: colors.error),
                      ),
                    ),
                  ],
                  if (data.fileUrl != null && data.fileUrl!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.attach_file, size: 16, color: colors.onSurfaceVariant),
                        SizedBox(width: 4.w),
                        Text(l10n.attachment, style: AppTextStyle.bodySmall.copyWith(color: colors.onSurfaceVariant)),
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
                    child: Icon(Icons.edit, size: 20, color: colors.primary),
                  ),
                  const SizedBox(width: AppConstants.p16),
                  InkWell(
                    onTap: onDelete,
                    child: Icon(Icons.delete_outline, size: 20, color: colors.error),
                  ),
                ]
              ],
            ),
          ),
      ],
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
      rejectionReason = data.displayDetails[RequestDetailKeys.reasonCapitalized] ?? data.displayDetails[RequestDetailKeys.commentsCapitalized] ?? '';
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
      title = data.displayDetails[RequestDetailKeys.reasonCapitalized] ?? l10n.attendanceRegularization;
      dates = data.displayDetails[RequestDetailKeys.date] ?? '';
    } else if (data.type == ApprovalType.timesheet) {
      title = l10n.timesheet;
      dates = data.displayDetails[RequestDetailKeys.week] ?? data.displayDetails[RequestDetailKeys.date] ?? '';
    } else if (data.type == ApprovalType.compOff) {
      title = l10n.comOff;
      dates = data.displayDetails[RequestDetailKeys.workDate] ?? data.displayDetails[RequestDetailKeys.compOffDate] ?? data.displayDetails[RequestDetailKeys.date] ?? '';
    }

    // Try to extract submitted date (Applied on)
    final submitted = data.displayDetails[RequestDetailKeys.submittedDate];
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

class RaisedApprovalIcon extends StatelessWidget {
  final ApprovalType type;

  const RaisedApprovalIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    IconData iconData;
    Color color;

    if (type == ApprovalType.leave) {
      iconData = Icons.description_outlined;
      color = colors.success;
    } else if (type == ApprovalType.attendance) {
      iconData = Icons.access_time;
      color = colors.attendanceicon;
    } else if (type == ApprovalType.timesheet) {
      iconData = Icons.calendar_today_outlined;
      color = colors.primaryContainer;
    } else if (type == ApprovalType.compOff) {
      iconData = Icons.local_cafe_outlined;
      color = colors.compofficon;
    } else {
      iconData = Icons.event_available;
      color = colors.warning;
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
}
