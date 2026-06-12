import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import 'notification_item_shimmer.dart';

class NotificationToggleItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onToggle;
  final bool isLoading;
  final bool isDisabled;

  const NotificationToggleItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.onToggle,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const NotificationItemShimmer();
    }

    return Padding(
      padding:       EdgeInsets.symmetric(vertical: 12.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.of(context).onSurface,
                  ),
                ),
                      SizedBox(height: 4.h),
                Text(
                  description,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).onSurfaceVariant,
                    height: 1.4.h,
                  ),
                ),
              ],
            ),
          ),
                SizedBox(width: 16.w),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: value,
              onChanged: isDisabled ? null : onToggle,
              activeTrackColor: AppColors.of(context).primary,
              inactiveTrackColor: AppColors.of(context).surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}
