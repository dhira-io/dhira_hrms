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

class SkillsContent extends StatelessWidget {
  final List<ResumeSkillEntity> skills;

  const SkillsContent({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text("No skills added yet."),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: skills.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final skill = skills[index];
        return _buildSkillItem(context, skill);
      },
    );
  }

  Widget _buildSkillItem(BuildContext context, ResumeSkillEntity skill) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                skill.skill,
                style: AppTextStyle.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit_outlined, size: 20.sp),
                  onPressed: () => _showEditSkillDialog(context, skill),
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
                            section: "skills",
                            rowName: skill.name,
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
        SizedBox(height: 4.h),
        Text(
          "${skill.proficiency} • ${skill.yearsOfExperience}y exp",
          style: AppTextStyle.bodyMedium.copyWith(
            color: isDark ? AppColors.of(context).slate400 : AppColors.of(context).slate500,
          ),
        ),
      ],
    );
  }

  void _showEditSkillDialog(BuildContext context, ResumeSkillEntity skill) {
    final skillController = TextEditingController(text: skill.skill);
    String level = skill.proficiency.isNotEmpty ? skill.proficiency : "Expert";
    String exp = skill.yearsOfExperience.toString();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Edit Skill",
              fields: [
                TextField(
                  controller: skillController,
                  decoration: const InputDecoration(labelText: "Skill Name"),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: level,
                  decoration: const InputDecoration(labelText: "Level"),
                  items: ["Expert", "Advanced", "Intermediate", "Beginner"]
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => level = val!),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: ["1.0", "2.0", "3.0", "4.0", "5.0"].contains(exp) ? exp : "1.0",
                  decoration: const InputDecoration(labelText: "Experience"),
                  items: ["1.0", "2.0", "3.0", "4.0", "5.0"]
                      .map((val) => DropdownMenuItem(value: val, child: Text("$val exp")))
                      .toList(),
                  onChanged: (val) => setDialogState(() => exp = val!),
                ),
              ],
              onSave: () {
                if (skillController.text.isNotEmpty) {
                  final data = {
                    "skill": skillController.text,
                    "proficiency": level,
                    "years_of_experience": exp,
                  };
                  context.read<ProfileBloc>().add(
                        ProfileEvent.resumeRowUpsertRequested(
                          section: "skills",
                          rowDataJson: jsonEncode(data),
                          rowName: skill.name,
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
