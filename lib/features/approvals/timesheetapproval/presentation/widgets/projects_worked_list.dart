import 'package:dhira_hrms/core/theme/app_colors.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.slate500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: projects.toSet().map((p) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Text(
              p ?? "—",
              style: AppTextStyle.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}
