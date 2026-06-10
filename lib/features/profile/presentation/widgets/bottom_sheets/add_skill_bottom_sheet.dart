import 'dart:convert';

import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/search_skills_usecase.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/get_sub_skills_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';
import 'package:dhira_hrms/features/profile/presentation/widgets/professional/common_form_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAddSkillDialog(BuildContext context) async {
  final skillController = TextEditingController();
  String level = AppLocalizations.of(context)!.expert;
  String exp = "1.0";
  bool isValidSkill = false;
  List<dynamic> availableSubSkills = [];
  List<String> selectedSubSkills = [];
  bool isLoadingSubSkills = false;
  final formKey = GlobalKey<FormState>();

  CommonFormBottomSheet.show(
    context: context,
    formKey: formKey,
    bloc: context.read<ProfileBloc>(),
    title: AppLocalizations.of(context)!.addNewSkill,
    fields: [
      StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setDialogState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return [
                      AppLocalizations.of(context)!.accessibilityUx,
                      AppLocalizations.of(context)!.agenticAi,
                      AppLocalizations.of(context)!.analytics,
                      AppLocalizations.of(context)!.animationGameLoops,
                      AppLocalizations.of(context)!.backendDevelopment,
                      AppLocalizations.of(context)!.cloudComputing,
                      AppLocalizations.of(context)!.dataTransformationModeling,
                      AppLocalizations.of(context)!.frontendDevelopment,
                      AppLocalizations.of(context)!.machineLearning,
                      AppLocalizations.of(context)!.mobileDevelopment,
                    ];
                  }
                  final useCase = Get.find<SearchSkillsUseCase>();
                  final result = await useCase(textEditingValue.text);
                  return result.fold(
                    (failure) => const Iterable<String>.empty(),
                    (skills) => skills,
                  );
                },
                onSelected: (String selection) async {
                  setDialogState(() {
                    skillController.text = selection;
                    isValidSkill = true;
                    isLoadingSubSkills = true;
                    availableSubSkills = [];
                    selectedSubSkills = [];
                  });

                  final subSkillsUseCase = Get.find<GetSubSkillsUseCase>();
                  final result = await subSkillsUseCase(selection);

                  result.fold(
                    (failure) {
                      setDialogState(() {
                        isLoadingSubSkills = false;
                      });
                    },
                    (subSkills) {
                      setDialogState(() {
                        availableSubSkills = subSkills;
                        isLoadingSubSkills = false;
                      });
                    },
                  );
                },
                optionsViewBuilder: (context, onSelected, options) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      color: isDark ? AppColors.of(context).surface : AppColors.of(context).white,
                      borderRadius: BorderRadius.circular(8.r),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300, maxHeight: 200.h),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return InkWell(
                              onTap: () => onSelected(option),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                child: Text(option, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textPrimary)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  controller.addListener(() {
                    if (controller.text != skillController.text) {
                      setDialogState(() {
                        skillController.text = controller.text;
                        isValidSkill = false;
                        availableSubSkills = [];
                        selectedSubSkills = [];
                      });
                    }
                  });
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.skillName,
                      hintText: AppLocalizations.of(context)!.startTypingToSearchSkills,
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) return AppLocalizations.of(context)!.skillCannotBeEmpty;
                      if (!isValidSkill) return AppLocalizations.of(context)!.pleaseSelectAValidSkillFromTheList;
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  );
                },
              ),
              SizedBox(height: 14.h),
              Text(
                AppLocalizations.of(context)!.proficiency,
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textSecondary),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  AppLocalizations.of(context)!.beginner,
                  AppLocalizations.of(context)!.intermediate,
                  AppLocalizations.of(context)!.advanced,
                  AppLocalizations.of(context)!.expert,
                ].map((val) {
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
                        setDialogState(() => level = val);
                      }
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 14.h),
              TextFormField(
                initialValue: exp,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.experienceYears),
                onChanged: (val) => setDialogState(() => exp = val),
              ),
              if (isLoadingSubSkills) ...[
                SizedBox(height: 14.h),
                const Center(child: CircularProgressIndicator()),
              ] else if (isValidSkill) ...[
                SizedBox(height: 14.h),
                Text(
                  AppLocalizations.of(context)!.subSkills,
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark ? AppColors.of(context).surface : AppColors.of(context).slate50,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? AppColors.of(context).border : AppColors.of(context).slate200),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.noSubskillsConfigured,
                      style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textSecondary.withValues(alpha: 0.7)),
                    ),
                  ),
              ],
            ],
          );
        },
      ),
    ],
    onSave: () {
      if (formKey.currentState!.validate()) {
        final data = {
          ProfileApiConstants.keySkill: skillController.text,
          ProfileApiConstants.keyProficiency: level,
          ProfileApiConstants.keyYearsOfExperience: exp,
          if (selectedSubSkills.isNotEmpty)
            ProfileApiConstants.keyCustomSubSkill: selectedSubSkills.map((e) => {ProfileApiConstants.keySubSkill: e}).toList(),
        };
        context.read<ProfileBloc>().add(
          ProfileEvent.resumeRowUpsertRequested(
            section: ProfileApiConstants.sectionSkills,
            rowDataJson: jsonEncode(data),
          ),
        );
      } else if (!isValidSkill) {
        ToastUtils.showError(AppLocalizations.of(context)!.pleaseSelectASkillFromTheDropdownList);
      }
    },
  );
}
