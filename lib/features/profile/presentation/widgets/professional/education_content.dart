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
import '../../../data/constants/profile_api_constants.dart';
import 'common_form_dialog.dart';

class EducationContent extends StatelessWidget {
  final List<ResumeEducationEntity> education;

  const EducationContent({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    if (education.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(AppLocalizations.of(context)!.noEducationAddedYet),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: education.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final edu = education[index];
        return _EducationItem(
          edu: edu,
          onEdit: () => _showEditEducationDialog(context, edu),
        );
      },
    );
  }

  void _showEditEducationDialog(
    BuildContext context,
    ResumeEducationEntity edu,
  ) {
    final degC = TextEditingController(text: edu.qualification);
    final schoolC = TextEditingController(text: edu.schoolUniv);

    int currentYear = DateTime.now().year;
    final years = List.generate(
      currentYear - 1949,
      (index) => (currentYear - index).toString(),
    );
    String periodSelected = years.contains(edu.yearOfPassing)
        ? edu.yearOfPassing
        : currentYear.toString();

    final levels = ProfileApiConstants.educationLevels;
    String level = levels.contains(edu.level) ? edu.level : "Graduate";

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              bloc: context.read<ProfileBloc>(),
              title: AppLocalizations.of(context)!.editEducation,
              fields: [
                DropdownButtonFormField<String>(
                  value: level,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.qualificationLevel,
                  ),
                  items: levels.map((val) {
                    String label = val;
                    if (val == "High School / Secondary") {
                      label = AppLocalizations.of(context)!.eduHighSchool;
                    } else if (val == "Diploma") {
                      label = AppLocalizations.of(context)!.eduDiploma;
                    } else if (val == "Under Graduate") {
                      label = AppLocalizations.of(context)!.eduUnderGraduate;
                    } else if (val == "Graduate") {
                      label = AppLocalizations.of(context)!.eduGraduate;
                    } else if (val == "Post Graduate") {
                      label = AppLocalizations.of(context)!.eduPostGraduate;
                    } else if (val == "Doctorate / PhD") {
                      label = AppLocalizations.of(context)!.eduDoctorate;
                    } else if (val == "Professional Certification") {
                      label = AppLocalizations.of(context)!.eduProfessionalCert;
                    } else if (val == "Other") {
                      label = AppLocalizations.of(context)!.eduOther;
                    }

                    return DropdownMenuItem(value: val, child: Text(label));
                  }).toList(),
                  onChanged: (val) => setDialogState(() => level = val!),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: degC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.degreeCourse,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: schoolC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.schoolUniversity,
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: periodSelected,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.yearOfPassing,
                  ),
                  items: years
                      .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                      .toList(),
                  onChanged: (val) =>
                      setDialogState(() => periodSelected = val!),
                ),
              ],
              onSave: () {
                if (degC.text.isNotEmpty && schoolC.text.isNotEmpty) {
                  final data = {
                    "qualification": degC.text,
                    "school_univ": schoolC.text,
                    "year_of_passing": periodSelected,
                    "level": level,
                  };
                  context.read<ProfileBloc>().add(
                    ProfileEvent.resumeRowUpsertRequested(
                      section: "education",
                      rowDataJson: jsonEncode(data),
                      rowName: edu.name,
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

class _EducationItem extends StatelessWidget {
  final ResumeEducationEntity edu;
  final VoidCallback onEdit;

  const _EducationItem({required this.edu, required this.onEdit});

  String _getLocalizedLevel(BuildContext context, String val) {
    if (val == "High School / Secondary")
      return AppLocalizations.of(context)!.eduHighSchool;
    if (val == "Diploma") return AppLocalizations.of(context)!.eduDiploma;
    if (val == "Under Graduate")
      return AppLocalizations.of(context)!.eduUnderGraduate;
    if (val == "Graduate") return AppLocalizations.of(context)!.eduGraduate;
    if (val == "Post Graduate")
      return AppLocalizations.of(context)!.eduPostGraduate;
    if (val == "Doctorate / PhD")
      return AppLocalizations.of(context)!.eduDoctorate;
    if (val == "Professional Certification")
      return AppLocalizations.of(context)!.eduProfessionalCert;
    if (val == "Other") return AppLocalizations.of(context)!.eduOther;
    return val;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                edu.qualification,
                style: AppTextStyle.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                edu.schoolUniv,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                edu.yearOfPassing,
                style: AppTextStyle.bodySmall.copyWith(
                  color: isDark ? colors.slate400 : colors.slate500,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.of(context).slate800
                      : AppColors.of(context).slate100,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  _getLocalizedLevel(context, edu.level),
                  style: AppTextStyle.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.of(context).slate300
                        : AppColors.of(context).slate700,
                  ),
                ),
              ),
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
                    section: "education",
                    rowName: edu.name,
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
    );
  }

  void _showEditEducationDialog(
    BuildContext context,
    ResumeEducationEntity edu,
  ) {
    final degC = TextEditingController(text: edu.qualification);
    final schoolC = TextEditingController(text: edu.schoolUniv);

    int currentYear = DateTime.now().year;
    final years = List.generate(
      currentYear - 1949,
      (index) => (currentYear - index).toString(),
    );
    String periodSelected = years.contains(edu.yearOfPassing)
        ? edu.yearOfPassing
        : currentYear.toString();

    final levels = ProfileApiConstants.educationLevels;
    String level = levels.contains(edu.level) ? edu.level : "Graduate";

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              bloc: context.read<ProfileBloc>(),
              title: AppLocalizations.of(context)!.editEducation,
              fields: [
                TextField(
                  controller: degC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.degreeCourse,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: schoolC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.schoolUniversity,
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: periodSelected,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.yearOfPassing,
                  ),
                  items: years
                      .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                      .toList(),
                  onChanged: (val) =>
                      setDialogState(() => periodSelected = val!),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: level,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.qualificationLevel,
                  ),
                  items: levels.map((val) {
                    String label = val;
                    if (val == "High School / Secondary") {
                      label = AppLocalizations.of(context)!.eduHighSchool;
                    } else if (val == "Diploma") {
                      label = AppLocalizations.of(context)!.eduDiploma;
                    } else if (val == "Under Graduate") {
                      label = AppLocalizations.of(context)!.eduUnderGraduate;
                    } else if (val == "Graduate") {
                      label = AppLocalizations.of(context)!.eduGraduate;
                    } else if (val == "Post Graduate") {
                      label = AppLocalizations.of(context)!.eduPostGraduate;
                    } else if (val == "Doctorate / PhD") {
                      label = AppLocalizations.of(context)!.eduDoctorate;
                    } else if (val == "Professional Certification") {
                      label = AppLocalizations.of(context)!.eduProfessionalCert;
                    } else if (val == "Other") {
                      label = AppLocalizations.of(context)!.eduOther;
                    }
                    return DropdownMenuItem(value: val, child: Text(label));
                  }).toList(),
                  onChanged: (val) => setDialogState(() => level = val!),
                ),
              ],
              onSave: () {
                if (degC.text.isNotEmpty && schoolC.text.isNotEmpty) {
                  final data = {
                    "qualification": degC.text,
                    "school_univ": schoolC.text,
                    "year_of_passing": periodSelected,
                    "level": level,
                  };
                  context.read<ProfileBloc>().add(
                    ProfileEvent.resumeRowUpsertRequested(
                      section: "education",
                      rowDataJson: jsonEncode(data),
                      rowName: edu.name,
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
