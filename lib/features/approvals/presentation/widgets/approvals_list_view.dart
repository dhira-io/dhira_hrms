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

class ApprovalsListView extends StatefulWidget {
  final List<ApprovalRequestEntity> requests;
  final bool isLoading;
  final ApprovalsSummaryEntity summary;
  final bool isRaisedRequest;

  const ApprovalsListView({
    super.key,
    required this.requests,
    required this.isLoading,
    required this.summary,
    this.isRaisedRequest = false,
  });

  @override
  State<ApprovalsListView> createState() => _ApprovalsListViewState();
}

class _ApprovalsListViewState extends State<ApprovalsListView> with SingleTickerProviderStateMixin {
  late TabController _subTabController;

  @override
  void initState() {
    super.initState();
    _subTabController = TabController(length: 4, vsync: this);
    _subTabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_subTabController.indexIsChanging) {
      final type = _getTypeFromIndex(_subTabController.index);
      // Tells Bloc to fetch specific data for this tab
// In approvals_list_view.dart inside _handleTabChange()
      context.read<ApprovalsBloc>().add(
        ApprovalsEvent.categoryChanged(
          _getTypeFromIndex(_subTabController.index),
          widget.isRaisedRequest ? ApprovalCategory.raised : ApprovalCategory.team, // Pass the category here
        ),
      );
      setState(() {}); // Rebuild to update tab styling
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
            if (_subTabController.index != targetIdx && !_subTabController.indexIsChanging) {
              _subTabController.animateTo(targetIdx);
            }
          },
          orElse: () {},
        );
      },
      child: Column(
        children: [
          // SECOND TOPBAR: Scrollable Sub-tabs
          TabBar(
            controller: _subTabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            labelPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p8),
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            tabs: [
              _buildTab(_getLabel(l10n, 0), _subTabController.index == 0),
              _buildTab(_getLabel(l10n, 1), _subTabController.index == 1),
              _buildTab(_getLabel(l10n, 2), _subTabController.index == 2),
              _buildTab(_getLabel(l10n, 3), _subTabController.index == 3),
            ],
          ),
          const SizedBox(height: AppConstants.p16),
          Expanded(
            child: _buildListContent(),
          ),
        ],
      ),
    );
  }

  String _getLabel(AppLocalizations l10n, int index) {
    if (widget.isRaisedRequest) {
      // Labels for Raised Request (NO counts)
      switch (index) {
        case 0: return l10n.leave;
        case 1: return l10n.attendance;
        case 2: return l10n.timesheet;
        case 3: return l10n.comOff;
        default: return "";
      }
    } else {
      // Labels for Team Approvals (WITH dynamic counts)
      switch (index) {
        case 0: return l10n.leaveRequestsCount(widget.summary.leaveApprovalsPending);
        case 1: return l10n.attendanceRequestsCount(widget.summary.attendanceRegularizationPending);
        case 2: return l10n.timesheetRequestsCount(widget.summary.timesheetApprovalsPending);
        case 3: return l10n.compOffRequestsCount(widget.summary.compensatoryLeavePending);
        default: return "";
      }
    }
  }

  Widget _buildTab(String label, bool isSelected) {
    return Tab(
      height: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryFixed : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r24),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.labelMedium.copyWith(
            color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildListContent() {
    return CustomScrollView(
      slivers: [
        if (widget.isLoading)
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
            sliver: SliverApprovalsShimmer(),
          )
        else if (widget.requests.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.noResultsFound,
                style: AppTextStyle.bodyLarge.copyWith(color: AppColors.onSurfaceVariant),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ApprovalCard(data: widget.requests[index]);
                },
                childCount: widget.requests.length,
              ),
            ),
          ),
      ],
    );
  }
}