import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import 'approval_card.dart';

class ApprovalsListView extends StatefulWidget {
  const ApprovalsListView({super.key});

  @override
  State<ApprovalsListView> createState() => _ApprovalsListViewState();
}

class _ApprovalsListViewState extends State<ApprovalsListView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
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
            _buildTab(l10n.leaveRequestsCount(4), _tabController.index == 0),
            _buildTab(l10n.attendanceRequestsCount(4), _tabController.index == 1),
            _buildTab(l10n.timesheetRequestsCount(0), _tabController.index == 2),
            _buildTab(l10n.compOffRequestsCount(0), _tabController.index == 3),
          ],
        ),
        const SizedBox(height: AppConstants.p16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildRequestList(),
              const Center(child: Text('Attendance Requests')),
              const Center(child: Text('Timesheet Requests')),
              const Center(child: Text('Comp Off Requests')),
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
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
      itemCount: 2,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: AppConstants.p16),
          child: ApprovalCard(),
        );
      },
    );
  }
}
