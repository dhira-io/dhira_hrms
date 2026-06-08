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

  void _showEditEducationDialog(BuildContext context, ResumeEducationEntity edu) {
    final degC = TextEditingController(text: edu.qualification);
    final schoolC = TextEditingController(text: edu.schoolUniv);
    
    int currentYear = DateTime.now().year;
    final years = List.generate(currentYear - 1949, (index) => (currentYear - index).toString());
    String periodSelected = years.contains(edu.yearOfPassing) ? edu.yearOfPassing : currentYear.toString();

    final levels = [
      "High School / Secondary",
      "Diploma",
      "Under Graduate",
      "Graduate",
      "Post Graduate",
      "Doctorate / PhD",
      "Professional Certification",
      "Other"
    ];
    String level = levels.contains(edu.level) ? edu.level : "Graduate";

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: AppLocalizations.of(context)!.editEducation,
              fields: [
                TextField(
                  controller: degC,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.degreeCourse),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: schoolC,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.schoolUniversity),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: periodSelected,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.yearOfPassing),
                  items: years.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                  onChanged: (val) => setDialogState(() => periodSelected = val!),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: level,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.level),
                  items: levels.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
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

class _EducationItem extends StatelessWidget {
  final ResumeEducationEntity edu;
  final VoidCallback onEdit;

  const _EducationItem({
    required this.edu,
    required this.onEdit,
  });

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
                style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              Text(
                edu.schoolUniv,
                style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4.h),
              Text(
                edu.yearOfPassing,
                style: AppTextStyle.bodySmall.copyWith(
                  color: isDark ? colors.slate400 : colors.slate500,
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

  void _showEditEducationDialog(BuildContext context, ResumeEducationEntity edu) {
    final degC = TextEditingController(text: edu.qualification);
    final schoolC = TextEditingController(text: edu.schoolUniv);
    
    int currentYear = DateTime.now().year;
    final years = List.generate(currentYear - 1949, (index) => (currentYear - index).toString());
    String periodSelected = years.contains(edu.yearOfPassing) ? edu.yearOfPassing : currentYear.toString();

    final levels = [
      "High School / Secondary",
      "Diploma",
      "Under Graduate",
      "Graduate",
      "Post Graduate",
      "Doctorate / PhD",
      "Professional Certification",
      "Other"
    ];
    String level = levels.contains(edu.level) ? edu.level : "Graduate";

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: AppLocalizations.of(context)!.editEducation,
              fields: [
                TextField(
                  controller: degC,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.degreeCourse),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: schoolC,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.schoolUniversity),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: periodSelected,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.yearOfPassing),
                  items: years.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                  onChanged: (val) => setDialogState(() => periodSelected = val!),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: level,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.level),
                  items: levels.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
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
