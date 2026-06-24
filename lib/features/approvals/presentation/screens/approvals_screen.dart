import 'dart:async';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/data/constants/approvals_api_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/presentation/widgets/approvals_sections.dart';
import 'package:dhira_hrms/features/approvals/presentation/widgets/approvals_filter_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/widgets/no_internet_widget.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import '../bloc/approvals_state.dart';
import 'package:dhira_hrms/core/widgets/app_header.dart';
import '../../domain/entities/approval_type.dart';
import '../widgets/approvals_shimmer.dart';
import '../dialogs/widgets/approvals_list_content.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class ApprovalsScreen extends StatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen> {
  late final ScrollController _scrollController;
  ApprovalCategory? _previousCategory;
  ApprovalType? _previousType;
  String? _bulkLoadingAction;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ApprovalsBloc>().add(const ApprovalsEvent.started());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<ApprovalsBloc>().add(
        const ApprovalsEvent.loadMoreRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return BlocListener<ApprovalsBloc, ApprovalsState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) {
            // Scroll to top only when category or type actually changed
            if (_previousCategory != null &&
                (_previousCategory != data.category ||
                    _previousType != data.type)) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(0);
              }
            }
            _previousCategory = data.category;
            _previousType = data.type;

            if (data.successMessage != null &&
                data.successMessage!.isNotEmpty) {
              ToastUtils.showSuccess(data.successMessage!);
              context.read<ApprovalsBloc>().add(
                const ApprovalsEvent.clearMessages(),
              );
            }
            if (data.errorMessage != null && data.errorMessage!.isNotEmpty) {
              String displayError = data.errorMessage!;
              if (displayError.startsWith(ApprovalsApiConstants.msgFailedToRefreshPrefix)) {
                final errorDetails = displayError.substring(ApprovalsApiConstants.msgFailedToRefreshPrefix.length);
                displayError = AppLocalizations.of(context)!.failedToRefresh(errorDetails);
              }
              ToastUtils.showError(displayError);
              context.read<ApprovalsBloc>().add(
                const ApprovalsEvent.clearMessages(),
              );
            }
          },
          failure: (message) => ToastUtils.showError(message),
          orElse: () {},
        );
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: colors.background,
        body: BlocBuilder<ApprovalsBloc, ApprovalsState>(
          builder: (context, state) {
            return Column(
              children: [
                const AppHeader(),
                state.maybeWhen(
                  success: (data) => Column(
                    children: [
                      const ApprovalsPrimaryTabsSection(),
                      Container(
                        color: colors.background,
                        child: const ApprovalsFilterSection(),
                      ),
                    ],
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      final completer = Completer<void>();
                      context.read<ApprovalsBloc>().add(
                        ApprovalsEvent.refreshRequested(completer: completer),
                      );
                      return completer.future;
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        ...state.when(
                          initial: () => [
                            const SliverToBoxAdapter(
                              child: ApprovalsFullScreenShimmer(),
                            ),
                          ],
                          loading: () => [
                            const SliverToBoxAdapter(
                              child: ApprovalsFullScreenShimmer(),
                            ),
                          ],
                          failure: (message) => [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: NoInternetWidget(
                                message: message,
                                onReload: () => context.read<ApprovalsBloc>().add(
                                  const ApprovalsEvent.started(),
                                ),
                              ),
                            ),
                          ],
                          success: (data) => [
                            // 3. Data Section — spread flat slivers
                            ...ApprovalsListContent.buildSlivers(
                              requests: data.filteredRequests,
                              selectedRequestIds: data.selectedRequestIds,
                              isLoading: data.isListLoading,
                              isLoadMoreLoading: data.isLoadMoreLoading,
                              context: context,
                            ),
                            // Bottom padding
                            SliverPadding(
                              padding: EdgeInsets.only(bottom: 100.h),
                            ),
                          ], // closes success
                        ), // closes maybeWhen
                      ], // closes slivers
                    ), // closes CustomScrollView
                  ),
                ),
              ],
            );
          },
        ),
          ),
          BlocBuilder<ApprovalsBloc, ApprovalsState>(
            builder: (context, state) {
              final l10n = AppLocalizations.of(context)!;
              if (state is Success && state.data.selectedRequestIds.isNotEmpty) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLowest,
                      boxShadow: [
                        BoxShadow(
                          color: colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                      borderRadius: BorderRadius.vertical(top: Radius.circular(AppConstants.r24)),
                    ),
                    padding: EdgeInsets.only(
                      left: AppConstants.p24,
                      right: AppConstants.p24,
                      top: AppConstants.p16,
                      bottom: MediaQuery.of(context).padding.bottom + AppConstants.p16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.bulkRequests,
                              style: AppTextStyle.titleLarge.copyWith(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<ApprovalsBloc>().add(const ApprovalsEvent.selectAllToggled(false));
                              },
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ),
                        const SizedBox(height: AppConstants.p8),
                        Text(
                          l10n.requestsSelected(state.data.selectedRequestIds.length.toString()),
                          style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppConstants.p16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: state.data.isBulkActionLoading
                                    ? null
                                    : () {
                                        setState(() => _bulkLoadingAction = ApprovalActions.reject);
                                        context.read<ApprovalsBloc>().add(
                                              ApprovalsEvent.bulkWorkflowActionSubmitted(
                                                requestIds: state.data.selectedRequestIds.toList(),
                                                action: l10n.reject,
                                                type: state.data.type,
                                                category: state.data.category,
                                              ),
                                            );
                                      },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  side: BorderSide(color: colors.error),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                                ),
                                child: state.data.isBulkActionLoading && _bulkLoadingAction == ApprovalActions.reject
                                    ? SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: colors.error),
                                      )
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.cancel_outlined, color: colors.error, size: 20),
                                          SizedBox(width: 8.w),
                                          Text(l10n.reject, style: AppTextStyle.labelLarge.copyWith(color: colors.error)),
                                        ],
                                      ),
                              ),
                            ),
                            const SizedBox(width: AppConstants.p16),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: state.data.isBulkActionLoading
                                    ? null
                                    : () {
                                        setState(() => _bulkLoadingAction = ApprovalActions.approve);
                                        context.read<ApprovalsBloc>().add(
                                              ApprovalsEvent.bulkWorkflowActionSubmitted(
                                                requestIds: state.data.selectedRequestIds.toList(),
                                                action: l10n.approve,
                                                type: state.data.type,
                                                category: state.data.category,
                                              ),
                                            );
                                      },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  side: BorderSide(color: colors.success),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                                ),
                                child: state.data.isBulkActionLoading && _bulkLoadingAction == ApprovalActions.approve
                                    ? SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: colors.success),
                                      )
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle_outline, color: colors.success, size: 20),
                                          SizedBox(width: 8.w),
                                          Text(l10n.approve, style: AppTextStyle.labelLarge.copyWith(color: colors.success)),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
