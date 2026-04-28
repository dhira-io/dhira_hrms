import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import '../bloc/approvals_state.dart';
import '../widgets/approvals_list_view.dart';

class ApprovalsScreen extends StatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider<ApprovalsBloc>(
      create: (context) => Get.find<ApprovalsBloc>()..add(const ApprovalsEvent.started()),
      child: BlocBuilder<ApprovalsBloc, ApprovalsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
            loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
            failure: (message) => Scaffold(body: Center(child: Text(message))),
            // Updated success state to receive requests and list loading status
            success: (access, summary, requests, isListLoading) {
              final showTeamApprovals = access.canAccess;
              final tabCount = showTeamApprovals ? 2 : 1;

              return DefaultTabController(
                length: tabCount,
                child: Scaffold(
                  backgroundColor: AppColors.background,
                  appBar: AppBar(
                    // ... AppBar implementation
                  ),
                  body: Column(
                    children: [
                      if (showTeamApprovals) _buildTopTabBar(l10n),
                      if (showTeamApprovals) const SizedBox(height: AppConstants.p16),
                      Expanded(
                        child: TabBarView(
                          physics: showTeamApprovals
                              ? const AlwaysScrollableScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          children: [
                            if (showTeamApprovals)
                              ApprovalsListView(
                                summary: summary,
                                requests: requests, // Passing actual data
                                isLoading: isListLoading, // Passing loading status for Shimmer
                              ),
                            ApprovalsListView(
                              summary: summary,
                              requests: requests,
                              isLoading: isListLoading,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Extracted for readability and consistency with project UI principles
  Widget _buildTopTabBar(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
        child: TabBar(
          // ... TabBar styling from previous snippet
          tabs: [
            Tab(text: l10n.teamApprovals),
            Tab(text: l10n.raisedRequests),
          ],
        ),
      ),
    );
  }
}