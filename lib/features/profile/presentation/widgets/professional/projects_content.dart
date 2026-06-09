import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/search_designations_usecase.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../domain/usecases/search_projects_usecase.dart';
import '../../../domain/usecases/search_employees_usecase.dart';
import '../../../data/models/search_employee_model.dart';
import 'common_form_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../../../../core/widgets/common_empty_view.dart';

class _ProjectConstants {
  static const String active = "Active";
  static const String inactive = "Inactive";
  static const String completed = "Completed";
  static const String onHold = "On Hold";

  static const List<String> statusValues = [active, inactive, completed, onHold];

  static const String formatMonthYear = 'MMM yyyy';
}

class ProjectsContent extends StatelessWidget {
  final List<ResumeProjectEntity> projects;

  const ProjectsContent({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (projects.isEmpty) {
      return CommonEmptyView(
        message: l10n.noConsultingProjectsAddedYet,
        icon: Icons.work_outline,
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final proj = projects[index];
        return _ProjectItem(
          proj: proj,
          onEdit: () => _showEditProjectDialog(context, proj),
        );
      },
    );
  }

  void _showEditProjectDialog(
    BuildContext context,
    ResumeProjectEntity proj,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final projectC = TextEditingController(text: proj.projectName);
    final roleC = TextEditingController(text: proj.role);
    final leadC = TextEditingController(text: proj.reportToName);
    final fromC = TextEditingController(text: proj.startDate);
    final toC = TextEditingController(text: proj.endDate);
    final allocationC = TextEditingController(
      text: proj.allocation > 0 ? proj.allocation.toString() : "",
    );
    String status = proj.status.isNotEmpty ? proj.status : _ProjectConstants.active;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              bloc: context.read<ProfileBloc>(),
              title: l10n.editProject,
              fields: [
                Builder(
                  builder: (context) {
                    return Autocomplete<String>(
                      initialValue: TextEditingValue(text: proj.projectName),
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
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
                                    onTap: () => onSelected(option),
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
                      initialValue: TextEditingValue(text: proj.role),
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
                            final useCase =
                                Get.find<SearchDesignationsUseCase>();
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
                                labelText: l10n.role,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.searchDesignation,
                                suffixIcon: Icon(Icons.search, size: 20),
                              ),
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
                                    onTap: () => onSelected(option),
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
                    return Autocomplete<SearchEmployeeModel>(
                      initialValue: TextEditingValue(text: proj.reportToName),
                      displayStringForOption: (option) => option.label,
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
                            final useCase = Get.find<SearchEmployeesUseCase>();
                            final result = await useCase(textEditingValue.text);
                            return result.fold(
                              (failure) =>
                                  const Iterable<SearchEmployeeModel>.empty(),
                              (employees) => employees,
                            );
                          },
                      onSelected: (SearchEmployeeModel selection) {
                        leadC.text = selection.value;
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                )!.projectLead,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.searchEmployee,
                                suffixIcon: Icon(Icons.search, size: 20),
                              ),
                              onChanged: (val) {
                                leadC.text = val;
                              },
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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            option.label,
                                            style: AppTextStyle.bodyMedium
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            "${option.designation} • ${option.department}",
                                            style: AppTextStyle.bodySmall,
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
                TextFormField(
                  controller: fromC,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: l10n.startDate,
                    hintText: l10n.ddmmyyyy,
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20),
                  ),
                  onTap: () async {
                    DateTime initial = DateTime.now();
                    if (fromC.text.isNotEmpty) {
                      try {
                        final parts = fromC.text.split('-');
                        if (parts.length == 3) {
                          initial = DateTime(
                            int.parse(parts[2]),
                            int.parse(parts[1]),
                            int.parse(parts[0]),
                          );
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
                      fromC.text = DateTimeUtils.formatDate(
                        picked,
                        pattern: DateTimeUtils.patternDDMMYYYY,
                      );
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: toC,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: l10n.endDate,
                    hintText: l10n.ddmmyyyy,
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20),
                  ),
                  onTap: () async {
                    DateTime initial = DateTime.now();
                    if (fromC.text.isNotEmpty) {
                      try {
                        final parts = fromC.text.split('-');
                        if (parts.length == 3) {
                          final fromDate = DateTime(
                            int.parse(parts[2]),
                            int.parse(parts[1]),
                            int.parse(parts[0]),
                          );
                          if (initial.isBefore(fromDate)) initial = fromDate;
                        }
                      } catch (_) {}
                    }
                    if (toC.text.isNotEmpty) {
                      try {
                        final parts = toC.text.split('-');
                        if (parts.length == 3) {
                          initial = DateTime(
                            int.parse(parts[2]),
                            int.parse(parts[1]),
                            int.parse(parts[0]),
                          );
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
                      toC.text = DateTimeUtils.formatDate(
                        picked,
                        pattern: DateTimeUtils.patternDDMMYYYY,
                      );
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: allocationC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.allocation,
                    hintText: l10n.eg80,
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  initialValue:
                      _ProjectConstants.statusValues.contains(status)
                      ? status
                      : _ProjectConstants.active,
                  decoration: InputDecoration(
                    labelText: l10n.status,
                  ),
                  items: _ProjectConstants.statusValues
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
                      .toList(),
                  onChanged: (val) => setDialogState(() => status = val!),
                ),
              ],
              onSave: () {
                if (projectC.text.isNotEmpty) {
                  String formatDate(String dateStr) {
                    if (dateStr.isEmpty) return "";
                    final parts = dateStr.split('-');
                    if (parts.length == 3) {
                      return "${parts[2]}-${parts[1]}-${parts[0]}";
                    }
                    return dateStr;
                  }

                  final data = {
                    "project_name": projectC.text,
                    "role": roleC.text,
                    "report_to_name": leadC.text,
                    "start_date": formatDate(fromC.text),
                    "end_date": formatDate(toC.text),
                    "allocation": double.tryParse(allocationC.text) ?? 0.0,
                    "status": status,
                  };
                  context.read<ProfileBloc>().add(
                    ProfileEvent.resumeRowUpsertRequested(
                      section: "projects",
                      rowDataJson: jsonEncode(data),
                      rowName: proj.name,
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

class _ProjectItem extends StatelessWidget {
  final ResumeProjectEntity proj;
  final VoidCallback onEdit;

  const _ProjectItem({required this.proj, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    String formatDate(String dateStr) {
      if (dateStr.isEmpty) return l10n.presentLabel;
      return DateTimeUtils.formatDateString(
        dateStr,
        pattern: _ProjectConstants.formatMonthYear,
        fallback: dateStr,
      );
    }

    final formattedStart = proj.startDate.isNotEmpty
        ? formatDate(proj.startDate)
        : l10n.startLabel;
    final formattedEnd = proj.endDate.isNotEmpty
        ? formatDate(proj.endDate)
        : l10n.presentLabel;

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
                    proj.projectName,
                    style: AppTextStyle.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    proj.role,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
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
                        section: "projects",
                        rowName: proj.name,
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: isDark ? colors.slate400 : colors.slate500,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          "$formattedStart -> $formattedEnd",
          style: AppTextStyle.bodySmall.copyWith(
            color: isDark ? colors.slate400 : colors.slate500,
          ),
        ),
        if (proj.reportToName.isNotEmpty || proj.allocation > 0) ...[
          SizedBox(height: 12.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 8.h,
            children: [
              if (proj.reportToName.isNotEmpty)
                Text(
                  "${l10n.leadLabel}: ${proj.reportToName}",
                  style: AppTextStyle.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (proj.allocation > 0)
                Text(
                  "${l10n.allocationLabel}: ${proj.allocation}%",
                  style: AppTextStyle.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (proj.status.isNotEmpty)
                Text(
                  "${l10n.statusLabel} ${proj.status == 'Active' ? l10n.activeStatus : (proj.status == 'Inactive' ? l10n.inactiveStatus : (proj.status == 'Completed' ? l10n.completedStatus : (proj.status == 'On Hold' ? l10n.onHoldStatus : proj.status)))}",
                  style: AppTextStyle.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
