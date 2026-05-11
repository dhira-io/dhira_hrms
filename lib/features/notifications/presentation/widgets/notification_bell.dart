import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class NotificationBell extends StatelessWidget {
  final Color? color;
  const NotificationBell({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.push(AppRouter.notificationsPath);
      },
      icon: Icon(
        Icons.notifications_none_outlined,
        color: color ?? AppColors.onSurfaceVariant,
        size: AppConstants.iconMedium,
      ),
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      splashRadius: 24,
    );
  }
}
