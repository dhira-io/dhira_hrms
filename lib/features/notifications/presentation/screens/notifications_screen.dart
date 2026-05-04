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

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () {
            // Navigation handled by GoRouter or BottomNav
          },
        ),
        title: Text(
          "Notifications",
          style: AppTextStyle.h2.copyWith(
            color: AppColors.primaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
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
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (notifications) => _buildNotificationList(notifications),
            error: (message) => Center(child: Text(message)),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationEntity> notifications) {
    final groups = <String, List<NotificationEntity>>{};
    for (var n in notifications) {
      groups.putIfAbsent(n.group, () => []).add(n);
    }

    final sortedGroups = ['Today', 'Yesterday', 'Earlier'];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p24),
      itemCount: sortedGroups.length,
      itemBuilder: (context, index) {
        final groupName = sortedGroups[index];
        final groupNotifications = groups[groupName];

        if (groupNotifications == null || groupNotifications.isEmpty) {
          return const SizedBox.shrink();
        }

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
    );
  }
}
