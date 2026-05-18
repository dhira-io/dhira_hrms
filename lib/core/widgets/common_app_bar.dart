import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color? backgroundColor;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBack,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppColors.themeModeNotifier,
      builder: (context, _, __) {
        return AppBar(
          backgroundColor: backgroundColor ?? AppColors.surface,
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: AppColors.onSurface, size: 20),
            onPressed: onBack ?? () => Navigator.pop(context),
          ),
          title: Text(
            title,
            style: AppTextStyle.h3.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: actions,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
