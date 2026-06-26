import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';

class CalendarSummaryWidget extends StatelessWidget {
  final CalendarSummaryEntity summary;

  const CalendarSummaryWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);
    final totalHours = summary.totalWorkingHours ?? (summary.presentDays * AppConstants.standardWorkingHours);
    final totalHoursStr = totalHours % 1 == 0
        ? '${totalHours.toInt()}h'
        : '${totalHours.toStringAsFixed(1)}h';

    final ValueNotifier<bool> isExpandedNotifier = ValueNotifier<bool>(true);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: themeColors.tableBorder),
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: isExpandedNotifier,
        builder: (context, isExpanded, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  isExpandedNotifier.value = !isExpandedNotifier.value;
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.p16,
                    vertical: AppConstants.p12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.monthlySummary,
                        style: AppTextStyle.labelLarge.copyWith(
                          color: themeColors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: AppConstants.iconMedium,
                        color: themeColors.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded) ...[
                Container(
                  height: AppConstants.dividerHeight,
                  color: themeColors.outlineVariant,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 13.h,
                    horizontal: 16.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SummaryColumn(
                        label: l10n.workingDays,
                        value: summary.totalWorkingDays.toString(),
                        valueColor: themeColors.onSurface,
                      ),
                      _SummaryColumn(
                        label: l10n.presentDays,
                        value: summary.presentDays % 1 == 0
                            ? summary.presentDays.toInt().toString()
                            : summary.presentDays.toString(),
                        valueColor: themeColors.success,
                      ),
                      _SummaryColumn(
                        label: l10n.totalHoursLabel,
                        value: totalHoursStr,
                        valueColor: themeColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SummaryColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _SummaryColumn({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyle.labelMedium.copyWith(
              color: themeColors.onSurfaceVariant,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: AppTextStyle.titleMedium.copyWith(
              color: valueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
