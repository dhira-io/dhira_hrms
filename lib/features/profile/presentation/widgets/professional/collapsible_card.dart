import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';

class CollapsibleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget? action;
  final int? count;

  const CollapsibleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    required this.isExpanded,
    required this.onToggle,
    this.action,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.of(context).surface
            : AppColors.of(context).white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: isExpanded
                ? BorderRadius.vertical(top: Radius.circular(16.r))
                : BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.of(
                        context,
                      ).primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      icon,
                      color: AppColors.of(context).primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: AppTextStyle.h3.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (count != null && count! > 0) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.of(context).slate800
                                  : AppColors.of(context).slate100,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              count.toString(),
                              style: AppTextStyle.bodySmall.copyWith(
                                color: isDark
                                    ? AppColors.of(context).slate300
                                    : AppColors.of(context).slate700,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (action != null) ...[action!, SizedBox(width: 8.w)],
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: isDark
                        ? AppColors.of(context).slate400
                        : AppColors.of(context).slate500,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: child,
            ),
        ],
      ),
    );
  }
}

class HeaderActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const HeaderActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.add, size: 16.sp, color: AppColors.of(context).primary),
      label: Text(
        label,
        style: AppTextStyle.bodyMedium.copyWith(
          color: AppColors.of(context).primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
