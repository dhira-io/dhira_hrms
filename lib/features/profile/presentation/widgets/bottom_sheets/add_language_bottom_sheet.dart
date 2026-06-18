import 'dart:convert';
import 'package:dhira_hrms/features/profile/presentation/widgets/professional/dialogs/common_form_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/core/utils/language_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';

Future<void> showAddLanguageDialog(BuildContext context) async {
  final langC = TextEditingController();
  String speaking = AppLocalizations.of(context)!.basic;
  String reading = AppLocalizations.of(context)!.basic;
  String writing = AppLocalizations.of(context)!.basic;
  final formKey = GlobalKey<FormState>();

  final proficiencies = [
    AppLocalizations.of(context)!.basic,
    AppLocalizations.of(context)!.conversational,
    AppLocalizations.of(context)!.fluent,
    AppLocalizations.of(context)!.native,
  ];

  CommonFormBottomSheet.show(
    context: context,
    formKey: formKey,
    bloc: context.read<ProfileBloc>(),
    title: AppLocalizations.of(context)!.addLanguage,
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
                          if (langC.text.isNotEmpty &&
                              controller.text.isEmpty) {
                            controller.text = langC.text;
                          }
                          controller.addListener(() {
                            langC.text = controller.text;
                          });
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.language,
                              hintText: AppLocalizations.of(
                                context,
                              )!.searchLanguage,
                              suffixIcon: const Icon(Icons.search, size: 20),
                            ),
                            validator: (val) =>
                                val == null || val.trim().isEmpty
                                ? AppLocalizations.of(context)!.requiredField
                                : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                              maxHeight: 200.h,
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
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
                initialValue: speaking,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.speakingProficiency,
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
                initialValue: reading,
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
                initialValue: writing,
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
          ),
        );
      }
    },
  );
}
