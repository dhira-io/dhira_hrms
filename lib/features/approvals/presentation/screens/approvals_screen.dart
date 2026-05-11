import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import '../bloc/approvals_state.dart';
import '../widgets/approvals_list_view.dart';
import '../widgets/approvals_shimmer.dart';

class ApprovalsScreen extends StatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _tabCount = 0;

  bool _isActionLoading = false;

  @override
  void initState() {
    super.initState();

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
            context.read<ApprovalsBloc>().add(
              ApprovalsEvent.categoryChanged(
                ApprovalType.leave,
                newCategory,
              ),
            );
          }
        },
        orElse: () {
          context.read<ApprovalsBloc>().add(
            ApprovalsEvent.categoryChanged(
              ApprovalType.leave,
              newCategory,
            ),
          );
        },
      );
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        final l10n = AppLocalizations.of(context)!;

        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.r16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: AppConstants.p16),
                  Text(
                    l10n.loading,
                    style: AppTextStyle.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ApprovalsBloc, ApprovalsState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () {
            if (!_isActionLoading) {
              _isActionLoading = true;
              _showLoadingDialog(context);
            }
          },
          success: (data) {
            if (_isActionLoading) {
              _isActionLoading = false;
              _hideLoadingDialog(context);
            }

            if (data.successMessage != null &&
                data.successMessage!.isNotEmpty) {
              ToastUtils.showSuccess(data.successMessage!);
            }

            if (data.errorMessage != null &&
                data.errorMessage!.isNotEmpty) {
              ToastUtils.showError(data.errorMessage!);
            }
          },
          failure: (message) {
            if (_isActionLoading) {
              _isActionLoading = false;
              _hideLoadingDialog(context);
            }

            ToastUtils.showError(message);
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: false,
          title: Text(
            l10n.approvals,
            style: AppTextStyle.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<ApprovalsBloc, ApprovalsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.p16,
                ),
                child: ApprovalsShimmer(),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.p16,
                ),
                child: ApprovalsShimmer(),
              ),
              failure: (message) {
                return Center(
                  child: Text(message),
                );
              },
              success: (data) {
                final bool showTeamApprovals =
                    data.access.canAccess;

                final int tabCount =
                showTeamApprovals ? 2 : 1;

                final int targetIndex =
                (showTeamApprovals &&
                    data.targetCategory ==
                        ApprovalCategory.raised)
                    ? 1
                    : 0;

                if (_tabController == null ||
                    _tabCount != tabCount) {
                  _tabController?.removeListener(
                    _handleTabChange,
                  );

                  _tabController?.dispose();

                  _tabController = TabController(
                    length: tabCount,
                    vsync: this,
                    initialIndex: targetIndex,
                  );

                  if (tabCount == 2) {
                    _tabController!.index =
                    (data.category ==
                        ApprovalCategory.raised)
                        ? 1
                        : 0;
                  } else {
                    _tabController!.index = 0;
                  }

                  _tabController!
                      .addListener(_handleTabChange);

                  _tabCount = tabCount;
                } else {
                  if (_tabController!.index != targetIndex &&
                      !_tabController!.indexIsChanging) {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) {
                      if (mounted) {
                        _tabController!.animateTo(
                          targetIndex,
                        );
                      }
                    });
                  }
                }

                return Column(
                  children: [
                    const SizedBox(
                      height: AppConstants.p8,
                    ),

                    if (showTeamApprovals)
                      _buildPrimaryTabBar(l10n)
                    else
                      const SizedBox.shrink(),

                    const SizedBox(
                      height: AppConstants.p16,
                    ),

                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: showTeamApprovals
                            ? const AlwaysScrollableScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        children: [
                          if (showTeamApprovals)
                            ApprovalsListView(
                              summary: data.summary,
                              requests: data.requests,
                              isLoading:
                              data.isListLoading,
                              isRaisedRequest: false,
                            ),

                          ApprovalsListView(
                            summary: data.summary,
                            requests: data.requests,
                            isLoading:
                            data.isListLoading,
                            isRaisedRequest: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPrimaryTabBar(
      AppLocalizations l10n,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p16,
      ),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(
            AppConstants.r12,
          ),
        ),
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.r10),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          labelStyle: AppTextStyle.labelLarge.copyWith(fontWeight: FontWeight.bold),
          unselectedLabelStyle: AppTextStyle.labelLarge,
          tabs: [
            Tab(text: l10n.teamApprovals),
            Tab(text: l10n.raisedRequests),
          ],
        ),
      ),
    );
  }
}