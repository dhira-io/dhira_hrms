import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import 'notification_item_shimmer.dart';

class NotificationsLoadingWidget extends StatelessWidget {
  const NotificationsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p16, 
        vertical: AppConstants.p24,
      ),
      itemCount: 8,
      itemBuilder: (context, index) => const NotificationItemShimmer(),
    );
  }
}
