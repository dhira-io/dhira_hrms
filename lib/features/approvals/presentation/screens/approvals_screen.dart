import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import '../bloc/approvals_state.dart';
import '../widgets/approvals_list_view.dart';
import '../widgets/approvals_shimmer.dart';

class ApprovalsScreen extends StatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  int _tabCount = 0;

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      final isRaisedRequest = (_tabCount == 2 && _tabController!.index == 1) || (_tabCount == 1);
      
      Get.find<ApprovalsBloc>().add(
        ApprovalsEvent.categoryChanged(
          ApprovalType.leave,
          isRaisedRequest ? ApprovalCategory.raised : ApprovalCategory.team,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider<ApprovalsBloc>(
      // Initializing the Bloc and triggering the first API calls (Permissions + Summary + Leaves)
      create: (context) => Get.find<ApprovalsBloc>()..add(const ApprovalsEvent.started()),
      child: BlocBuilder<ApprovalsBloc, ApprovalsState>(
        builder: (context, state) {
          return state.when(
            initial: () => Scaffold(
              appBar: AppBar(title: Text(l10n.approvals)),
              body: const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
                child: ApprovalsShimmer(),
              ),
            ),
            loading: () => Scaffold(
              appBar: AppBar(title: Text(l10n.approvals)),
              body: const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
                child: ApprovalsShimmer(),
              ),
            ),
            failure: (message) {
              String localizedMessage = message;
              if (message.contains("Failed to fetch approvals access data.")) {
                localizedMessage = l10n.errorFetchApprovalsAccess;
              } else if (message.contains("Failed to fetch approvals summary statistics.")) {
                localizedMessage = l10n.errorFetchApprovalsSummary;
              } else if (message.contains("Failed to submit workflow action")) {
                localizedMessage = l10n.errorSubmitWorkflowAction;
              } else if (message.contains("Failed to submit attendance workflow action")) {
                localizedMessage = l10n.errorSubmitAttendanceWorkflowAction;
              } else if (message.contains("Reject action is not implemented for Timesheets")) {
                localizedMessage = l10n.errorRejectNotImplementedTimesheet;
              } else if (message.contains("Failed to submit timesheet workflow action")) {
                localizedMessage = l10n.errorSubmitTimesheetWorkflowAction;
              } else if (message.contains("Failed to submit comp-off workflow action")) {
                localizedMessage = l10n.errorSubmitCompOffWorkflowAction;
              }
              
              return Scaffold(
                appBar: AppBar(title: Text(l10n.approvals)),
                body: Center(child: Text(localizedMessage)),
              );
            },
            success: (access, summary, requests, isListLoading, comments, isCommentsLoading, editingTimesheet, isTimesheetLoading, projects, employees, successMessage, errorMessage) {
              final bool showTeamApprovals = access.canAccess;
              final int tabCount = showTeamApprovals ? 2 : 1;

              if (_tabController == null || _tabCount != tabCount) {
                _tabController?.removeListener(_handleTabChange);
                _tabController?.dispose();
                _tabController = TabController(length: tabCount, vsync: this);
                _tabController!.addListener(_handleTabChange);
                _tabCount = tabCount;
              }

              return BlocListener<ApprovalsBloc, ApprovalsState>(
                listener: (context, state) {
                  state.maybeMap(
                    success: (s) {
                      if (s.successMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.successMessage!), backgroundColor: AppColors.success));
                      }
                      if (s.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.errorMessage!), backgroundColor: AppColors.error));
                      }
                    },
                    failure: (f) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(f.message), backgroundColor: AppColors.error));
                    },
                    orElse: () {},
                  );
                },
                child: Scaffold(
                  backgroundColor: AppColors.background,
                  appBar: AppBar(
                    backgroundColor: AppColors.white,
                    elevation: 0,
                  centerTitle: false,
                  title: Text(
                    l10n.approvals,
                    style: AppTextStyle.headlineSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                  body: Column(
                    children: [
                      const SizedBox(height: AppConstants.p8),

                      // PRIMARY TOP BAR: Team Approvals vs Raised Requests
                      if (showTeamApprovals)
                        _buildPrimaryTabBar(l10n)
                      else
                        const SizedBox.shrink(),

                      const SizedBox(height: AppConstants.p16),

                    // CONTENT AREA: The 2nd Topbar and List are inside ApprovalsListView
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        // Disable swiping if only "Raised Requests" is available
                        physics: showTeamApprovals
                            ? const AlwaysScrollableScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        children: [
                          // TAB 1: Team Approvals (Only shown if access.canAccess is true)
                          if (showTeamApprovals)
                            ApprovalsListView(
                              summary: summary,
                              requests: requests,
                              isLoading: isListLoading,
                              isRaisedRequest: false, // This enables (04) counts
                            ),

                          // TAB 2: Raised Requests (Always shown)
                          ApprovalsListView(
                            summary: summary,
                            requests: requests,
                            isLoading: isListLoading,
                            isRaisedRequest: true, // This hides counts
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

  /// Builds the "Team Approvals | Raised Requests" selector
  Widget _buildPrimaryTabBar(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.r10),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          labelStyle: AppTextStyle.labelLarge.copyWith(fontWeight: FontWeight.bold),
          unselectedLabelStyle: AppTextStyle.labelLarge,
          tabs: [
            Tab(text: l10n.teamApprovals),
            Tab(text: l10n.raisedRequests),
          ],
        ),
      ),
    );
  }
}