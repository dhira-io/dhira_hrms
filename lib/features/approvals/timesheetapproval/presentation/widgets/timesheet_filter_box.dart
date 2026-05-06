import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetFilterBox extends StatelessWidget {
  final String label;
  final String? current;
  final List<String> options;
  final ValueChanged<String?> onSelect;

  const TimesheetFilterBox({
    super.key,
    required this.label,
    required this.current,
    required this.options,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return PopupMenuButton<String?>(
      onSelected: onSelect,
      itemBuilder: (context) => [
        PopupMenuItem(value: null, child: Text(l10n.all)),
        ...options.map((o) => PopupMenuItem(value: o, child: Text(o))),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.slate50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.slate200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                current ?? label,
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.slate800),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.slate500),
          ],
        ),
      ),
    );
  }
}
