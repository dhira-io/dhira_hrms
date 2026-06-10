import 'package:dhira_hrms/core/widgets/common_empty_view.dart';
import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/get_sub_skills_usecase.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'package:get/get.dart';
import 'dialogs/common_form_bottom_sheet.dart';
import '../../../../../core/widgets/common_alert_dialog.dart';
import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';

class SkillsContent extends StatelessWidget {
  final List<ResumeSkillEntity> skills;

  const SkillsContent({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (skills.isEmpty) {
      return CommonEmptyView(
        message: l10n.noSkillsAddedYet,
        icon: Icons.psychology_outlined,
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
    List<SubSkillEntity> availableSubSkills = [];
    List<String> selectedSubSkills = skill.subSkills
        .map((e) => (e.subSkill.isNotEmpty ? e.subSkill : e.name).trim())
        .where((s) => s.isNotEmpty)
        .toList();

    String unescapeHtml(String str) {
      return str
          .replaceAll('&amp;', '&')
          .replaceAll('&quot;', '"')
          .replaceAll('&#39;', "'")
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>');
    }

    String normalize(String value) {
      return unescapeHtml(value.trim().toLowerCase());
    }
    // Start fetching subskills immediately
    final subSkillsUseCase = Get.find<GetSubSkillsUseCase>();
    StateSetter? dialogSetState;

    subSkillsUseCase(skill.skill).then((result) {
      result.fold(
            (failure) {
          isLoadingSubSkills = false;
          if (dialogSetState != null) {
            dialogSetState!(() {});
          }
        },
            (subSkills) {
          isLoadingSubSkills = false;
          availableSubSkills = subSkills;

          debugPrint('Pre-selected Sub Skills: $selectedSubSkills');
          if (dialogSetState != null) {
            dialogSetState!(() {});
          }
        },
      );
    });
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.of(context).surface
          : AppColors.of(context).white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            dialogSetState = setState;
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
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: List.generate(
                      4,
                      (index) => ShimmerLoading(
                        height: 32.h,
                        width: 60.w + (index * 15).w,
                        borderRadius: 16.r,
                      ),
                    ),
                  ),
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
                        final chipName = subSkill.name.trim();

                        final isSelected = selectedSubSkills.any(
                              (e) => normalize(e) == normalize(chipName),
                        );

                        return FilterChip(
                          label: Text(chipName),
                          selected: isSelected,
                          showCheckmark: isSelected,
                          selectedColor:
                          AppColors.of(context).primary.withValues(alpha: 0.1),
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
                                  ? AppColors.of(context)
                                  .primary
                                  .withValues(alpha: 0.3)
                                  : AppColors.of(context).border,
                            ),
                          ),
                          checkmarkColor: AppColors.of(context).primary,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                if (!selectedSubSkills.any(
                                      (e) =>
                                  normalize(e) ==
                                      normalize(chipName),
                                )) {
                                  selectedSubSkills.add(chipName);
                                }
                              } else {
                                selectedSubSkills.removeWhere(
                                      (e) =>
                                  normalize(e) ==
                                      normalize(chipName),
                                );
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
                    ProfileApiConstants.keySkill: skillController.text,
                    ProfileApiConstants.keyProficiency: level,
                    ProfileApiConstants.keyYearsOfExperience: exp,
                    if (selectedSubSkills.isNotEmpty)
                      ProfileApiConstants.keyCustomSubSkill: selectedSubSkills.map((e) => {ProfileApiConstants.keySubSkill: e}).toList(),
                  };
                  context.read<ProfileBloc>().add(ProfileEvent.resumeRowUpsertRequested(
                    section: ProfileApiConstants.sectionSkills,
                    rowDataJson: jsonEncode(data),
                    rowName: skill.name,
                  ));
                }
              },
              bloc: context.read<ProfileBloc>(),
            );
          },
        );
      },
    );
  }
}

class _SkillItem extends StatefulWidget {
  final ResumeSkillEntity skill;
  final VoidCallback onEdit;

  const _SkillItem({required this.skill, required this.onEdit});

  @override
  State<_SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<_SkillItem> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);
    final skill = widget.skill;

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

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (_isDeleting) {
          state.maybeWhen(
            uploading: (_, __) {},
            orElse: () {
              if (mounted) setState(() => _isDeleting = false);
            },
          );
        }
      },
      child: Column(
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
                    onPressed: _isDeleting ? null : widget.onEdit,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: isDark ? colors.slate400 : colors.slate500,
                  ),
                  SizedBox(width: 12.w),
                  if (_isDeleting)
                    SizedBox(
                      width: 20.sp,
                      height: 20.sp,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.of(context).error,
                      ),
                    )
                  else
                    IconButton(
                      icon: Icon(Icons.delete_outline, size: 20.sp),
                      onPressed: () {
                        CommonAlertDialog.show(
                          context: context,
                          title: l10n.delete,
                          content: l10n.deleteSkillConfirmation,
                          confirmText: l10n.delete,
                          cancelText: l10n.cancel,
                          confirmButtonColor: AppColors.of(context).error,
                          onConfirm: () {
                            setState(() => _isDeleting = true);
                            context.read<ProfileBloc>().add(
                              ProfileEvent.resumeRowDeleteRequested(
                                section: ProfileApiConstants.sectionSkills,
                                rowName: skill.name,
                              ),
                            );
                          },
                        );
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: Colors.red,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
