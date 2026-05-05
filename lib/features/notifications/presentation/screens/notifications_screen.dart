import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../widgets/notification_item_card.dart';
import '../../domain/entities/notification_entity.dart';
import '../../../../core/services/notification_manager.dart';


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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Notifications",
          style: AppTextStyle.h2.copyWith(
            color: AppColors.primaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report, color: AppColors.onSurfaceVariant),
            tooltip: "Test Local Alert",
            onPressed: () => NotificationManager().sendTestNotification(),
          ),
          TextButton(
            onPressed: () => context.read<NotificationBloc>().add(const NotificationEvent.markAllRead()),

            child: Text(
              "Mark all as read",
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
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            return _buildNotificationList(state);
          } else if (state is NotificationError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildNotificationList(NotificationLoaded state) {
    final notifications = state.notifications;

    
    if (notifications.isEmpty) {
      return Center(
        child: Text(
          "No notifications yet",
          style: AppTextStyle.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
        ),
      );
    }

    // Grouping logic
    final groups = <String, List<NotificationEntity>>{};
    for (var n in notifications) {
      groups.putIfAbsent(n.group, () => []).add(n);
    }

    final sortedGroups = ['Today', 'Yesterday', 'Earlier'].where((g) => groups.containsKey(g)).toList();

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
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final groupName = sortedGroups[index];
          final groupNotifications = groups[groupName]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: AppConstants.p12),
                child: Text(
                  groupName.toUpperCase(),
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...groupNotifications.map((n) => NotificationItemCard(notification: n)),
              const SizedBox(height: AppConstants.p24),
            ],
          );
        },
      ),
    );
  }
}

