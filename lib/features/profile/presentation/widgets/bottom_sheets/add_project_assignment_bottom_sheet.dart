import 'dart:convert';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:dhira_hrms/features/profile/presentation/widgets/professional/dialogs/common_form_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/search_projects_usecase.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/search_designations_usecase.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/search_employees_usecase.dart';
import 'package:dhira_hrms/features/profile/data/models/search_employee_model.dart';
import 'package:dhira_hrms/features/profile/domain/entities/profile_project_assignment_entity.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAddProjectAssignmentDialog(BuildContext context) async {
  final projectC = TextEditingController();
  final roleC = TextEditingController();
  final leadC = TextEditingController();
  final fromC = TextEditingController();
  final toC = TextEditingController();
  final allocationC = TextEditingController();
  String? reportTo;
  String status = ProfileApiConstants.statusActive;
  final formKey = GlobalKey<FormState>();

  String? requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.requiredField;
    }
    return null;
  }

  CommonFormBottomSheet.show(
    context: context,
    bloc: context.read<ProfileBloc>(),
    title: AppLocalizations.of(context)!.addProject,
    formKey: formKey,
    fields: [
      StatefulBuilder(
        builder: (ctx, setDialogState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Builder(
                builder: (context) {
                  return Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      final useCase = Get.find<SearchProjectsUseCase>();
                      final result = await useCase(textEditingValue.text);
                      return result.fold(
                        (failure) => const Iterable<String>.empty(),
                        (projects) => projects,
                      );
                    },
                    onSelected: (String selection) {
                      projectC.text = selection;
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onFieldSubmitted) {
                          controller.addListener(() {
                            projectC.text = controller.text;
                          });
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.projectName,
                              hintText: AppLocalizations.of(
                                context,
                              )!.searchProject,
                              suffixIcon: Icon(Icons.search, size: 20),
                            ),
                            validator: requiredValidator,
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
              SizedBox(height: 12.h),
              Builder(
                builder: (context) {
                  return Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      final useCase = Get.find<SearchDesignationsUseCase>();
                      final result = await useCase(textEditingValue.text);
                      return result.fold(
                        (failure) => const Iterable<String>.empty(),
                        (designations) => designations,
                      );
                    },
                    onSelected: (String selection) {
                      roleC.text = selection;
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onFieldSubmitted) {
                          controller.addListener(() {
                            roleC.text = controller.text;
                          });
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.roleLabel,
                              hintText: AppLocalizations.of(
                                context,
                              )!.searchRole,
                              suffixIcon: const Icon(Icons.search, size: 20),
                            ),
                            validator: requiredValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          );
                        },
                  );
                },
              ),
              SizedBox(height: 12.h),
              Builder(
                builder: (context) {
                  return Autocomplete<SearchEmployeeModel>(
                    displayStringForOption: (option) => option.label,
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      final useCase = Get.find<SearchEmployeesUseCase>();
                      final result = await useCase(textEditingValue.text);
                      return result.fold(
                        (failure) =>
                            const Iterable<SearchEmployeeModel>.empty(),
                        (employees) => employees,
                      );
                    },
                    onSelected: (SearchEmployeeModel selection) {
                      leadC.text = selection.label;
                      reportTo = selection.value;
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onFieldSubmitted) {
                          controller.addListener(() {
                            leadC.text = controller.text;
                            if (controller.text.isEmpty) {
                              reportTo = null;
                            }
                          });
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.reportsTo,
                              hintText: AppLocalizations.of(
                                context,
                              )!.searchEmployee,
                              suffixIcon: const Icon(Icons.search, size: 20),
                            ),
                            validator: requiredValidator,
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
                                final SearchEmployeeModel option = options
                                    .elementAt(index);
                                return InkWell(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          child: const Icon(
                                            Icons.person,
                                            size: 16,
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Text(
                                          option.label,
                                          style: AppTextStyle.bodyMedium,
                                        ),
                                      ],
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
                          fromC.text = picked.format(
                            DateTimeUtils.patternDDMMYYYY,
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
                      onTap: () async {
                        DateTime initial = DateTime.now();
                        DateTime firstDate = DateTime(1950);
                        if (fromC.text.isNotEmpty) {
                          try {
                            final parts = fromC.text.split('-');
                            if (parts.length == 3) {
                              firstDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
                              if (initial.isBefore(firstDate)) initial = firstDate;
                            }
                          } catch (_) {}
                        }
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: initial,
                          firstDate: firstDate,
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          toC.text = picked.format(
                            DateTimeUtils.patternDDMMYYYY,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: allocationC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(
                    context,
                  )!.allocationPercentLabel,
                ),
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField<String>(
                initialValue: status,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.statusLabel,
                ),
                items:
                    [
                          ProfileApiConstants.statusActive,
                          ProfileApiConstants.statusInactive,
                        ]
                        .map<DropdownMenuItem<String>>(
                          (val) => DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          ),
                        )
                        .toList(),
                onChanged: (val) {
                  if (val != null) setDialogState(() => status = val);
                },
              ),
            ],
          );
        },
      ),
    ],
    onSave: () {
      if (formKey.currentState!.validate()) {
        String formatDate(String dateStr) {
          if (dateStr.isEmpty) return "";
          final parts = dateStr.split('-');
          if (parts.length == 3) {
            return "${parts[2]}-${parts[1]}-${parts[0]}";
          }
          return dateStr;
        }

        final currentProfile = context.read<ProfileBloc>().state.profile;
        final assignments =
            currentProfile?.projectAssignments ??
            <ProfileProjectAssignmentEntity>[];
        final currentList = List<ProfileProjectAssignmentEntity>.from(
          assignments,
        );

        currentList.add(
          ProfileProjectAssignmentEntity(
            projectName: projectC.text,
            role: roleC.text,
            projectLead: leadC.text,
            reportTo: reportTo,
            startDate: formatDate(fromC.text),
            endDate: formatDate(toC.text),
            allocation: double.tryParse(allocationC.text) ?? 0.0,
            status: status,
          ),
        );

        final jsonList = currentList
            .map(
              (ProfileProjectAssignmentEntity e) => {
                "project_name": e.projectName,
                if (e.reportTo != null && e.reportTo!.isNotEmpty)
                  "report_to": e.reportTo,
                if (e.projectLead != null && e.projectLead!.isNotEmpty)
                  "report_to_name": e.projectLead,
                if (e.role != null && e.role!.isNotEmpty) "role": e.role,
                if (e.startDate != null && e.startDate!.isNotEmpty)
                  "start_date": e.startDate,
                if (e.endDate != null && e.endDate!.isNotEmpty)
                  "end_date": e.endDate,
                if (e.allocation != null) "allocation": e.allocation,
                if (e.status != null && e.status!.isNotEmpty)
                  "status": e.status,
              },
            )
            .toList();

        context.read<ProfileBloc>().add(
          ProfileEvent.projectAssignmentsUpdateRequested(
            assignmentsJson: jsonEncode(jsonList),
          ),
        );
      }
    },
  );
}
