import 'package:flutter/material.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/notification_entity.dart';
import '../../../../core/utils/date_time_utils.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';

class NotificationItemCard extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItemCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.p12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.of(context).surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppConstants.r12),
          border: Border.all(
            color: notification.isRead
                ? Colors.transparent
                : AppColors.of(context).primary.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.of(context).onSurface.withValues(alpha: 0.02),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppConstants.r12),
            onTap: () {
              if (!notification.isRead) {
                context.read<NotificationBloc>().add(
                  NotificationEvent.markRead(notification.id),
                );
              }
              AppRouter.navigateByNotification(
                type: notification.rawType.isNotEmpty
                    ? notification.rawType
                    : notification.type.name,
                docName: notification.docName.isNotEmpty
                    ? notification.docName
                    : notification.id,
                title: notification.title.isEmpty
                    ? AppLocalizations.of(context)!.noSubject
                    : notification.title,
              );
            },
            child: Stack(
              children: [
                if (!notification.isRead)
                  Positioned(
                    top: AppConstants.p16,
                    left: AppConstants.p12,
                    child: Container(
                      width: AppConstants.p8,
                      height: AppConstants.p8,
                      decoration: BoxDecoration(
                        color: AppColors.of(context).primaryContainer,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(AppConstants.p16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: AppConstants.p8),
                      NotificationIcon(type: notification.type),
                      const SizedBox(width: AppConstants.p12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.title.isEmpty
                                  ? AppLocalizations.of(context)!.noSubject
                                  : notification.title,
                              style: AppTextStyle.h3.copyWith(
                                fontSize: AppConstants.fs13.sp,
                                fontWeight: notification.isRead
                                    ? FontWeight.w600
                                    : FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppConstants.p2),
                            Text(
                              _formatTime(context, notification.time),
                              style: AppTextStyle.labelSmall.copyWith(
                                color: AppColors.of(context).onSurfaceVariant,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: AppConstants.p4),
                            Text(
                              notification.description.isEmpty
                                  ? ''
                                  : notification.description,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.of(context).onSurfaceVariant,
                                height: AppConstants.lineHeightNormal,
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
          ),
        ),
      ),
    );
  }

  String _formatTime(BuildContext context, DateTime? time) {
    if (time == null) return '';
    return DateTimeUtils.formatTimeAgo(
      time,
      l10n: AppLocalizations.of(context)!,
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final NotificationType type;

  const NotificationIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color bgColor;
    Color iconColor;

    switch (type) {
      case NotificationType.leave:
        iconData = Icons.event_available;
        bgColor = AppColors.of(context).primaryFixed;
        iconColor = AppColors.of(context).onPrimaryFixed;
        break;
      case NotificationType.timesheet:
        iconData = Icons.schedule;
        bgColor = AppColors.of(context).surfaceContainer;
        iconColor = AppColors.of(context).onSurfaceVariant;
        break;
      case NotificationType.policy:
        iconData = Icons.description;
        bgColor = AppColors.of(context).secondaryContainer;
        iconColor = AppColors.of(context).onSecondaryFixedVariant;
        break;
      case NotificationType.team:
        iconData = Icons.group;
        bgColor = AppColors.of(context).tertiaryFixed;
        iconColor = AppColors.of(context).onTertiaryFixed;
        break;
      case NotificationType.celebration:
        iconData = Icons.celebration;
        bgColor = AppColors.of(context).primaryFixed.withValues(alpha: 0.5);
        iconColor = AppColors.of(context).primary;
        break;
    }

    return Container(
      width: AppConstants.p40,
      height: AppConstants.p40,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(iconData, size: AppConstants.iconXSmall, color: iconColor),
    );
  }
}
