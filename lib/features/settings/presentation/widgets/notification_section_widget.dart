import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class NotificationSectionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const NotificationSectionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.of(context).primaryFixed,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.of(context).primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.of(context).onSurface,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.of(context).onSurface.withValues(alpha: 0.04),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
