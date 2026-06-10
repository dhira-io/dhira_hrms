import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/search_designations_usecase.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/presentation/widgets/professional/common_form_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAddExperienceDialog(BuildContext context) async {
  final titleC = TextEditingController();
  final companyC = TextEditingController();
  final fromC = TextEditingController();
  final toC = TextEditingController();
  final summaryC = TextEditingController();
  String type = AppLocalizations.of(context)!.fullTime;
  bool currentlyWorking = false;

  CommonFormBottomSheet.show(
    context: context,
    title: AppLocalizations.of(context)!.addWorkExperience,
    fields: [
      StatefulBuilder(
        builder: (ctx, setDialogState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: companyC,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.company,
                ),
              ),
              SizedBox(height: 12.h),
              Builder(
                builder: (context) {
                  return Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.isEmpty) {
                        return ProfileApiConstants.defaultDesignations;
                      }
                      final useCase = Get.find<SearchDesignationsUseCase>();
                      final result = await useCase(textEditingValue.text);
                      return result.fold(
                        (failure) => const Iterable<String>.empty(),
                        (designations) => designations,
                      );
                    },
                    onSelected: (String selection) {
                      titleC.text = selection;
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onFieldSubmitted) {
                          controller.addListener(() {
                            titleC.text = controller.text;
                          });
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.designation,
                              suffixIcon: Icon(Icons.search, size: 20),
                            ),
                            validator: (val) => val == null || val.isEmpty
                                ? AppLocalizations.of(
                                    context,
                                  )!.designationCannotBeEmpty
                                : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          );
                        },
                  );
                },
              ),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: fromC,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.fromDate,
                        suffixIcon: Icon(Icons.calendar_today, size: 20),
                      ),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            fromC.text =
                                "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                          });
                        }
                      },
                    ),
                  ),
                  if (!currentlyWorking) ...[
                    SizedBox(width: 16.w),
                    Expanded(
                      child: TextFormField(
                        controller: toC,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.toDate,
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            size: 20,
                          ),
                        ),
                        onTap: () async {
                          DateTime initial = DateTime.now();
                          if (fromC.text.isNotEmpty) {
                            try {
                              final parts = fromC.text.split('-');
                              final fromDate = DateTime(
                                int.parse(parts[2]),
                                int.parse(parts[1]),
                                int.parse(parts[0]),
                              );
                              if (initial.isBefore(fromDate)) {
                                initial = fromDate;
                              }
                            } catch (_) {}
                          }
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: initial,
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setDialogState(() {
                              toC.text =
                                  "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 8.h),
              CheckboxListTile(
                title: Text(AppLocalizations.of(context)!.currentlyWorkingHere),
                value: currentlyWorking,
                onChanged: (val) => setDialogState(() {
                  currentlyWorking = val ?? false;
                  if (currentlyWorking) toC.clear();
                }),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField<String>(
                initialValue: type,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.employmentType,
                ),
                items:
                    [
                          AppLocalizations.of(context)!.fullTime,
                          AppLocalizations.of(context)!.partTime,
                          AppLocalizations.of(context)!.contract,
                        ]
                        .map(
                          (val) =>
                              DropdownMenuItem(value: val, child: Text(val)),
                        )
                        .toList(),
                onChanged: (val) => setDialogState(() => type = val!),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: summaryC,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.assignmentSummary,
                ),
              ),
            ],
          );
        },
      ),
    ],
    onSave: () {
      if (titleC.text.isNotEmpty && companyC.text.isNotEmpty) {
        String formatDate(String dateStr) {
          if (dateStr.isEmpty) return "";
          final parts = dateStr.split('-');
          if (parts.length == 3) return "${parts[2]}-${parts[1]}-${parts[0]}";
          return dateStr;
        }

        final data = {
          ProfileApiConstants.keyDesignation: titleC.text,
          ProfileApiConstants.keyCompanyName: companyC.text,
          ProfileApiConstants.keyCustomFromDate: formatDate(fromC.text),
          ProfileApiConstants.keyCustomToDate: currentlyWorking ? "" : formatDate(toC.text),
          ProfileApiConstants.keyCustomCurrentlyWorking: currentlyWorking,
          ProfileApiConstants.keyCustomAssignmentSummary: summaryC.text,
          ProfileApiConstants.keyCustomEmploymentType: type,
        };
        context.read<ProfileBloc>().add(
          ProfileEvent.resumeRowUpsertRequested(
            section: ProfileApiConstants.sectionWorkExperience,
            rowDataJson: jsonEncode(data),
          ),
        );
      }
    },
    bloc: context.read<ProfileBloc>(),
  );
}
