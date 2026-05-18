import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_app_bar.dart';

class SelfAssessmentScreen extends StatelessWidget {
  const SelfAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: CommonAppBar(
        title: l10n.selfAssessment,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rate_review_outlined,
              size: 64,
              color: AppColors.of(context).onSurfaceVariant.withValues(alpha: 0.3),
            ),
            SizedBox(height: 16),
            Text(
              l10n.selfAssessment,
              style: AppTextStyle.h3.copyWith(
                color: AppColors.of(context).onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: 8),
            Text(
              l10n.comingSoon,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).onSurfaceVariant.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
