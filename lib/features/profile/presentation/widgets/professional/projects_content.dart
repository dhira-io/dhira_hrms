import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../l10n/app_localizations.dart';
import 'common_form_dialog.dart';

class ProjectsContent extends StatelessWidget {
  final List<ResumeConsultingExperienceEntity> projects;

  const ProjectsContent({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text("No consulting projects added yet."),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final proj = projects[index];
        return _buildProjectItem(context, proj);
      },
    );
  }

  Widget _buildProjectItem(BuildContext context, ResumeConsultingExperienceEntity proj) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proj.project,
                    style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${proj.clientName} • ${proj.parentCompany}",
                    style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit_outlined, size: 20.sp),
                  onPressed: () => _showEditProjectDialog(context, proj),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: isDark ? AppColors.of(context).slate400 : AppColors.of(context).slate500,
                ),
                SizedBox(width: 12.w),
                IconButton(
                  icon: Icon(Icons.delete_outline, size: 20.sp),
                  onPressed: () {
                    context.read<ProfileBloc>().add(
                          ProfileEvent.resumeRowDeleteRequested(
                            section: "consulting_experience",
                            rowName: proj.name,
                          ),
                        );
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: isDark ? AppColors.of(context).slate400 : AppColors.of(context).slate500,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          "Duration: ${proj.duration}",
          style: AppTextStyle.bodySmall.copyWith(
            color: isDark ? AppColors.of(context).slate400 : AppColors.of(context).slate500,
          ),
        ),
        if (proj.projectOverview.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Text(
            "Project Overview:",
            style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            proj.projectOverview,
            style: AppTextStyle.bodyMedium.copyWith(
              color: isDark ? AppColors.of(context).slate300 : AppColors.of(context).slate600,
              height: 1.5,
            ),
          ),
        ],
        if (proj.toolsAndTechnologies.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Text(
            "Tools & Technologies:",
            style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            proj.toolsAndTechnologies,
            style: AppTextStyle.bodyMedium.copyWith(
              color: isDark ? AppColors.of(context).slate300 : AppColors.of(context).slate600,
              height: 1.5,
            ),
          ),
        ]
      ],
    );
  }

  void _showEditProjectDialog(BuildContext context, ResumeConsultingExperienceEntity proj) {
    final parentC = TextEditingController(text: proj.parentCompany);
    final clientC = TextEditingController(text: proj.clientName);
    final projectC = TextEditingController(text: proj.project);
    final durationC = TextEditingController(text: proj.duration);
    final overviewC = TextEditingController(text: proj.projectOverview);
    final impactC = TextEditingController(text: proj.businessImpact);
    final toolsC = TextEditingController(text: proj.toolsAndTechnologies);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Edit Consulting Project",
              fields: [
                TextField(
                  controller: projectC,
                  decoration: const InputDecoration(labelText: "Project Name"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: clientC,
                  decoration: const InputDecoration(labelText: "Client Name"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: parentC,
                  decoration: const InputDecoration(labelText: "Parent Company"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: durationC,
                  decoration: const InputDecoration(labelText: "Duration (e.g. 2 months)"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: overviewC,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Project Overview"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: impactC,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Business Impact"),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: toolsC,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Tools & Technologies"),
                ),
              ],
              onSave: () {
                if (projectC.text.isNotEmpty) {
                  final data = {
                    "parent_company": parentC.text,
                    "client_name": clientC.text,
                    "project": projectC.text,
                    "duration": durationC.text,
                    "project_overview": overviewC.text,
                    "business_impact": impactC.text,
                    "tools_and_technologies": toolsC.text,
                  };
                  context.read<ProfileBloc>().add(
                        ProfileEvent.resumeRowUpsertRequested(
                          section: "consulting_experience",
                          rowDataJson: jsonEncode(data),
                          rowName: proj.name,
                        ),
                      );
                  Navigator.pop(dialogContext);
                }
              },
            );
          },
        );
      },
    );
  }
}
