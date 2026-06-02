import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/notification_entity.dart';
import 'notification_item_card.dart';

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
          padding: const EdgeInsets.only(left: AppConstants.p8, bottom: AppConstants.p12),
          child: Text(
            localizedGroupName.toUpperCase(),
            style: AppTextStyle.labelSmall.copyWith(
              color: AppColors.of(context).onSurfaceVariant,
              letterSpacing: AppConstants.letterSpacingLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...notifications.map((n) => NotificationItemCard(
              key: ValueKey(n.id),
              notification: n,
            )),
        const SizedBox(height: AppConstants.p24),
      ],
    );
  }
}
