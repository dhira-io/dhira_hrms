import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../domain/entities/attendance_punch_summary_entity.dart';
import '../../../../l10n/app_localizations.dart';

class RegularizationSystemRecord extends StatelessWidget {
  final DateTime? selectedDate;
  final AttendancePunchSummaryEntity? punchSummary;
  final bool isLoading;

  const RegularizationSystemRecord({
    super.key,
    this.selectedDate,
    this.punchSummary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final displayDate = selectedDate != null
        ? DateTimeUtils.formatDate(
            selectedDate!,
            pattern: AppConstants.dateDisplayFormat,
          )
        : l10n.noRecord;
    final hasRecord = punchSummary?.hasRecord == true;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).onSurface.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.systemRecord.toUpperCase(),
                      style: AppTextStyle.labelSmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.of(context).onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      displayDate,
                      style: AppTextStyle.h3.copyWith(
                        color: AppColors.of(context).onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          if (!isLoading && !hasRecord)
            Text(
              l10n.noRecordFound,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            )
          else ...[
            Row(
              children: [
                Expanded(
                  child: _buildTimeBox(
                    context,
                    l10n.punchIn,
                    _formatPunchTime(punchSummary?.firstIn),
                    AppColors.of(context).onSurfaceVariant,
                    isLoading,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildTimeBox(
                    context,
                    l10n.punchOut,
                    _formatPunchTime(punchSummary?.lastOut),
                    AppColors.of(context).onSurfaceVariant,
                    isLoading,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildSummaryMetaRow(context, l10n),
            SizedBox(height: 14.h),
            Text(
              l10n.systemPunchSummaryNote,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryMetaRow(BuildContext context, AppLocalizations l10n) {
    if (isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerLoading(
            height: 18.h,
            width: 116.w,
            borderRadius: AppConstants.r4,
          ),
          ShimmerLoading(
            height: 18.h,
            width: 156.w,
            borderRadius: AppConstants.r4,
          ),
        ],
      );
    }

    final summary = punchSummary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMetaChip(
          context,
          l10n.totalLogsLabel(summary?.totalLogs ?? 0),
          AppColors.of(context).primary,
          AppColors.of(context).primaryFixed,
        ),
        SizedBox(width: 12.w),
        _buildMetaChip(
          context,
          l10n.workingHoursLabel(
            (summary?.workingHours ?? 0).toStringAsFixed(2),
          ),
          AppColors.of(context).successDark,
          AppColors.of(context).successBg,
        ),
      ],
    );
  }

  Widget _buildMetaChip(
    BuildContext context,
    String label,
    Color textColor,
    Color backgroundColor,
  ) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppConstants.r4),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.labelMedium.copyWith(
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeBox(
    BuildContext context,
    String label,
    String value,
    Color valueColor,
    bool isLoading,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.labelSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.of(context).onSurfaceVariant,
              fontSize: AppConstants.fs9.sp,
            ),
          ),
          SizedBox(height: 4.h),
          isLoading
              ? ShimmerLoading(
                  height: 22.h,
                  width: 82.w,
                  borderRadius: AppConstants.r4,
                )
              : Text(
                  value,
                  style: AppTextStyle.h3.copyWith(
                    fontWeight: FontWeight.w900,
                    color: valueColor,
                    fontSize: AppConstants.fs18.sp,
                  ),
                ),
        ],
      ),
    );
  }

  String _formatPunchTime(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.timePlaceholder;
    }

    try {
      return DateFormat('h:mma').format(DateTime.parse(value));
    } catch (_) {
      return AppConstants.timePlaceholder;
    }
  }
}
