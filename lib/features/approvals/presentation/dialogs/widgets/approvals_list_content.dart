import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/approval_card.dart';
import '../../widgets/approvals_shimmer.dart';

/// Returns a list of flat slivers for the approvals list content.
/// This avoids using SliverMainAxisGroup which causes parentDataDirty crashes.
class ApprovalsListContent {
  ApprovalsListContent._();

  static List<Widget> buildSlivers({
    required List<ApprovalRequestEntity> requests,
    required bool isLoading,
    bool isLoadMoreLoading = false,
    required BuildContext context,
    Set<String> selectedRequestIds = const {},
  }) {
    if (isLoading) {
      return [
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
          sliver: SliverApprovalsShimmer(),
        ),
      ];
    }

    if (requests.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.noResultsFound,
              style: AppTextStyle.bodyLarge.copyWith(
                color: AppColors.of(context).onSurfaceVariant,
              ),
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final request = requests[index];
            return ApprovalCard(
              data: request,
              isSelected: selectedRequestIds.contains(request.id),
              onSelectionChanged: (selected) {
                context.read<ApprovalsBloc>().add(
                      ApprovalsEvent.requestSelectionToggled(
                        id: request.id,
                        selected: selected,
                      ),
                    );
              },
            );
          }, childCount: requests.length),
        ),
      ),
      if (isLoadMoreLoading)
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
          sliver: SliverSingleApprovalsShimmer(),
        ),
    ];
  }
}
