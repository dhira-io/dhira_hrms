import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/entities/approval_type.dart';
import '../../domain/entities/approvals_summary_entity.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import 'approval_card.dart';
import 'approvals_shimmer.dart';
import '../dialogs/widgets/approval_tab.dart';
import '../dialogs/widgets/approvals_list_content.dart';

class ApprovalsListView extends StatefulWidget {
  final bool isRaisedRequest;

  const ApprovalsListView({
    super.key,
    this.isRaisedRequest = false,
  });

  @override
  State<ApprovalsListView> createState() => _ApprovalsListViewState();
}

class _ApprovalsListViewState extends State<ApprovalsListView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _subTabController;

  @override
  void initState() {
    super.initState();
    _subTabController = TabController(length: 4, vsync: this);
    _subTabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_subTabController.indexIsChanging) {
      final newType = _getTypeFromIndex(_subTabController.index);
      final newCategory = widget.isRaisedRequest ? ApprovalCategory.raised : ApprovalCategory.team;

      final currentState = context.read<ApprovalsBloc>().state;
      currentState.maybeMap(
        success: (s) {
          // Only fire event if:
          // 1. This list's category matches the current active category in Bloc
          // 2. AND the type or category has actually changed
          final isCurrentlyActiveCategory = s.data.category == newCategory;

          if (isCurrentlyActiveCategory &&
              (s.data.type != newType || s.data.category != newCategory)) {
            context.read<ApprovalsBloc>().add(
              ApprovalsEvent.categoryChanged(newType, newCategory),
            );
          }
        },
        orElse: () {
          context.read<ApprovalsBloc>().add(
            ApprovalsEvent.categoryChanged(newType, newCategory),
          );
        },
      );
      setState(() {}); // Rebuild to update local tab styling (isSelected)
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

  @override
  void dispose() {
    _subTabController.removeListener(_handleTabChange);
    _subTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by AutomaticKeepAliveClientMixin
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ApprovalsBloc, ApprovalsState>(
      listenWhen: (previous, current) => current.maybeMap(
        success: (s) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.maybeMap(
          success: (s) {
            final targetIdx = _getIndexFromType(s.data.targetType);
            if (_subTabController.index != targetIdx &&
                !_subTabController.indexIsChanging) {
              _subTabController.animateTo(targetIdx);
            }
          },
          orElse: () {},
        );
      },
      child: Column(
        children: [
          // Optimized: Only rebuild TabBar when summary changes
          BlocSelector<ApprovalsBloc, ApprovalsState, ApprovalsSummaryEntity?>(
            selector: (state) => state.maybeMap(
              success: (s) => s.data.summary,
              orElse: () => null,
            ),
            builder: (context, summary) {
              if (summary == null) return const SizedBox.shrink();
              return TabBar(
                controller: _subTabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                labelPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p8),
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                tabs: [
                  ApprovalTab(
                    label: _getLabel(l10n, 0, summary),
                    isSelected: _subTabController.index == 0,
                  ),
                  ApprovalTab(
                    label: _getLabel(l10n, 1, summary),
                    isSelected: _subTabController.index == 1,
                  ),
                  ApprovalTab(
                    label: _getLabel(l10n, 2, summary),
                    isSelected: _subTabController.index == 2,
                  ),
                  ApprovalTab(
                    label: _getLabel(l10n, 3, summary),
                    isSelected: _subTabController.index == 3,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppConstants.p16),
          // Optimized: Only rebuild list when requests or list loading state changes
          Expanded(
            child: BlocSelector<ApprovalsBloc, ApprovalsState, _ApprovalsListState>(
              selector: (state) => state.maybeMap(
                success: (s) => _ApprovalsListState(
                  requests: s.data.requests,
                  isLoading: s.data.isListLoading,
                ),
                orElse: () => const _ApprovalsListState(requests: [], isLoading: false),
              ),
              builder: (context, listState) {
                return ApprovalsListContent(
                  requests: listState.requests,
                  isLoading: listState.isLoading,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getLabel(AppLocalizations l10n, int index, ApprovalsSummaryEntity summary) {
    if (widget.isRaisedRequest) {
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

  @override
  bool get wantKeepAlive => true;
}

class _ApprovalsListState {
  final List<ApprovalRequestEntity> requests;
  final bool isLoading;

  const _ApprovalsListState({
    required this.requests,
    required this.isLoading,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ApprovalsListState &&
          runtimeType == other.runtimeType &&
          requests == other.requests &&
          isLoading == other.isLoading;

  @override
  int get hashCode => requests.hashCode ^ isLoading.hashCode;
}