import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/notification_entity.dart';
import 'package:intl/intl.dart';

class NotificationItemCard extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItemCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(
          color: notification.isRead ? Colors.transparent : AppColors.primary.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.02),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (!notification.isRead)
            Positioned(
              top: 16,
              left: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 8),
                _buildIcon(),
                const SizedBox(width: AppConstants.p12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: AppTextStyle.h3.copyWith(
                                fontSize: 14,
                                fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            _formatTime(notification.time),
                            style: AppTextStyle.labelSmall.copyWith(
                              color: !notification.isRead ? AppColors.primary : AppColors.onSurfaceVariant,
                              fontWeight: !notification.isRead ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.description,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.onSurfaceVariant,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    Color bgColor;
    Color iconColor;

    switch (notification.type) {
      case NotificationType.leave:
        iconData = Icons.event_available;
        bgColor = AppColors.primaryFixed;
        iconColor = AppColors.onPrimaryFixed;
        break;
      case NotificationType.timesheet:
        iconData = Icons.schedule;
        bgColor = AppColors.surfaceContainer;
        iconColor = AppColors.onSurfaceVariant;
        break;
      case NotificationType.policy:
        iconData = Icons.description;
        bgColor = AppColors.secondaryContainer;
        iconColor = AppColors.onSecondaryFixedVariant;
        break;
      case NotificationType.team:
        iconData = Icons.group;
        bgColor = AppColors.tertiaryFixed;
        iconColor = AppColors.onTertiaryFixed;
        break;
      case NotificationType.celebration:
        iconData = Icons.celebration;
        bgColor = AppColors.primaryFixed.withValues(alpha: 0.5);
        iconColor = AppColors.primary;
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        size: 20,
        color: iconColor,
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('hh:mm a').format(time);
    }
  }
}
