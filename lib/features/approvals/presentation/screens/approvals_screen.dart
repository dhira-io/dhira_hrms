import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../dialogs/widgets/approvals_primary_tab_bar.dart';
import 'package:dhira_hrms/core/widgets/app_header.dart';
import 'package:dhira_hrms/core/widgets/no_internet_widget.dart';

class ApprovalsScreen extends StatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _tabCount = 0;


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


  void _syncTabController(dynamic data) {
    final bool showTeamApprovals = data.access.canAccess;
    final int tabCount = showTeamApprovals ? 2 : 1;

    if (_tabController == null || _tabCount != tabCount) {
      _tabController?.removeListener(_handleTabChange);
      _tabController?.dispose();

      final int initialIndex = (showTeamApprovals && data.targetCategory == ApprovalCategory.raised) ? 1 : 0;

      _tabController = TabController(
        length: tabCount,
        vsync: this,
        initialIndex: initialIndex,
      );
      _tabController!.addListener(_handleTabChange);
      _tabCount = tabCount;
      setState(() {});
    } else {
      final int targetIndex = (showTeamApprovals && data.targetCategory == ApprovalCategory.raised) ? 1 : 0;
      if (_tabController!.index != targetIndex && !_tabController!.indexIsChanging) {
        _tabController!.animateTo(targetIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApprovalsBloc, ApprovalsState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) {
            _syncTabController(data);
            if (data.successMessage != null && data.successMessage!.isNotEmpty) {
              ToastUtils.showSuccess(data.successMessage!);
            }
            if (data.errorMessage != null && data.errorMessage!.isNotEmpty) {
              ToastUtils.showError(data.errorMessage!);
            }
          },
          failure: (message) {
            ToastUtils.showError(message);
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
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
              failure: (message) => NoInternetWidget(
                onReload: () => context.read<ApprovalsBloc>().add(
                  const ApprovalsEvent.started(),
                ),
                message: message,
              ),
              success: (data) {
                if (_tabController == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                final bool showTeamApprovals = data.access.canAccess;

                return Column(
                  children: [
                    const AppHeader(),
                    const SizedBox(height: AppConstants.p8),
                    if (showTeamApprovals)
                      ApprovalsPrimaryTabBar(controller: _tabController)
                    else
                      const SizedBox.shrink(),
                    const SizedBox(height: AppConstants.p16),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: showTeamApprovals
                            ? const AlwaysScrollableScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        children: [
                          if (showTeamApprovals)
                            const ApprovalsListView(isRaisedRequest: false),
                          const ApprovalsListView(isRaisedRequest: true),
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

}