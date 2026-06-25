import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';

class CalendarSummaryWidget extends StatefulWidget {
  final CalendarSummaryEntity summary;

  const CalendarSummaryWidget({
    super.key,
    required this.summary,
  });

  @override
  State<CalendarSummaryWidget> createState() => _CalendarSummaryWidgetState();
}

class _CalendarSummaryWidgetState extends State<CalendarSummaryWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    final totalHours = widget.summary.totalWorkingHours ?? (widget.summary.presentDays * 9.5);
    final totalHoursStr = totalHours % 1 == 0 
        ? '${totalHours.toInt()}h' 
        : '${totalHours.toStringAsFixed(1)}h';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(
          color: AppColors.of(context).outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
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
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: AppColors.of(context).onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: AppConstants.iconMedium,
                    color: AppColors.of(context).onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          
          if (_isExpanded) ...[
            Container(
              height: AppConstants.dividerHeight,
              color: AppColors.of(context).outlineVariant,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SummaryColumn(
                    label: l10n.workingDays,
                    value: widget.summary.totalWorkingDays.toString(),
                    valueColor: AppColors.of(context).onSurface,
                  ),
                  _SummaryColumn(
                    label: l10n.presentDays,
                    value: widget.summary.presentDays % 1 == 0
                        ? widget.summary.presentDays.toInt().toString()
                        : widget.summary.presentDays.toString(),
                    valueColor: const Color(0xFF00C951),
                  ),
                  _SummaryColumn(
                    label: l10n.totalHoursLabel,
                    value: totalHoursStr,
                    valueColor: const Color(0xFF155DFC),
                  ),
                ],
              ),
            ),
          ],
        ],
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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyle.labelSmall.copyWith(
              color: AppColors.of(context).onSurfaceVariant,
              fontWeight: FontWeight.w500,
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
