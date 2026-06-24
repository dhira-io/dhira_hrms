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
    return AppBar(
      backgroundColor:
          backgroundColor ?? AppColors.of(context).surfaceContainerLowest,
      elevation: 0,
      centerTitle: subtitle == null,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.of(context).textPrimary,
          size: 20,
        ),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: subtitle != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyle.h3.copyWith(
                    color: AppColors.of(context).textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle!,
                  style: AppTextStyle.bodyMediumOne.copyWith(
                    color: AppColors.of(context).textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          : Text(
              title,
              style: AppTextStyle.h3.copyWith(
                color: AppColors.of(context).textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    subtitle != null && subtitle!.isNotEmpty ? 58.h : kToolbarHeight,
  );
}
