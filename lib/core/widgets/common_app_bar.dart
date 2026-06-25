import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool centerTitle;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final bool showBackButton;

  const CommonAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.onBack,
    this.backgroundColor,
    this.centerTitle = false,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return AppBar(
      backgroundColor:
          backgroundColor ?? colors.surfaceContainerLowest,
      elevation: 0,
      centerTitle: subtitle == null,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: colors.textPrimary,
                size: 24,
              ),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,
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
                  style: AppTextStyle.bodySmall.copyWith(
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
