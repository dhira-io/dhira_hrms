import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final bool centerTitle;

  const CommonAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.onBack,
    this.backgroundColor,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasSubtitle = subtitle != null && subtitle!.isNotEmpty;
    final resolvedCenterTitle = hasSubtitle ? false : centerTitle;

    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.of(context).surface,
      elevation: 0,
      centerTitle: resolvedCenterTitle,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.of(context).onSurface,
          size: 20,
        ),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: resolvedCenterTitle
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyle.h3.copyWith(
              color: AppColors.of(context).onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (hasSubtitle) ...[
            SizedBox(height: 2.h),
            Text(
              subtitle!,
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.of(context).textSecondary,
              ),
            ),
          ],
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    subtitle != null && subtitle!.isNotEmpty ? 64.h : kToolbarHeight,
  );
}
