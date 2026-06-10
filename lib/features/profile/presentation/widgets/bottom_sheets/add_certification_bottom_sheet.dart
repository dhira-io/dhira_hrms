import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/presentation/widgets/professional/common_form_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAddCertificationDialog(BuildContext context) async {
  final nameC = TextEditingController();
  final issuerC = TextEditingController();
  int currentYear = DateTime.now().year;
  String yearSelected = currentYear.toString();
  final years = List.generate(
    currentYear - 1949,
    (index) => (currentYear - index).toString(),
  );
  final formKey = GlobalKey<FormState>();

  CommonFormBottomSheet.show(
    context: context,
    formKey: formKey,
    bloc: context.read<ProfileBloc>(),
    title: AppLocalizations.of(context)!.addCertification,
    fields: [
      StatefulBuilder(
        builder: (ctx, setDialogState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameC,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.certificationName,
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? AppLocalizations.of(context)!.requiredField
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: issuerC,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.issuerOrganization,
                ),
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField<String>(
                value: yearSelected,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.yearOfAcquisition,
                ),
                items: years
                    .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                    .toList(),
                onChanged: (val) => setDialogState(() => yearSelected = val!),
              ),
            ],
          );
        },
      ),
    ],
    onSave: () {
      if (formKey.currentState!.validate()) {
        final data = {
          "certification_name": nameC.text,
          "issuing_institute": issuerC.text,
          "year_obtained": yearSelected,
          "certification_url": "",
        };
        context.read<ProfileBloc>().add(
          ProfileEvent.resumeRowUpsertRequested(
            section: "certifications",
            rowDataJson: jsonEncode(data),
          ),
        );
      }
    },
  );
}
