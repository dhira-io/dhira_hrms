import 'dart:convert';
import 'package:dhira_hrms/features/profile/presentation/widgets/professional/dialogs/common_form_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAddEducationDialog(BuildContext context) async {
  final schoolC = TextEditingController();
  final degC = TextEditingController();
  int currentYear = DateTime.now().year;
  String periodSelected = currentYear.toString();
  final years = List.generate(
    currentYear - 1949,
    (index) => (currentYear - index).toString(),
  );

  String level = "Graduate";
  final levels = ProfileApiConstants.educationLevels;
  final formKey = GlobalKey<FormState>();

  CommonFormBottomSheet.show(
    context: context,
    formKey: formKey,
    bloc: context.read<ProfileBloc>(),
    title: AppLocalizations.of(context)!.addEducation,
    fields: [
      StatefulBuilder(
        builder: (ctx, setDialogState) {
          final l10n = AppLocalizations.of(context)!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                initialValue: level,
                decoration: InputDecoration(
                  labelText: l10n.qualificationLevel,
                ),
                items: levels.map((val) {
                  String label = val;
                  if (val == "High School / Secondary") {
                    label = l10n.eduHighSchool;
                  } else if (val == "Diploma") {
                    label = l10n.eduDiploma;
                  } else if (val == "Under Graduate") {
                    label = l10n.eduUnderGraduate;
                  } else if (val == "Graduate") {
                    label = l10n.eduGraduate;
                  } else if (val == "Post Graduate") {
                    label = l10n.eduPostGraduate;
                  } else if (val == "Doctorate / PhD") {
                    label = l10n.eduDoctorate;
                  } else if (val == "Professional Certification") {
                    label = l10n.eduProfessionalCert;
                  } else if (val == "Other") {
                    label = l10n.eduOther;
                  }

                  return DropdownMenuItem(value: val, child: Text(label));
                }).toList(),
                onChanged: (val) => setDialogState(() => level = val!),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: degC,
                decoration: InputDecoration(
                  labelText: l10n.degreeCourse,
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? l10n.requiredField
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: schoolC,
                decoration: InputDecoration(
                  labelText: l10n.schoolUniversity,
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? l10n.requiredField
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField<String>(
                initialValue: periodSelected,
                decoration: InputDecoration(
                  labelText: l10n.yearOfPassing,
                ),
                items: years
                    .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                    .toList(),
                onChanged: (val) => setDialogState(() => periodSelected = val!),
              ),
            ],
          );
        },
      ),
    ],
    onSave: () {
      if (formKey.currentState!.validate()) {
        final data = {
          ProfileApiConstants.keyQualification: degC.text,
          ProfileApiConstants.keySchoolUniv: schoolC.text,
          ProfileApiConstants.keyYearOfPassing: periodSelected,
          ProfileApiConstants.keyLevel: level,
        };
        context.read<ProfileBloc>().add(
          ProfileEvent.resumeRowUpsertRequested(
            section: ProfileApiConstants.sectionEducation,
            rowDataJson: jsonEncode(data),
          ),
        );
      }
    },
  );
}
