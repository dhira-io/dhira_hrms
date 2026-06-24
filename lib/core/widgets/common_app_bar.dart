import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color? backgroundColor;

  const CommonAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.onBack,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return AppBar(
      backgroundColor: backgroundColor ?? colors.surface,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: colors.onSurface,
          size: 24,
        ),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyle.h3.copyWith(
              color: colors.charcoal,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle != null && subtitle!.isNotEmpty)
            Text(
              subtitle!,
              style: AppTextStyle.bodySmall.copyWith(
                color: colors.black,
              ),
            ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
