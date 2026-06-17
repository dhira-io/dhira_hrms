import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../dashboard/presentation/widgets/performance_section.dart';
import '../../../../core/widgets/common_app_bar.dart';

class PerformanceDashboardScreen extends StatelessWidget {
  const PerformanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: CommonAppBar(title: l10n.performance),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: const PerformanceSection(),
      ),
    );
  }
}
