import '../../data/constants/notification_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/notification_entity.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../widgets/notifications_loading_widget.dart';
import '../widgets/notifications_error_widget.dart';
import '../widgets/notification_empty_widget.dart';
import '../widgets/notification_group_widget.dart';
import '../widgets/notification_item_shimmer.dart';
import '../../../../l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<NotificationBloc>().add(const NotificationEvent.loadMore());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRouter.dashboardPath);
            }
          },
        ),
        title: Text(
          l10n.notifications,
          style: AppTextStyle.h2.copyWith(
            color: AppColors.primaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<NotificationBloc>().add(const NotificationEvent.load()),
            icon: const Icon(Icons.refresh, color: AppColors.primaryContainer),
          ),
          TextButton(
            onPressed: () => context.read<NotificationBloc>().add(const NotificationEvent.markAllRead()),
            child: Text(
              l10n.markAllAsRead,
              style: AppTextStyle.labelMedium.copyWith(
                color: AppColors.primaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.p8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.surfaceContainerLow,
            height: 1,
          ),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const NotificationsLoadingWidget(),
            loading: (_) => const NotificationsLoadingWidget(),
            loaded: (loadedState) => _buildNotificationList(loadedState),
            error: (errorState) => NotificationsErrorWidget(
              message: errorState.message,
              onRetry: () => context.read<NotificationBloc>().add(const NotificationEvent.load()),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationList(NotificationLoaded state) {
    final l10n = AppLocalizations.of(context)!;
    final notifications = state.notifications;
    
    if (notifications.isEmpty) {
      return const NotificationEmptyWidget();
    }

    final sortedGroups = state.sortedGroupKeys;
    final groups = state.groupedNotifications;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<NotificationBloc>().add(const NotificationEvent.load());
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p24),
        itemCount: sortedGroups.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= sortedGroups.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: NotificationItemShimmer(),
            );
          }

          final groupName = sortedGroups[index];
          final groupNotifications = groups[groupName] ?? [];

          String localizedGroupName = groupName;
          if (groupName == NotificationGroupConstants.groupToday) {
            localizedGroupName = l10n.today;
          } else if (groupName == NotificationGroupConstants.groupYesterday) {
            localizedGroupName = l10n.yesterday;
          } else if (groupName == NotificationGroupConstants.groupEarlier) {
            localizedGroupName = l10n.earlier;
          }

          if (groupNotifications.isEmpty) return const SizedBox.shrink();

          return NotificationGroupWidget(
            localizedGroupName: localizedGroupName,
            notifications: groupNotifications,
          );
        },
      ),
    );
  }
}
