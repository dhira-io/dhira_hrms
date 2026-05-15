import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/small_action_btn.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EditTimesheetBreakdownHeader extends StatelessWidget {
  final VoidCallback onExpandAll;
  final VoidCallback onCollapseAll;

  const EditTimesheetBreakdownHeader({
    super.key,
    required this.onExpandAll,
    required this.onCollapseAll,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            l10n.dailyTimesheetBreakdown,
            style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            softWrap: true,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmallActionBtn(
              icon: Icons.unfold_more,
              label: l10n.expandAll,
              onTap: onExpandAll,
            ),
            const SizedBox(width: 8),
            SmallActionBtn(
              icon: Icons.unfold_less,
              label: l10n.collapseAll,
              onTap: onCollapseAll,
            ),
          ],
        ),
      ],
    );
  }
}
