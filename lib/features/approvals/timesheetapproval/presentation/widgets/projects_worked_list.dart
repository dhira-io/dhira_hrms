import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ProjectsWorkedList extends StatelessWidget {
  final String label;
  final List<String?> projects;

  const ProjectsWorkedList({
    super.key,
    required this.label,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: colors.slate500,
          ),
        ),
              SizedBox(height: 8.h),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: projects
              .toSet()
              .map(
                (p) => Container(
                  padding:       EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: colors.slate200),
                  ),
                  child: Text(
                    p ?? "—",
                    style: AppTextStyle.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
