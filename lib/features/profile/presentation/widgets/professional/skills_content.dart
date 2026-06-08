import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/get_sub_skills_usecase.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'package:get/get.dart';
import 'common_form_dialog.dart';

class SkillsContent extends StatelessWidget {
  final List<ResumeSkillEntity> skills;

  const SkillsContent({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(AppLocalizations.of(context)!.noSkillsAddedYet),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: skills.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final skill = skills[index];
        return _SkillItem(
          skill: skill,
          onEdit: () => _showEditSkillDialog(context, skill),
        );
      },
    );
  }

  void _showEditSkillDialog(BuildContext context, ResumeSkillEntity skill) {
    final skillController = TextEditingController(text: skill.skill);
    String level = skill.proficiency.isNotEmpty
        ? skill.proficiency
        : AppLocalizations.of(context)!.expert;
    String exp = skill.yearsOfExperience.toString();

    bool isLoadingSubSkills = true;
    List<dynamic> availableSubSkills = [];
    List<String> selectedSubSkills = skill.subSkills
        .map((e) => (e.subSkill.isNotEmpty ? e.subSkill : e.name).trim())
        .toList();
    bool isInit = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            if (!isInit) {
              isInit = true;
              Get.find<GetSubSkillsUseCase>().call(skill.skill).then((result) {
                if (ctx.mounted) {
                  setDialogState(() {
                    isLoadingSubSkills = false;
                    result.fold(
                      (failure) => availableSubSkills = [],
                      (subSkills) => availableSubSkills = subSkills,
                    );
                  });
                }
              });
            }

            return CommonFormDialog(
              bloc: context.read<ProfileBloc>(),
              title: AppLocalizations.of(context)!.editSkill,
              fields: [
                TextField(
                  controller: skillController,
                  readOnly:
                      true, // Typically skill name is read-only in edit mode
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.skillName,
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  AppLocalizations.of(context)!.proficiency,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children:
                      [
                        AppLocalizations.of(context)!.beginner,
                        AppLocalizations.of(context)!.intermediate,
                        "Advanced",
                        AppLocalizations.of(context)!.expert,
                      ].map((val) {
                        final isSelected = level == val;
                        return ChoiceChip(
                          label: Text(val),
                          selected: isSelected,
                          showCheckmark: isSelected,
                          selectedColor: AppColors.of(
                            context,
                          ).primary.withValues(alpha: 0.1),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                          labelStyle: AppTextStyle.bodyMedium.copyWith(
                            color: isSelected
                                ? AppColors.of(context).primary
                                : AppColors.of(context).textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.of(
                                      context,
                                    ).primary.withValues(alpha: 0.3)
                                  : AppColors.of(context).border,
                            ),
                          ),
                          checkmarkColor: AppColors.of(context).primary,
                          onSelected: (selected) {
                            if (selected) setDialogState(() => level = val);
                          },
                        );
                      }).toList(),
                ),
                SizedBox(height: 14.h),
                TextFormField(
                  initialValue: exp,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.experienceYears,
                  ),
                  onChanged: (val) => setDialogState(() => exp = val),
                ),
                if (isLoadingSubSkills) ...[
                  SizedBox(height: 14.h),
                  const Center(child: CircularProgressIndicator()),
                ] else ...[
                  SizedBox(height: 14.h),
                  Text(
                    AppLocalizations.of(context)!.subSkills,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  if (availableSubSkills.isNotEmpty)
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: availableSubSkills.map((subSkill) {
                        final isSelected = selectedSubSkills.contains(
                          subSkill.name.trim(),
                        );
                        return FilterChip(
                          label: Text(subSkill.name),
                          selected: isSelected,
                          showCheckmark: isSelected,
                          selectedColor: AppColors.of(
                            context,
                          ).primary.withValues(alpha: 0.1),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? AppColors.of(context).surface
                              : AppColors.of(context).white,
                          labelStyle: AppTextStyle.bodyMedium.copyWith(
                            color: isSelected
                                ? AppColors.of(context).primary
                                : AppColors.of(context).textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.of(
                                      context,
                                    ).primary.withValues(alpha: 0.3)
                                  : AppColors.of(context).border,
                            ),
                          ),
                          checkmarkColor: AppColors.of(context).primary,
                          onSelected: (selected) {
                            setDialogState(() {
                              if (selected) {
                                selectedSubSkills.add(subSkill.name.trim());
                              } else {
                                selectedSubSkills.remove(subSkill.name.trim());
                              }
                            });
                          },
                        );
                      }).toList(),
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.of(context).surface
                            : AppColors.of(context).slate50,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.of(context).border
                              : AppColors.of(context).slate200,
                        ),
                      ),
                      child: Text(
                        "No subskills configured.",
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppColors.of(
                            context,
                          ).textSecondary.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                ],
              ],
              onSave: () {
                if (skillController.text.isNotEmpty) {
                  final data = {
                    "skill": skillController.text,
                    "proficiency": level,
                    "years_of_experience": exp,
                    if (selectedSubSkills.isNotEmpty)
                      "custom_sub_skill": selectedSubSkills
                          .map((e) => {"sub_skill": e})
                          .toList(),
                  };
                  context.read<ProfileBloc>().add(
                    ProfileEvent.resumeRowUpsertRequested(
                      section: "skills",
                      rowDataJson: jsonEncode(data),
                      rowName: skill.name,
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}

class _SkillItem extends StatelessWidget {
  final ResumeSkillEntity skill;
  final VoidCallback onEdit;

  const _SkillItem({required this.skill, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

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
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: [
                      Text(
                        skill.skill,
                        style: AppTextStyle.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.of(
                            context,
                          ).warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          skill.proficiency,
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.of(context).warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "${skill.yearsOfExperience}y exp",
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: isDark ? colors.slate400 : colors.slate500,
                        ),
                      ),
                    ],
                  ),
                  if (skill.subSkills.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: skill.subSkills.asMap().entries.map((entry) {
                        final index = entry.key;
                        final subSkill = entry.value.subSkill.isNotEmpty
                            ? entry.value.subSkill
                            : entry.value.name;

                        if (subSkill.isEmpty) return const SizedBox();

                        final List<Map<String, Color>> chipColors = [
                          {
                            'bg': AppColors.of(
                              context,
                            ).primary.withValues(alpha: 0.1),
                            'border': AppColors.of(
                              context,
                            ).primary.withValues(alpha: 0.3),
                            'text': AppColors.of(context).primary,
                          },
                          {
                            'bg': AppColors.of(
                              context,
                            ).success.withValues(alpha: 0.1),
                            'border': AppColors.of(
                              context,
                            ).success.withValues(alpha: 0.3),
                            'text': AppColors.of(context).success,
                          },
                          {
                            'bg': AppColors.of(
                              context,
                            ).warning.withValues(alpha: 0.1),
                            'border': AppColors.of(
                              context,
                            ).warning.withValues(alpha: 0.3),
                            'text': AppColors.of(context).warning,
                          },
                          {
                            'bg': AppColors.of(
                              context,
                            ).error.withValues(alpha: 0.1),
                            'border': AppColors.of(
                              context,
                            ).error.withValues(alpha: 0.3),
                            'text': AppColors.of(context).error,
                          },
                        ];
                        final subColor = chipColors[index % chipColors.length];

                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: subColor['bg'],
                            border: Border.all(color: subColor['border']!),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            subSkill,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: isDark
                                  ? subColor['border']
                                  : subColor['text'],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit_outlined, size: 20.sp),
                  onPressed: onEdit,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: isDark ? colors.slate400 : colors.slate500,
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
                  color: isDark ? colors.slate400 : colors.slate500,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
