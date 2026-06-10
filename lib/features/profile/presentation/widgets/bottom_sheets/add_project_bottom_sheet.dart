import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/presentation/widgets/professional/common_form_bottom_sheet.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';

Future<void> showAddProjectDialog(
  BuildContext context, {
  String? initialParentCompany,
  dynamic project,
}) async {
  final parentC = TextEditingController(
    text: project?.parentCompany ?? initialParentCompany,
  );
  final clientC = TextEditingController(text: project?.clientName);
  final projectC = TextEditingController(text: project?.project);
  final fromC = TextEditingController(text: project?.fromDate);
  final toC = TextEditingController(text: project?.toDate);
  final overviewC = TextEditingController(text: project?.projectOverview);
  final impactC = TextEditingController(text: project?.businessImpact);
  final toolsC = TextEditingController(text: project?.toolsAndTechnologies);
  final formKey = GlobalKey<FormState>();

  String? requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty)
      return AppLocalizations.of(context)!.requiredField;
    return null;
  }

  CommonFormBottomSheet.show(
    context: context,
    bloc: context.read<ProfileBloc>(),
    title: project != null
        ? AppLocalizations.of(context)!.editKeyProject
        : AppLocalizations.of(context)!.addConsultingProject,
    formKey: formKey,
    fields: [
      TextFormField(
        controller: clientC,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.clientName,
        ),
        validator: requiredValidator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
      SizedBox(height: 12.h),
      TextFormField(
        controller: projectC,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.projectName,
        ),
        validator: requiredValidator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
      SizedBox(height: 12.h),
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: fromC,
              readOnly: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.fromDate,
                suffixIcon: Icon(Icons.calendar_today, size: 20),
              ),
              validator: requiredValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  fromC.text = DateTimeUtils.formatDate(
                    picked,
                    pattern: DateTimeUtils.patternDDMMYYYY,
                  );
                }
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextFormField(
              controller: toC,
              readOnly: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.toDate,
                suffixIcon: Icon(Icons.calendar_today, size: 20),
              ),
              validator: requiredValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  toC.text = DateTimeUtils.formatDate(
                    picked,
                    pattern: DateTimeUtils.patternDDMMYYYY,
                  );
                }
              },
            ),
          ),
        ],
      ),
      SizedBox(height: 12.h),
      TextFormField(
        controller: toolsC,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.toolsAndTechnologiesOptional,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
      SizedBox(height: 12.h),
      TextFormField(
        controller: overviewC,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.projectOverviewOptional,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
      SizedBox(height: 12.h),
      TextFormField(
        controller: impactC,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.businessImpactOptional,
        ),
      ),
    ],
    onSave: () {
      if (formKey.currentState!.validate()) {
        final data = {
          "parent_company": parentC.text,
          "client_name": clientC.text,
          "project": projectC.text,
          "from_date": fromC.text,
          "to_date": toC.text,
          "duration": DateTimeUtils.calculateDuration(fromC.text, toC.text),
          "project_overview": overviewC.text,
          "business_impact": impactC.text,
          "tools_and_technologies": toolsC.text,
        };
        context.read<ProfileBloc>().add(
          ProfileEvent.resumeRowUpsertRequested(
            section: "consulting_experience",
            rowDataJson: jsonEncode(data),
            rowName: project?.name,
          ),
        );
      } else {
        ToastUtils.showError(
          AppLocalizations.of(context)!.pleaseFillAllMandatoryFields,
        );
      }
    },
  );
}
