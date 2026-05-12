import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/small_action_btn.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetSectionTitleRow extends StatelessWidget {
  final VoidCallback onExpandAll;
  final VoidCallback onCollapseAll;

  const TimesheetSectionTitleRow({
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
        Text(l10n.dailyTimesheet, style: AppTextStyle.h2Bold.copyWith(color: AppColors.slate800)),
        Row(
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
