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
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/shimmer_loading.dart';


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
          onPressed: () => Navigator.of(context).pop(),
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
            icon: const Icon(Icons.bug_report, color: AppColors.onSurfaceVariant),
            tooltip: l10n.testLocalAlert,
            onPressed: () => NotificationManager().sendTestNotification(),
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
          final groupNotifications = groups[groupName]!;

          String localizedGroupName = groupName;
          if (groupName == 'Today') {
            localizedGroupName = l10n.today;
          } else if (groupName == 'Yesterday') {
            localizedGroupName = l10n.yesterday;
          } else if (groupName == 'Earlier') {
            localizedGroupName = l10n.earlier;
          }

          return NotificationGroupWidget(
            localizedGroupName: localizedGroupName,
            notifications: groupNotifications,
          );
        },
      ),
    );
  }
}

class NotificationGroupWidget extends StatelessWidget {
  final String localizedGroupName;
  final List<NotificationEntity> notifications;

  const NotificationGroupWidget({
    super.key,
    required this.localizedGroupName,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: AppConstants.p12),
          child: Text(
            localizedGroupName.toUpperCase(),
            style: AppTextStyle.labelSmall.copyWith(
              color: AppColors.onSurfaceVariant,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...notifications.map((n) => NotificationItemCard(notification: n)),
        const SizedBox(height: AppConstants.p24),
      ],
    );
  }
}

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p12),
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          const ShimmerLoading(height: 40, width: 40, borderRadius: 20),
          const SizedBox(width: AppConstants.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoading(height: 16, width: 120),
                    ShimmerLoading(height: 12, width: 50),
                  ],
                ),
                const SizedBox(height: 12),
                const ShimmerLoading(height: 12, width: double.infinity),
                const SizedBox(height: 6),
                const ShimmerLoading(height: 12, width: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationEmptyWidget extends StatelessWidget {
  const NotificationEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        l10n.noNotificationsYet,
        style: AppTextStyle.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
      ),
    );
  }
}

