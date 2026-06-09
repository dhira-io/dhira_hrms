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
import 'common_form_bottom_sheet.dart';
import '../../../../../core/widgets/common_alert_dialog.dart';

class _SkillDataKeys {
  static const String skill = "skill";
  static const String proficiency = "proficiency";
  static const String yearsOfExperience = "years_of_experience";
  static const String customSubSkill = "custom_sub_skill";
  static const String subSkill = "sub_skill";
}

class SkillsContent extends StatelessWidget {
  final List<ResumeSkillEntity> skills;

  const SkillsContent({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (skills.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(l10n.noSkillsAddedYet),
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
  final l10n = AppLocalizations.of(context)!;
  final skillController = TextEditingController(text: skill.skill);
  String level = skill.proficiency.isNotEmpty ? skill.proficiency : l10n.expert;
  String exp = skill.yearsOfExperience.toString();

  bool isLoadingSubSkills = true;
  List<dynamic> availableSubSkills = [];
  List<String> selectedSubSkills = skill.subSkills
      .map((e) => (e.subSkill.isNotEmpty ? e.subSkill : e.name).trim())
      .toList();

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? AppColors.of(context).surface
        : AppColors.of(context).white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return CommonFormBottomSheet(
            title: l10n.editSkill,
            fields: [
              TextField(
                controller: skillController,
                readOnly: true,
                decoration: InputDecoration(labelText: l10n.skillName),
              ),
              SizedBox(height: 14.h),
              Text(
                l10n.proficiency,
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textSecondary),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [l10n.beginner, l10n.intermediate, l10n.advanced, l10n.expert]
                    .map((val) {
                  final isSelected = level == val;
                  return ChoiceChip(
                    label: Text(val),
                    selected: isSelected,
                    showCheckmark: isSelected,
                    selectedColor: AppColors.of(context).primary.withValues(alpha: 0.1),
                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.of(context).surface
                        : AppColors.of(context).white,
                    labelStyle: AppTextStyle.bodyMedium.copyWith(
                      color: isSelected ? AppColors.of(context).primary : AppColors.of(context).textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide(color: isSelected ? AppColors.of(context).primary.withValues(alpha: 0.3) : AppColors.of(context).border),
                    ),
                    checkmarkColor: AppColors.of(context).primary,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => level = val);
                      }
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 14.h),
              TextFormField(
                initialValue: exp,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: l10n.experienceYears),
                onChanged: (val) => setState(() => exp = val),
              ),
              if (isLoadingSubSkills) ...[
                SizedBox(height: 14.h),
                const Center(child: CircularProgressIndicator()),
              ] else ...[
                SizedBox(height: 14.h),
                Text(
                  l10n.subSkills,
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textSecondary),
                ),
                SizedBox(height: 8.h),
                if (availableSubSkills.isNotEmpty)
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: availableSubSkills.map((subSkill) {
                      final isSelected = selectedSubSkills.contains(subSkill.name.trim());
                      return FilterChip(
                        label: Text(subSkill.name),
                        selected: isSelected,
                        showCheckmark: isSelected,
                        selectedColor: AppColors.of(context).primary.withValues(alpha: 0.1),
                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.of(context).surface
                            : AppColors.of(context).white,
                        labelStyle: AppTextStyle.bodyMedium.copyWith(
                          color: isSelected ? AppColors.of(context).primary : AppColors.of(context).textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          side: BorderSide(color: isSelected ? AppColors.of(context).primary.withValues(alpha: 0.3) : AppColors.of(context).border),
                        ),
                        checkmarkColor: AppColors.of(context).primary,
                        onSelected: (selected) {
                          setState(() {
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark ? AppColors.of(context).surface : AppColors.of(context).slate50,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? AppColors.of(context).border : AppColors.of(context).slate200),
                    ),
                    child: Text(
                      l10n.noSubskillsConfigured,
                      style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textSecondary.withValues(alpha: 0.7)),
                    ),
                  ),
              ],
            ],
            onSave: () {
              if (skillController.text.isNotEmpty) {
                final data = {
                  _SkillDataKeys.skill: skillController.text,
                  _SkillDataKeys.proficiency: level,
                  _SkillDataKeys.yearsOfExperience: exp,
                  if (selectedSubSkills.isNotEmpty)
                    _SkillDataKeys.customSubSkill: selectedSubSkills.map((e) => {_SkillDataKeys.subSkill: e}).toList(),
                };
                context.read<ProfileBloc>().add(ProfileEvent.resumeRowUpsertRequested(
                  section: "skills",
                  rowDataJson: jsonEncode(data),
                  rowName: skill.name,
                ));
              }
            },
            bloc: context.read<ProfileBloc>(),
          );
        }
      );
    });
  }
}

class _SkillItem extends StatelessWidget {
  final ResumeSkillEntity skill;
  final VoidCallback onEdit;

  const _SkillItem({required this.skill, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

    final List<Map<String, Color>> chipColors = [
      {
        'bg': colors.primary.withValues(alpha: 0.1),
        'border': colors.primary.withValues(alpha: 0.3),
        'text': colors.primary,
      },
      {
        'bg': colors.success.withValues(alpha: 0.1),
        'border': colors.success.withValues(alpha: 0.3),
        'text': colors.success,
      },
      {
        'bg': colors.warning.withValues(alpha: 0.1),
        'border': colors.warning.withValues(alpha: 0.3),
        'text': colors.warning,
      },
      {
        'bg': colors.error.withValues(alpha: 0.1),
        'border': colors.error.withValues(alpha: 0.3),
        'text': colors.error,
      },
    ];

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
                        l10n.yearsExp(skill.yearsOfExperience.toString()),
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
                    CommonAlertDialog.show(
                      context: context,
                      title: l10n.delete,
                      content: l10n.deleteConfirmation,
                      confirmText: l10n.delete,
                      cancelText: l10n.cancel,
                      confirmButtonColor: AppColors.of(context).error,
                      onConfirm: () {
                        context.read<ProfileBloc>().add(
                          ProfileEvent.resumeRowDeleteRequested(
                            section: "skills",
                            rowName: skill.name,
                          ),
                        );
                      },
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
