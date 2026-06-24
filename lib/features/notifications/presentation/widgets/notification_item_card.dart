import 'package:flutter/material.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/constants/notification_constants.dart';
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
    final colors = AppColors.of(context);
    final isUnread = !notification.isRead;

    return Column(
      children: [
        Material(
          color: isUnread ? colors.infoBg : colors.surfaceContainerLowest,
          child: InkWell(
            onTap: () {
              if (isUnread) {
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppConstants.p16.h,
                horizontal: AppConstants.p16.w,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NotificationIcon(notification: notification),
                  SizedBox(width: AppConstants.p12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title.isEmpty
                              ? AppLocalizations.of(context)!.noSubject
                              : notification.title,
                          style: AppTextStyle.h3.copyWith(
                            fontSize: AppConstants.fs14.sp,
                            fontWeight: FontWeight.bold,
                            color: colors.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: AppConstants.p4.h),
                        if (notification.description.isNotEmpty) ...[
                          Text(
                            notification.description,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: colors.onSurfaceVariant,
                              fontSize: AppConstants.fs13.sp,
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: AppConstants.p4.h),
                        ],
                        if (notification.time != null)
                          Text(
                            _formatTime(context, notification.time),
                            style: AppTextStyle.labelSmall.copyWith(
                              color: colors.slate400,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (isUnread)
                    Padding(
                      padding: EdgeInsets.only(top: AppConstants.p4.h),
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: colors.bordergrey.withValues(alpha: 0.5),
        ),
      ],
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
  final NotificationEntity notification;

  const NotificationIcon({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final type = notification.type;

    final rawType = notification.rawType?.toLowerCase();

    IconData iconData;
    Color bgColor;
    Color iconColor;

    if (rawType == NotificationTypeKeys.attendanceRegularization ||
        rawType == NotificationTypeKeys.attendance) {
      iconData = Icons.checklist;
      bgColor = colors.infoBg;
      iconColor = colors.info;
    } else if (rawType == NotificationTypeKeys.leave ||
        rawType == NotificationTypeKeys.leaveApplication) {
      iconData = Icons.event;
      bgColor = colors.infoBg;
      iconColor = colors.info;
    } else {
      switch (type) {
        case NotificationType.leave:
          iconData = Icons.event_available;
          bgColor = colors.infoBg;
          iconColor = colors.info;
          break;
        case NotificationType.timesheet:
          iconData = Icons.schedule;
          bgColor = colors.surfaceContainer;
          iconColor = colors.onSurfaceVariant;
          break;
        case NotificationType.policy:
          iconData = Icons.description;
          bgColor = colors.secondaryContainer;
          iconColor = colors.onSecondaryFixedVariant;
          break;
        case NotificationType.team:
          iconData = Icons.group;
          bgColor = colors.tertiaryFixed;
          iconColor = colors.onTertiaryFixed;
          break;
        case NotificationType.celebration:
          iconData = Icons.celebration;
          bgColor = colors.primaryFixed.withValues(alpha: 0.5);
          iconColor = colors.primary;
          break;
      }
    }

    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(
        iconData,
        size: 20.w,
        color: iconColor,
      ),
    );
  }

}
