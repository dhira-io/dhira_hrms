import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
class PolicyEmptyView extends StatelessWidget {
  const PolicyEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        l10n.noResultsFound,
        style: AppTextStyle.bodyMedium,
      ),
    );
  }
}
