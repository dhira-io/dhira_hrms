import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approvals_summary_entity.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/features/approvals/presentation/dialogs/widgets/approval_tab.dart';
import 'package:dhira_hrms/features/approvals/presentation/dialogs/widgets/approvals_primary_tab_bar.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';

class ApprovalsPrimaryTabsSection extends StatelessWidget {
  const ApprovalsPrimaryTabsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ApprovalsBloc, ApprovalsState, bool>(
      selector: (state) => state.maybeMap(
        success: (s) => s.data.access.canAccess,
        orElse: () => false,
      ),
      builder: (context, canAccess) {
        if (!canAccess) return const SizedBox.shrink();
        return const Padding(
          padding: EdgeInsets.only(bottom: AppConstants.p8),
          child: ApprovalsPrimaryTabBar(),
        );
      },
    );
  }
}

class ApprovalsSubTabsSection extends StatelessWidget {
  const ApprovalsSubTabsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ApprovalsBloc, ApprovalsState, _SubTabState>(
      selector: (state) => state.maybeMap(
        success: (s) => _SubTabState(
          summary: s.data.summary,
          isRaised: s.data.category == ApprovalCategory.raised,
          currentType: s.data.type,
        ),
        orElse: () => const _SubTabState(
          summary: null,
          isRaised: false,
          currentType: ApprovalType.leave,
        ),
      ),
      builder: (context, subTabState) {
        if (subTabState.summary == null) return const SizedBox.shrink();
        final l10n = AppLocalizations.of(context)!;

        return Container(
          height: 64.h,
          padding:       EdgeInsets.symmetric(vertical: 8.h),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppConstants.p8),
            itemBuilder: (context, index) {
              final type = ApprovalType.fromIndex(index);
              final isSelected = subTabState.currentType == type;

              return GestureDetector(
                onTap: () {
                  if (!isSelected) {
                    context.read<ApprovalsBloc>().add(
                      ApprovalsEvent.categoryChanged(
                        type,
                        subTabState.isRaised
                            ? ApprovalCategory.raised
                            : ApprovalCategory.team,
                      ),
                    );
                  }
                },
                child: ApprovalTab(
                  label: _getSubTabLabel(
                    l10n,
                    index,
                    subTabState.summary!,
                    subTabState.isRaised,
                  ),
                  isSelected: isSelected,
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _getSubTabLabel(
    AppLocalizations l10n,
    int index,
    ApprovalsSummaryEntity summary,
    bool isRaised,
  ) {
    if (isRaised) {
      switch (index) {
        case 0:
          return l10n.leave;
        case 1:
          return l10n.attendance;
        case 2:
          return l10n.timesheet;
        case 3:
          return l10n.comOff;
        default:
          return "";
      }
    } else {
      switch (index) {
        case 0:
          return l10n.leaveRequestsCount(summary.leaveApprovalsPending);
        case 1:
          return l10n.attendanceRequestsCount(
            summary.attendanceRegularizationPending,
          );
        case 2:
          return l10n.timesheetRequestsCount(summary.timesheetApprovalsPending);
        case 3:
          return l10n.compOffRequestsCount(summary.compensatoryLeavePending);
        default:
          return "";
      }
    }
  }
}

class _SubTabState {
  final ApprovalsSummaryEntity? summary;
  final bool isRaised;
  final ApprovalType currentType;
  const _SubTabState({
    required this.summary,
    required this.isRaised,
    required this.currentType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _SubTabState &&
          runtimeType == other.runtimeType &&
          summary == other.summary &&
          isRaised == other.isRaised &&
          currentType == other.currentType;

  @override
  int get hashCode =>
      summary.hashCode ^ isRaised.hashCode ^ currentType.hashCode;
}
