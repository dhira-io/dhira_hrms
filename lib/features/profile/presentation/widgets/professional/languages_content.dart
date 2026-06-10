import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';
import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/utils/language_helper.dart';
import 'common_form_bottom_sheet.dart';
import '../../../../../core/widgets/common_alert_dialog.dart';

class LanguagesContent extends StatelessWidget {
  final List<ResumeLanguageEntity> languages;

  const LanguagesContent({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (languages.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(l10n.noLanguagesAddedYet),
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

  void _showEditLanguageDialog(BuildContext context, ResumeLanguageEntity lang) {
    final l10n = AppLocalizations.of(context)!;
    final langC = TextEditingController(text: lang.language);
    String speaking = lang.speaking.isNotEmpty
        ? lang.speaking
        : l10n.basic;
    String reading = lang.reading.isNotEmpty
        ? lang.reading
        : l10n.basic;
    String writing = lang.writing.isNotEmpty
        ? lang.writing
        : l10n.basic;
    final formKey = GlobalKey<FormState>();

    final proficiencies = [
      l10n.basic,
      l10n.conversational,
      l10n.fluent,
      l10n.native,
    ];

    CommonFormBottomSheet.show(
      context: context,
      formKey: formKey,
      bloc: context.read<ProfileBloc>(),
      title: l10n.editLanguage,
      fields: [
        StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder<List<String>>(
                  future: LanguageHelper.getLanguages(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final items = List<String>.from(snapshot.data!);

                    return Autocomplete<String>(
                      initialValue: TextEditingValue(text: langC.text),
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return items;
                        }
                        return items.where((String option) {
                          return option.toLowerCase().contains(
                            textEditingValue.text.toLowerCase(),
                          );
                        });
                      },
                      onSelected: (String selection) {
                        langC.text = selection;
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                            controller.addListener(() {
                              langC.text = controller.text;
                            });
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: l10n.language,
                                hintText: l10n.searchLanguage,
                                suffixIcon: const Icon(Icons.search, size: 20),
                              ),
                              validator: (val) => val == null || val.trim().isEmpty
                                  ? l10n.requiredField
                                  : null,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            );
                          },
                      optionsViewBuilder: (context, onSelected, options) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            color: isDark
                                ? AppColors.of(context).surface
                                : AppColors.of(context).white,
                            borderRadius: BorderRadius.circular(8.r),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                                maxHeight: 200.h,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option = options.elementAt(
                                    index,
                                  );
                                  return InkWell(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 12.h,
                                      ),
                                      child: Text(
                                        option,
                                        style: AppTextStyle.bodyMedium,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
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
                    labelText: l10n.readingProficiency,
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
                    labelText: l10n.writingProficiency,
                  ),
                  items: proficiencies
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
                      .toList(),
                  onChanged: (val) => setDialogState(() => writing = val!),
                ),
              ],
            );
          },
        ),
      ],
      onSave: () {
        if (formKey.currentState!.validate()) {
          final data = {
            ProfileApiConstants.keyLanguage: langC.text,
            ProfileApiConstants.keySpeaking: speaking,
            ProfileApiConstants.keyReading: reading,
            ProfileApiConstants.keyWriting: writing,
          };
          context.read<ProfileBloc>().add(
            ProfileEvent.resumeRowUpsertRequested(
              section: ProfileApiConstants.sectionLanguages,
              rowDataJson: jsonEncode(data),
              rowName: lang.name,
            ),
          );
        }
      },
    );
  }
}

class _LanguageItem extends StatefulWidget {
  final ResumeLanguageEntity lang;
  final VoidCallback onEdit;

  const _LanguageItem({required this.lang, required this.onEdit});

  @override
  State<_LanguageItem> createState() => _LanguageItemState();
}

class _LanguageItemState extends State<_LanguageItem> {
  bool _isDeleting = false;

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
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);
    final lang = widget.lang;

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
      child: Container(
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
                        title: AppLocalizations.of(context)!.delete,
                        content: AppLocalizations.of(context)!.deleteLanguageConfirmation,
                        confirmText: AppLocalizations.of(context)!.delete,
                        cancelText: AppLocalizations.of(context)!.cancel,
                        confirmButtonColor: AppColors.of(context).error,
                        onConfirm: () {
                          setState(() => _isDeleting = true);
                          context.read<ProfileBloc>().add(
                            ProfileEvent.resumeRowDeleteRequested(
                              section: ProfileApiConstants.sectionLanguages,
                              rowName: lang.name,
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
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                buildBadge(
                  context,
                  l10n.speaking,
                  lang.speaking,
                  colors.info,
                  colors.infoBg,
                  colors.infoBorder,
                ),
                buildBadge(
                  context,
                  l10n.reading,
                  lang.reading,
                  colors.purpleHoliday,
                  colors.holidayBg,
                  colors.holidayBg,
                ),
                buildBadge(
                  context,
                  l10n.writing,
                  lang.writing,
                  colors.successDark,
                  colors.successBg,
                  colors.successBorder,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
