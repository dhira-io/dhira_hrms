import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/widgets/collapsible_section.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_state.dart';
import '../../domain/entities/attendance_entities.dart';
import '../bottom_sheets/holiday_list_bottom_sheet.dart';

class AttendanceLogList extends StatelessWidget {
  const AttendanceLogList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MonthSummary(summary: state.monthSummary),
            const SizedBox(height: AppConstants.p24),
          ],
        );
      },
    );
  }
}

class _MonthSummary extends StatelessWidget {
  final AttendanceMonthSummaryEntity? summary;

  const _MonthSummary({this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    String formatValue(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    return CollapsibleSection(
      initiallyExpanded: false,
      title: Row(
        children: [
          Text(
            l10n.monthSummary,
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              fontSize: AppConstants.fs15.sp,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.p20,
          0,
          AppConstants.p20,
          AppConstants.p8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: _SummaryItem(
                    title: l10n.presentDays,
                    value: summary != null
                        ? formatValue(summary!.presentDays)
                        : "0",
                    color: AppColors.of(context).monthSummaryPresentBg,
                    textColor: AppColors.of(context).monthSummaryPresentText,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _SummaryItem(
                    title: l10n.absentDays,
                    value: summary != null
                        ? formatValue(summary!.absentDays)
                        : "0",
                    color: AppColors.of(context).monthSummaryAbsentBg,
                    textColor: AppColors.of(context).monthSummaryAbsentText,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _SummaryItem(
                    title: l10n.onLeave,
                    value: summary != null
                        ? formatValue(summary!.onLeaveDays)
                        : "0",
                    color: AppColors.of(context).monthSummaryLeaveBg,
                    textColor: AppColors.of(context).monthSummaryLeaveText,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _HolidaySummaryItem(
                    title: l10n.holidays,
                    value: summary?.holidays.toString() ?? "0",
                    color: AppColors.of(context).monthSummaryHolidayBg,
                    textColor: AppColors.of(context).monthSummaryHolidayText,
                    holidays: summary?.holidayDetails ?? [],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Color textColor;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyle.h2.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _HolidaySummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Color textColor;
  final List<HolidayDetailEntity> holidays;

  const _HolidaySummaryItem({
    required this.title,
    required this.value,
    required this.color,
    required this.textColor,
    required this.holidays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.of(context).black,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (holidays.length > 1)
                GestureDetector(
                  onTap: () =>
                      HolidayListBottomSheet.showMonthly(context, holidays),
                  child: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.of(context).accent,
                    size: AppConstants.iconXSmall,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTextStyle.h1.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (holidays.length == 1) ...[
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "(${holidays.first.name} - ${DateTimeUtils.formatHolidayDate(holidays.first.date)})",
                    style: AppTextStyle.bodySmall.copyWith(
                      color: textColor.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
