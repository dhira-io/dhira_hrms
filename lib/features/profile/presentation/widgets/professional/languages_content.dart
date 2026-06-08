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
import '../../../../../core/utils/language_helper.dart';
import 'common_form_dialog.dart';

class LanguagesContent extends StatelessWidget {
  final List<ResumeLanguageEntity> languages;

  const LanguagesContent({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    if (languages.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(AppLocalizations.of(context)!.noLanguagesAddedYet),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: languages.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final lang = languages[index];
        return _LanguageItem(
          lang: lang,
          onEdit: () => _showEditLanguageDialog(context, lang),
        );
      },
    );
  }

  void _showEditLanguageDialog(
    BuildContext context,
    ResumeLanguageEntity lang,
  ) {
    final langC = TextEditingController(text: lang.language);
    String speaking = lang.speaking.isNotEmpty
        ? lang.speaking
        : AppLocalizations.of(context)!.basic;
    String reading = lang.reading.isNotEmpty
        ? lang.reading
        : AppLocalizations.of(context)!.basic;
    String writing = lang.writing.isNotEmpty
        ? lang.writing
        : AppLocalizations.of(context)!.basic;

    final proficiencies = [
      AppLocalizations.of(context)!.basic,
      AppLocalizations.of(context)!.conversational,
      AppLocalizations.of(context)!.fluent,
      AppLocalizations.of(context)!.native,
    ];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              bloc: context.read<ProfileBloc>(),
              title: AppLocalizations.of(context)!.editLanguage,
              fields: [
                FutureBuilder<List<String>>(
                  future: LanguageHelper.getLanguages(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final items = List<String>.from(snapshot.data!);
                    if (langC.text.isNotEmpty && !items.contains(langC.text)) {
                      items.insert(0, langC.text);
                    }

                    return DropdownButtonFormField<String>(
                      initialValue: langC.text.isNotEmpty ? langC.text : null,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.language,
                      ),
                      items: items
                          .map(
                            (val) =>
                                DropdownMenuItem(value: val, child: Text(val)),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          langC.text = val;
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: proficiencies.contains(speaking)
                      ? speaking
                      : proficiencies.first,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(
                      context,
                    )!.speakingProficiency,
                  ),
                  items: proficiencies
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
                      .toList(),
                  onChanged: (val) => setDialogState(() => speaking = val!),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: proficiencies.contains(reading)
                      ? reading
                      : proficiencies.first,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.readingProficiency,
                  ),
                  items: proficiencies
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
                      .toList(),
                  onChanged: (val) => setDialogState(() => reading = val!),
                ),
                SizedBox(height: 14.h),
                DropdownButtonFormField<String>(
                  initialValue: proficiencies.contains(writing)
                      ? writing
                      : proficiencies.first,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.writingProficiency,
                  ),
                  items: proficiencies
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
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

class _LanguageItem extends StatelessWidget {
  final ResumeLanguageEntity lang;
  final VoidCallback onEdit;

  const _LanguageItem({required this.lang, required this.onEdit});

  Widget buildBadge(
    BuildContext context,
    String title,
    String value,
    Color textColor,
    Color bgColor,
    Color borderColor,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (value.isEmpty) value = "-";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isDark ? textColor.withValues(alpha: 0.1) : bgColor,
        border: Border.all(
          color: isDark ? textColor.withValues(alpha: 0.3) : borderColor,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        "$title: $value",
        style: AppTextStyle.bodySmall.copyWith(
          color: isDark ? textColor.withValues(alpha: 0.9) : textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isDark ? colors.surface : colors.slate50,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: isDark ? colors.slate800 : colors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.language, color: colors.blueIcon, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  lang.language,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                      section: "languages",
                      rowName: lang.name,
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                color: isDark ? colors.slate400 : colors.slate500,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              buildBadge(
                context,
                "Speaking",
                lang.speaking,
                colors.info,
                colors.infoBg,
                colors.infoBorder,
              ),
              buildBadge(
                context,
                "Reading",
                lang.reading,
                colors.purpleHoliday,
                colors.holidayBg,
                colors.holidayBg,
              ),
              buildBadge(
                context,
                "Writing",
                lang.writing,
                colors.successDark,
                colors.successBg,
                colors.successBorder,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
