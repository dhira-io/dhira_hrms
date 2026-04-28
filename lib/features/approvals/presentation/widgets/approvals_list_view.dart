import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/approvals_summary_entity.dart';
import '../../domain/entities/approval_request_entity.dart';
import 'approval_card.dart';
import 'approvals_shimmer.dart';

class ApprovalsListView extends StatefulWidget {
  final ApprovalsSummaryEntity? summary;
  final List<ApprovalRequestEntity> requests;
  final bool isLoading;

  const ApprovalsListView({
    super.key,
    this.summary,
    required this.requests,
    required this.isLoading,
  });

  @override
  State<ApprovalsListView> createState() => _ApprovalsListViewState();
}

class _ApprovalsListViewState extends State<ApprovalsListView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Standard 4 tabs for Leave, Attendance, Timesheet, and Comp-off
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
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
              l10n.leaveRequestsCount(widget.summary?.leaveApprovalsPending ?? 0),
              _tabController.index == 0,
            ),
            _buildTab(
              l10n.attendanceRequestsCount(
                widget.summary?.attendanceRegularizationPending ?? 0,
              ),
              _tabController.index == 1,
            ),
            _buildTab(
              l10n.timesheetRequestsCount(widget.summary?.timesheetApprovalsPending ?? 0),
              _tabController.index == 2,
            ),
            _buildTab(
              l10n.compOffRequestsCount(widget.summary?.compensatoryLeavePending ?? 0),
              _tabController.index == 3,
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildSliverRequestList(widget.requests),
              _buildSliverRequestList([]), // Logic for other tabs to be added in BLoC
              _buildSliverRequestList([]),
              _buildSliverRequestList([]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, bool isSelected) {
    return Tab(
      height: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p16,
          vertical: AppConstants.p8,
        ),
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

  /// High-performance Sliver List implementation
  Widget _buildSliverRequestList(List<ApprovalRequestEntity> requests) {
    if (widget.isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
        child: ApprovalsShimmer(),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          sliver: requests.isEmpty
              ? SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.noResultsFound, // Use existing localization key
                style: AppTextStyle.bodyLarge.copyWith(color: AppColors.onSurfaceVariant),
              ),
            ),
          )
              : SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.p16),
                child: ApprovalCard(data: requests[index]), // Pass domain entity
              ),
              childCount: requests.length,
            ),
          ),
        ),
      ],
    );
  }
}