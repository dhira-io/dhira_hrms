import 'dart:async';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/presentation/widgets/approvals_sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/widgets/no_internet_widget.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';
import '../bloc/approvals_state.dart';
import 'package:dhira_hrms/core/widgets/app_header.dart';
import '../../domain/entities/approval_type.dart';
import '../widgets/approvals_shimmer.dart';
import '../dialogs/widgets/approvals_list_content.dart';

class ApprovalsScreen extends StatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen> {
  late final ScrollController _scrollController;
  ApprovalCategory? _previousCategory;
  ApprovalType? _previousType;

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
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      context.read<ApprovalsBloc>().add(const ApprovalsEvent.loadMoreRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApprovalsBloc, ApprovalsState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) {
            // Scroll to top only when category or type actually changed
            if (_previousCategory != null &&
                (_previousCategory != data.category || _previousType != data.type)) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(0);
              }
            }
            _previousCategory = data.category;
            _previousType = data.type;

            if (data.successMessage != null && data.successMessage!.isNotEmpty) {
              ToastUtils.showSuccess(data.successMessage!);
            }
            if (data.errorMessage != null && data.errorMessage!.isNotEmpty) {
              ToastUtils.showError(data.errorMessage!);
            }
          },
          failure: (message) => ToastUtils.showError(message),
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer<void>();
            context.read<ApprovalsBloc>().add(
                  ApprovalsEvent.refreshRequested(completer: completer),
                );
            return completer.future;
          },
          child: BlocBuilder<ApprovalsBloc, ApprovalsState>(
            builder: (context, state) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  const SliverToBoxAdapter(child: AppHeader()),
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
                          onReload: () => context
                              .read<ApprovalsBloc>()
                              .add(const ApprovalsEvent.started()),
                        ),
                      ),
                    ],
                    success: (data) => [
                      // 1. Primary Tabs (Team/Raised)
                      const SliverToBoxAdapter(
                        child: ApprovalsPrimaryTabsSection(),
                      ),
                      // 2. Sub Tabs (Leave/Attendance/...) - Sticky
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _PersistentHeaderDelegate(
                          height: 64,
                          child: Container(
                            color: AppColors.of(context).background,
                            child: const ApprovalsSubTabsSection(),
                          ),
                        ),
                      ),
                      // 3. Data Section — spread flat slivers
                      ...ApprovalsListContent.buildSlivers(
                        requests: data.requests,
                        isLoading: data.isListLoading,
                        isLoadMoreLoading: data.isLoadMoreLoading,
                        context: context,
                      ),
                      // Bottom padding
                      const SliverPadding(
                        padding: EdgeInsets.only(bottom: 100),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _PersistentHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;

  @override
  bool shouldRebuild(_PersistentHeaderDelegate oldDelegate) => oldDelegate.height != height || oldDelegate.child != child;
}