import 'package:dhira_hrms/features/notifications/data/constants/notification_constants.dart';
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
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<NotificationBloc>().add(const NotificationEvent.load(isRefresh: false));
      }
    });
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

  String _getLocalizedGroupName(String key, AppLocalizations l10n) {
    // Fallback localization logic
    if (key == NotificationGroupConstants.groupToday) return l10n.today;
    if (key == NotificationGroupConstants.groupYesterday) return l10n.yesterday;
    if (key == NotificationGroupConstants.groupEarlier) return l10n.earlier;
    return key;
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
          icon: Icon(Icons.arrow_back_ios, color: AppColors.onSurface),
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
          TextButton(
            onPressed: () => context.read<NotificationBloc>().add(
              const NotificationEvent.markAllRead(),
            ),
            child: Text(
              l10n.markAllAsRead,
              style: AppTextStyle.labelMedium.copyWith(
                color: AppColors.primaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: AppConstants.p8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.surfaceContainerLow, height: 1),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return state.when(
            initial: () => const NotificationsLoadingWidget(),
            loading: () => const NotificationsLoadingWidget(),
            loaded: (notifications, groupedNotifications, sortedGroupKeys, hasMore, currentPage, isFetchingMore, isRefreshing) {
              return _buildNotificationList(
                l10n: l10n,
                notifications: notifications,
                sortedGroups: sortedGroupKeys,
                groups: groupedNotifications,
                hasMore: hasMore,
              );
            },
            error: (message) => NotificationsErrorWidget(
              message: message,
              onRetry: () => context.read<NotificationBloc>().add(
                const NotificationEvent.load(isRefresh: false),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationList({
    required AppLocalizations l10n,
    required List<NotificationEntity> notifications,
    required List<String> sortedGroups,
    required Map<String, List<NotificationEntity>> groups,
    required bool hasMore,
  }) {
    if (notifications.isEmpty) {
      return const NotificationEmptyWidget();
    }

    return RefreshIndicator(
      onRefresh: () async {
        final bloc = context.read<NotificationBloc>();
        bloc.add(const NotificationEvent.load(isRefresh: true));
        await bloc.stream.firstWhere((s) => s.maybeWhen(
          loaded: (_, __, ___, ____, _____, ______, isRefreshing) => !isRefreshing,
          orElse: () => true,
        ));
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
        itemCount: sortedGroups.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == sortedGroups.length) {
            return const Padding(
              padding: EdgeInsets.all(AppConstants.p16),
              child: Center(child: NotificationItemShimmer()),
            );
          }

          final groupKey = sortedGroups[index];
          final groupNotifications = groups[groupKey] ?? [];

          return NotificationGroupWidget(
            localizedGroupName: _getLocalizedGroupName(groupKey, l10n),
            notifications: groupNotifications,
          );
        },
      ),
    );
  }
}
