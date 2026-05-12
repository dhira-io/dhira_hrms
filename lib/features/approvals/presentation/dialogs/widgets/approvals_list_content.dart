import 'package:dhira_hrms/core/constants/app_constants.dart';
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

class ApprovalsListContent extends StatelessWidget {
  final List<ApprovalRequestEntity> requests;
  final bool isLoading;
  final bool isLoadMoreLoading;

  const ApprovalsListContent({
    super.key,
    required this.requests,
    required this.isLoading,
    this.isLoadMoreLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
        sliver: SliverApprovalsShimmer(),
      );
    }

    if (requests.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.noResultsFound,
            style: AppTextStyle.bodyLarge.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ApprovalCard(data: requests[index]);
              },
              childCount: requests.length,
            ),
          ),
          if (isLoadMoreLoading) const SliverSingleApprovalsShimmer(),
        ],
      ),
    );
  }
}
