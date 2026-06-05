import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'common_form_dialog.dart';

class LanguagesContent extends StatelessWidget {
  final List<ResumeLanguageEntity> languages;

  const LanguagesContent({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    if (languages.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text("No languages added yet."),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: languages.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final lang = languages[index];
        return _buildLanguageItem(context, lang);
      },
    );
  }

  Widget _buildLanguageItem(BuildContext context, ResumeLanguageEntity lang) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.language,
                style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              Text(
                "S:${lang.speaking.isEmpty ? '-' : lang.speaking[0]} R:${lang.reading.isEmpty ? '-' : lang.reading[0]} W:${lang.writing.isEmpty ? '-' : lang.writing[0]}",
                style: AppTextStyle.bodyMedium.copyWith(
                  color: isDark ? AppColors.of(context).slate400 : AppColors.of(context).slate500,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 20.sp),
              onPressed: () => _showEditLanguageDialog(context, lang),
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
                        section: "languages",
                        rowName: lang.name,
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
    );
  }

  void _showEditLanguageDialog(BuildContext context, ResumeLanguageEntity lang) {
    final langC = TextEditingController(text: lang.language);
    String speaking = lang.speaking.isNotEmpty ? lang.speaking : "Full Professional";
    String reading = lang.reading.isNotEmpty ? lang.reading : "Full Professional";
    String writing = lang.writing.isNotEmpty ? lang.writing : "Full Professional";
    
    final proficiencies = [
      "Native or Bilingual",
      "Full Professional",
      "Professional Working",
      "Conversational",
      "Elementary",
      "Basic"
    ];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Edit Language",
              fields: [
                TextField(
                  controller: langC,
                  decoration: const InputDecoration(labelText: "Language"),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: proficiencies.contains(speaking) ? speaking : "Full Professional",
                  decoration: const InputDecoration(labelText: "Speaking Proficiency"),
                  items: proficiencies
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => speaking = val!),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: proficiencies.contains(reading) ? reading : "Full Professional",
                  decoration: const InputDecoration(labelText: "Reading Proficiency"),
                  items: proficiencies
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => reading = val!),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: proficiencies.contains(writing) ? writing : "Full Professional",
                  decoration: const InputDecoration(labelText: "Writing Proficiency"),
                  items: proficiencies
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => writing = val!),
                ),
              ],
              onSave: () {
                if (langC.text.isNotEmpty) {
                  final data = {
                    "language": langC.text,
                    "speaking": speaking,
                    "reading": reading,
                    "writing": writing,
                  };
                  context.read<ProfileBloc>().add(
                        ProfileEvent.resumeRowUpsertRequested(
                          section: "languages",
                          rowDataJson: jsonEncode(data),
                          rowName: lang.name,
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
