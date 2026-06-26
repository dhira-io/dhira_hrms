import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class ContentDisplayDialog extends StatelessWidget {
  final String title;
  final String content;

  const ContentDisplayDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return AlertDialog(
      backgroundColor: colors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.cancel_outlined,
              color: colors.textSecondary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: Text(
        content,
        style: AppTextStyle.bodyMedium.copyWith(
          color: colors.textPrimary,
        ),
      ),
    );
  }
}
