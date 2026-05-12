import 'package:dhira_hrms/features/approvals/domain/entities/approvals_summary_entity.dart';
import 'package:dhira_hrms/features/approvals/presentation/dialogs/widgets/approvals_list_content.dart';
import 'package:dhira_hrms/features/approvals/presentation/dialogs/widgets/approval_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import '../bloc/approvals_state.dart';
import '../widgets/approvals_shimmer.dart';
import '../dialogs/widgets/approvals_primary_tab_bar.dart';
import 'package:dhira_hrms/core/widgets/app_header.dart';
import 'package:dhira_hrms/core/widgets/no_internet_widget.dart';
import '../../domain/entities/approval_type.dart';
import '../../domain/entities/approval_request_entity.dart';

class ApprovalsScreen extends StatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  TabController? _subTabController;
  int _tabCount = 0;

  @override
  void initState() {
    super.initState();
    _subTabController = TabController(length: 4, vsync: this);
    _subTabController!.addListener(_handleSubTabChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ApprovalsBloc>().add(
          const ApprovalsEvent.started(),
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    _subTabController?.removeListener(_handleSubTabChange);
    _subTabController?.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      final isRaisedRequest =
          (_tabCount == 2 && _tabController!.index == 1) ||
              (_tabCount == 1);

      final newCategory = isRaisedRequest
          ? ApprovalCategory.raised
          : ApprovalCategory.team;

      final currentState = context.read<ApprovalsBloc>().state;

      currentState.maybeMap(
        success: (s) {
          if (s.data.category != newCategory) {
            // Reset to first sub-tab (Leave) when switching primary category
            context.read<ApprovalsBloc>().add(
              ApprovalsEvent.categoryChanged(
                ApprovalType.leave,
                newCategory,
              ),
            );
          }
        },
        orElse: () {},
      );
    }
  }

  void _handleSubTabChange() {
    if (_subTabController != null && !_subTabController!.indexIsChanging) {
      final currentState = context.read<ApprovalsBloc>().state;
      currentState.maybeMap(
        success: (s) {
          final newType = _getTypeFromIndex(_subTabController!.index);
          if (s.data.type != newType) {
            context.read<ApprovalsBloc>().add(
              ApprovalsEvent.categoryChanged(
                newType,
                s.data.category,
              ),
            );
          }
        },
        orElse: () {},
      );
    }
  }

  ApprovalType _getTypeFromIndex(int index) {
    switch (index) {
      case 0: return ApprovalType.leave;
      case 1: return ApprovalType.attendance;
      case 2: return ApprovalType.timesheet;
      case 3: return ApprovalType.compOff;
      default: return ApprovalType.leave;
    }
  }

  int _getIndexFromType(ApprovalType type) {
    switch (type) {
      case ApprovalType.leave: return 0;
      case ApprovalType.attendance: return 1;
      case ApprovalType.timesheet: return 2;
      case ApprovalType.compOff: return 3;
    }
  }

  void _syncTabControllers(dynamic data) {
    // Sync Primary Tab
    final bool showTeamApprovals = data.access.canAccess;
    final int tabCount = showTeamApprovals ? 2 : 1;

    if (_tabController == null || _tabCount != tabCount) {
      _tabController?.removeListener(_handleTabChange);
      _tabController?.dispose();

      final int initialIndex = (showTeamApprovals && data.targetCategory == ApprovalCategory.raised) ? 1 : 0;

      _tabController = TabController(
        length: tabCount,
        vsync: this,
        initialIndex: initialIndex,
      );
      _tabController!.addListener(_handleTabChange);
      _tabCount = tabCount;
      setState(() {});
    } else {
      final int targetIndex = (showTeamApprovals && data.targetCategory == ApprovalCategory.raised) ? 1 : 0;
      if (_tabController!.index != targetIndex && !_tabController!.indexIsChanging) {
        _tabController!.animateTo(targetIndex);
      }
    }

    // Sync Sub Tab
    final targetSubIdx = _getIndexFromType(data.targetType);
    if (_subTabController!.index != targetSubIdx && !_subTabController!.indexIsChanging) {
      _subTabController!.animateTo(targetSubIdx);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApprovalsBloc, ApprovalsState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) {
            _syncTabControllers(data);
            if (data.successMessage != null && data.successMessage!.isNotEmpty) {
              ToastUtils.showSuccess(data.successMessage!);
            }
            if (data.errorMessage != null && data.errorMessage!.isNotEmpty) {
              ToastUtils.showError(data.errorMessage!);
            }
          },
          failure: (message) {
            ToastUtils.showError(message);
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            const AppHeader(),
            const SizedBox(height: AppConstants.p8),
            
            // 1. Primary Tab Bar (Team/Raised) - Rebuilds only on access change
            BlocSelector<ApprovalsBloc, ApprovalsState, bool>(
              selector: (state) => state.maybeMap(
                success: (s) => s.data.access.canAccess,
                orElse: () => false,
              ),
              builder: (context, canAccess) {
                if (!canAccess || _tabController == null) return const SizedBox.shrink();
                return ApprovalsPrimaryTabBar(controller: _tabController);
              },
            ),

            const SizedBox(height: AppConstants.p16),

            // 2. Sub Tab Bar (Leave/Attendance/...) - Rebuilds only on summary or category/type change
            BlocSelector<ApprovalsBloc, ApprovalsState, _SubTabState>(
              selector: (state) => state.maybeMap(
                success: (s) => _SubTabState(
                  summary: s.data.summary,
                  isRaised: s.data.category == ApprovalCategory.raised,
                  type: s.data.type,
                ),
                orElse: () => const _SubTabState(summary: null, isRaised: false, type: ApprovalType.leave),
              ),
              builder: (context, subTabState) {
                if (subTabState.summary == null) return const SizedBox.shrink();
                final l10n = AppLocalizations.of(context)!;
                
                return TabBar(
                  controller: _subTabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  labelPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p8),
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  tabs: List.generate(4, (index) => ApprovalTab(
                    label: _getSubTabLabel(l10n, index, subTabState.summary!, subTabState.isRaised),
                    isSelected: _getIndexFromType(subTabState.type) == index,
                  )),
                );
              },
            ),

            const SizedBox(height: AppConstants.p16),

            // 3. Data Section - Rebuilds only on list changes
            Expanded(
              child: BlocBuilder<ApprovalsBloc, ApprovalsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
                      child: ApprovalsShimmer(),
                    ),
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
                      child: ApprovalsShimmer(),
                    ),
                    failure: (message) => NoInternetWidget(
                      onReload: () => context.read<ApprovalsBloc>().add(const ApprovalsEvent.started()),
                      message: message,
                    ),
                    success: (data) {
                      return ApprovalsListContent(
                        requests: data.requests,
                        isLoading: data.isListLoading,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSubTabLabel(AppLocalizations l10n, int index, ApprovalsSummaryEntity summary, bool isRaised) {
    if (isRaised) {
      switch (index) {
        case 0: return l10n.leave;
        case 1: return l10n.attendance;
        case 2: return l10n.timesheet;
        case 3: return l10n.comOff;
        default: return "";
      }
    } else {
      switch (index) {
        case 0: return l10n.leaveRequestsCount(summary.leaveApprovalsPending);
        case 1: return l10n.attendanceRequestsCount(summary.attendanceRegularizationPending);
        case 2: return l10n.timesheetRequestsCount(summary.timesheetApprovalsPending);
        case 3: return l10n.compOffRequestsCount(summary.compensatoryLeavePending);
        default: return "";
      }
    }
  }
}

class _SubTabState {
  final ApprovalsSummaryEntity? summary;
  final bool isRaised;
  final ApprovalType type;
  const _SubTabState({required this.summary, required this.isRaised, required this.type});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _SubTabState &&
          runtimeType == other.runtimeType &&
          summary == other.summary &&
          isRaised == other.isRaised &&
          type == other.type;

  @override
  int get hashCode => summary.hashCode ^ isRaised.hashCode ^ type.hashCode;
}