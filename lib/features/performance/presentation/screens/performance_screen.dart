import 'package:dhira_hrms/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/bloc/performance_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/goal_setup_page.dart';
import '../widgets/performance_widgets.dart';
import '../widgets/team_evaluation_page.dart';

class PerformanceScreen extends StatefulWidget {
  final int initialIndex;
  const PerformanceScreen({super.key, this.initialIndex = 0});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _tabController.addListener(() {
      setState(() {}); // Rebuild to update AppBar actions
    });

    // Trigger initial data fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PerformanceBloc>().add(const PerformanceStarted());
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(l10n.performance, style: AppTextStyle.h2),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          labelStyle: AppTextStyle.labelLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: AppTextStyle.labelLarge,
          tabs: [
            Tab(text: l10n.goalSetup),
            Tab(text: l10n.selfAssessment),
            Tab(text: l10n.teamEvaluation),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const GoalSetupPage(),
          PerformancePlaceholderContent(title: l10n.selfAssessment),
          const TeamEvaluationPage(),
        ],
      ),
    );
  }
}
