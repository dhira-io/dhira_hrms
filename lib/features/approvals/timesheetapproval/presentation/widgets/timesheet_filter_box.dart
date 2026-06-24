import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetFilterBox extends StatelessWidget {
  static const String allValue = 'all';
  final String label;
  final String? current;
  final List<String>? options;
  final Map<String, String>? optionsWithLabels;
  final ValueChanged<String?> onSelect;

  const TimesheetFilterBox({
    super.key,
    required this.label,
    required this.current,
    this.options,
    this.optionsWithLabels,
    required this.onSelect,
  }) : assert(options != null || optionsWithLabels != null);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return PopupMenuButton<String?>(
      onSelected: onSelect,
      itemBuilder: (context) {
        if (optionsWithLabels != null) {
          return [
            PopupMenuItem(value: allValue, child: Text(l10n.all)),
            ...optionsWithLabels!.entries.map(
              (e) => PopupMenuItem(value: e.key, child: Text(e.value)),
            ),
          ];
        }
        return [
          PopupMenuItem(value: allValue, child: Text(l10n.all)),
          ...options!.map((o) => PopupMenuItem(value: o, child: Text(o))),
        ];
      },
      child: Container(
        padding:       EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: colors.slate50,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: colors.slate200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _getDisplayText(l10n),
                style: AppTextStyle.bodySmall.copyWith(
                  color: colors.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: colors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayText(AppLocalizations l10n) {
    if (current == null || current == allValue) return label;
    if (optionsWithLabels != null) {
      return optionsWithLabels![current] ?? current!;
    }
    return current!;
  }
}
