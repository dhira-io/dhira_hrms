import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'common_form_dialog.dart';

class ExperienceContent extends StatelessWidget {
  final List<ResumeWorkExperienceEntity> experiences;

  const ExperienceContent({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    if (experiences.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(AppLocalizations.of(context)!.noExperienceAddedYet),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final exp = experiences[index];
        return _buildExperienceItem(context, exp);
      },
    );
  }

  Widget _buildExperienceItem(BuildContext context, ResumeWorkExperienceEntity exp) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final period = exp.customCurrentlyWorking 
        ? "${exp.customFromDate} - Present" 
        : "${exp.customFromDate} - ${exp.customToDate}";

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
                    exp.designation,
                    style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${exp.companyName} • ${exp.customEmploymentType}",
                    style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit_outlined, size: 20.sp),
                  onPressed: () => _showEditExperienceDialog(context, exp),
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
                            section: "work_experience",
                            rowName: exp.name,
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
          period,
          style: AppTextStyle.bodySmall.copyWith(
            color: isDark ? AppColors.of(context).slate400 : AppColors.of(context).slate500,
          ),
        ),
        if (exp.customKeyResponsibilities.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Text(
            "Responsibilities:",
            style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            exp.customKeyResponsibilities,
            style: AppTextStyle.bodyMedium.copyWith(
              color: isDark ? AppColors.of(context).slate300 : AppColors.of(context).slate600,
              height: 1.5,
            ),
          ),
        ],
        if (exp.customKeyAchievements.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Text(
            "Achievements:",
            style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            exp.customKeyAchievements,
            style: AppTextStyle.bodyMedium.copyWith(
              color: isDark ? AppColors.of(context).slate300 : AppColors.of(context).slate600,
              height: 1.5,
            ),
          ),
        ]
      ],
    );
  }

  void _showEditExperienceDialog(BuildContext context, ResumeWorkExperienceEntity exp) {
    final titleC = TextEditingController(text: exp.designation);
    final companyC = TextEditingController(text: exp.companyName);
    final fromC = TextEditingController(text: exp.customFromDate);
    final toC = TextEditingController(text: exp.customToDate);
    final respC = TextEditingController(text: exp.customKeyResponsibilities);
    final achC = TextEditingController(text: exp.customKeyAchievements);
    String type = exp.customEmploymentType.isNotEmpty ? exp.customEmploymentType : AppLocalizations.of(context)!.fullTime;
    bool currentlyWorking = exp.customCurrentlyWorking;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: AppLocalizations.of(context)!.editWorkExperience,
              fields: [
                TextField(
                  controller: titleC,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.jobTitle),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: companyC,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.company),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: fromC,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.fromDateYyyymmdd),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: toC,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.toDateYyyymmdd),
                  enabled: !currentlyWorking,
                ),
                SizedBox(height: 8.h),
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context)!.currentlyWorkingHere, style: AppTextStyle.bodyMedium),
                  value: currentlyWorking,
                  onChanged: (val) {
                    setDialogState(() {
                      currentlyWorking = val ?? false;
                      if (currentlyWorking) toC.clear();
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  initialValue: [AppLocalizations.of(context)!.fullTime, AppLocalizations.of(context)!.partTime, AppLocalizations.of(context)!.contract, AppLocalizations.of(context)!.internship].contains(type) ? type : AppLocalizations.of(context)!.fullTime,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.employmentType),
                  items: [AppLocalizations.of(context)!.fullTime, AppLocalizations.of(context)!.partTime, AppLocalizations.of(context)!.contract, AppLocalizations.of(context)!.internship]
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => type = val!),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: respC,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.responsibilities),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: achC,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.achievements),
                ),
              ],
              onSave: () {
                if (titleC.text.isNotEmpty && companyC.text.isNotEmpty) {
                  final data = {
                    "designation": titleC.text,
                    "company_name": companyC.text,
                    "custom_from_date": fromC.text,
                    "custom_to_date": currentlyWorking ? "" : toC.text,
                    "custom_currently_working": currentlyWorking,
                    "custom_employment_type": type,
                    "custom_key_responsibilities": respC.text,
                    "custom_key_achievements": achC.text,
                  };
                  context.read<ProfileBloc>().add(
                        ProfileEvent.resumeRowUpsertRequested(
                          section: "work_experience",
                          rowDataJson: jsonEncode(data),
                          rowName: exp.name,
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
