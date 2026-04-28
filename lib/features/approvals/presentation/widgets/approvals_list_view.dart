import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/approvals_summary_entity.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/entities/approval_type.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import 'approval_card.dart';
import 'approvals_shimmer.dart';

class ApprovalsListView extends StatefulWidget {
  final ApprovalsSummaryEntity? summary;
  final List<ApprovalRequestEntity> requests;
  final bool isLoading;
  final bool isRaisedRequest; // Flag to handle Raised vs Team UI logic

  const ApprovalsListView({
    super.key,
    this.summary,
    required this.requests,
    required this.isLoading,
    this.isRaisedRequest = false,
  });

  @override
  State<ApprovalsListView> createState() => _ApprovalsListViewState();
}

class _ApprovalsListViewState extends State<ApprovalsListView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Listen to tab changes to trigger API calls
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    // indexIsChanging is true during the swipe animation; we only trigger on final selection
    if (!_tabController.indexIsChanging) {
      final type = _getTypeFromIndex(_tabController.index);

      // Dispatch event to Bloc to fetch new data based on tab
      context.read<ApprovalsBloc>().add(ApprovalsEvent.categoryChanged(type));

      // Update local UI state for tab styling
      setState(() {});
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

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          labelPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p8),
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          tabs: [
            _buildTab(
              _getLabel(l10n, 0),
              _tabController.index == 0,
            ),
            _buildTab(
              _getLabel(l10n, 1),
              _tabController.index == 1,
            ),
            _buildTab(
              _getLabel(l10n, 2),
              _tabController.index == 2,
            ),
            _buildTab(
              _getLabel(l10n, 3),
              _tabController.index == 3,
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p16),
        Expanded(
          child: _buildRequestList(),
        ),
      ],
    );
  }

  /// Logic to hide counts if isRaisedRequest is true
  String _getLabel(AppLocalizations l10n, int index) {
    if (widget.isRaisedRequest) {
      // Plain text labels for Raised Requests
      switch (index) {
        case 0: return l10n.leave;
        case 1: return l10n.attendance;
        case 2: return l10n.timesheet;
        case 3: return l10n.comOff;
        default: return "";
      }
    } else {
      // Labels with counts for Team Approvals
      switch (index) {
        case 0: return l10n.leaveRequestsCount(widget.summary?.leaveApprovalsPending ?? 0);
        case 1: return l10n.attendanceRequestsCount(widget.summary?.attendanceRegularizationPending ?? 0);
        case 2: return l10n.timesheetRequestsCount(widget.summary?.timesheetApprovalsPending ?? 0);
        case 3: return l10n.compOffRequestsCount(widget.summary?.compensatoryLeavePending ?? 0);
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

  Widget _buildRequestList() {
    if (widget.isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
        child: ApprovalsShimmer(),
      );
    }

    if (widget.requests.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noResultsFound,
          style: AppTextStyle.bodyLarge.copyWith(color: AppColors.onSurfaceVariant),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
      itemCount: widget.requests.length,
      itemBuilder: (context, index) {
        return ApprovalCard(data: widget.requests[index]);
      },
    );
  }
}