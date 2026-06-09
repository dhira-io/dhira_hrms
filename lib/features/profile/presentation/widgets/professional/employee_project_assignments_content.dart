import 'package:dhira_hrms/core/widgets/common_alert_dialog.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/widgets/professional/common_form_bottom_sheet.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/utils/date_time_utils.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';
import '../../../domain/entities/profile_project_assignment_entity.dart';
import '../../../domain/entities/profile_entities.dart';
import 'package:get/get.dart';
import '../../../domain/usecases/search_projects_usecase.dart';
import '../../../domain/usecases/search_employees_usecase.dart';
import '../../../domain/usecases/search_designations_usecase.dart';
import '../../../data/models/search_employee_model.dart';


class EmployeeProjectAssignmentsContent extends StatelessWidget {
  final ProfileEntity profile;

  const EmployeeProjectAssignmentsContent({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final assignments = profile.projectAssignments ?? [];
    if (assignments.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(AppLocalizations.of(context)!.noProjectAssignmentsAddedYet),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: assignments.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final proj = assignments[index];
        return _ProjectItem(
          proj: proj,
          profile: profile,
          onEdit: () => _showEditProjectAssignmentDialog(context, proj),
        );
      },
    );
  }

  void _showEditProjectAssignmentDialog(
    BuildContext context,
    ProfileProjectAssignmentEntity proj,
  ) {
    final projectC = TextEditingController(text: proj.projectName);
    final roleC = TextEditingController(text: proj.role ?? "");
    final leadIdC = TextEditingController(text: proj.reportTo ?? "");
    final leadNameC = TextEditingController(text: proj.projectLead ?? "");
    final fromC = TextEditingController(
      text: _formatDateForUi(proj.startDate ?? ""),
    );
    final toC = TextEditingController(
      text: _formatDateForUi(proj.endDate ?? ""),
    );
    final allocationC = TextEditingController(
      text: proj.allocation?.toString() ?? "",
    );
    String status = proj.status?.isNotEmpty == true ? proj.status! : ProfileApiConstants.statusActive;
    final formKey = GlobalKey<FormState>();

    String? requiredValidator(String? value) {
      if (value == null || value.trim().isEmpty) return "Required field";
      return null;
    }

    CommonFormBottomSheet.show(
      context: context,
      bloc: context.read<ProfileBloc>(),
      title: AppLocalizations.of(context)!.editProjectAssignment,
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
                      initialValue: TextEditingValue(text: proj.role ?? ""),
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
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.role,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.searchRole,
                                suffixIcon: Icon(Icons.search, size: 20),
                              ),
                              onChanged: (val) {
                                roleC.text = val;
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
                ApiDropdownField<SearchEmployeeModel>(
                  labelText: AppLocalizations.of(context)!.projectLead,
                  hintText: AppLocalizations.of(context)!.selectProjectLead,
                  initialValue: proj.reportTo?.isNotEmpty == true
                      ? SearchEmployeeModel(
                          value: proj.reportTo!,
                          label: proj.projectLead ?? proj.reportTo!,
                          designation: "",
                          department: "",
                        )
                      : null,
                  fetcher: () async {
                    final useCase = Get.find<SearchEmployeesUseCase>();
                    final result = await useCase("");
                    return result.fold((f) => [], (emps) => emps);
                  },
                  displayStringForOption: (option) => option.label,
                  onChanged: (val) {
                    if (val != null) {
                      leadIdC.text = val.value;
                      leadNameC.text = val.label;
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: fromC,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.startDate,
                    hintText: AppLocalizations.of(context)!.ddmmyyyy,
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20),
                  ),
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
                        pattern: "dd-MM-yyyy",
                      );
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: toC,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.endDate,
                    hintText: AppLocalizations.of(context)!.ddmmyyyy,
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 20),
                  ),
                  onTap: () async {
                    DateTime initial = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: initial,
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      toC.text = DateTimeUtils.formatDate(
                        picked,
                        pattern: "dd-MM-yyyy",
                      );
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: allocationC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.allocation,
                    hintText: AppLocalizations.of(context)!.eg80,
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  initialValue: status,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.status,
                  ),
                  items: [
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
                  onChanged: (val) => setDialogState(() => status = val!),
                ),
              ],
            );
          },
        ),
      ],
      onSave: () {
        if (formKey.currentState!.validate()) {
          final updatedList = List<ProfileProjectAssignmentEntity>.from(
            profile.projectAssignments ?? [],
          );
          final index = updatedList.indexWhere(
            (e) => e.projectName == proj.projectName,
          );

          if (index != -1) {
            updatedList[index] = updatedList[index].copyWith(
              projectName: projectC.text,
              projectLead: leadNameC.text,
              reportTo: leadIdC.text,
              role: roleC.text,
              startDate: _formatDateForApi(fromC.text),
              endDate: _formatDateForApi(toC.text),
              allocation: double.tryParse(allocationC.text),
              status: status,
            );
          } else {
            updatedList.add(
              ProfileProjectAssignmentEntity(
                projectName: projectC.text,
                projectLead: leadNameC.text,
                reportTo: leadIdC.text,
                role: roleC.text,
                startDate: _formatDateForApi(fromC.text),
                endDate: _formatDateForApi(toC.text),
                allocation: double.tryParse(allocationC.text),
                status: status,
              ),
            );
          }

          final jsonList = updatedList
              .map(
                (e) => {
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

  String _formatDateForApi(String dateStr) {
    if (dateStr.isEmpty) return "";
    final parts = dateStr.split('-');
    if (parts.length == 3 && parts[0].length == 2) {
      return "${parts[2]}-${parts[1]}-${parts[0]}";
    }
    return dateStr;
  }

  String _formatDateForUi(String dateStr) {
    if (dateStr.isEmpty) return "";
    final parts = dateStr.split('-');
    if (parts.length == 3 && parts[0].length == 4) {
      return "${parts[2]}-${parts[1]}-${parts[0]}";
    }
    return dateStr;
  }
}

class _ProjectItem extends StatelessWidget {
  final ProfileProjectAssignmentEntity proj;
  final ProfileEntity profile;
  final VoidCallback onEdit;

  const _ProjectItem({
    required this.proj,
    required this.profile,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

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
                  if (proj.projectLead != null &&
                      proj.projectLead!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      "Lead: ${proj.projectLead}",
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  if (proj.role != null && proj.role!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text("Role: ${proj.role}", style: AppTextStyle.bodyMedium),
                  ],
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
                    CommonAlertDialog.show(
                      context: context,
                      title: AppLocalizations.of(context)!.delete,
                      content: AppLocalizations.of(context)!.deleteConfirmation,
                      confirmText: AppLocalizations.of(context)!.delete,
                      cancelText: AppLocalizations.of(context)!.cancel,
                      confirmButtonColor: AppColors.of(context).error,
                      onConfirm: () {
                        final updatedList =
                            List<ProfileProjectAssignmentEntity>.from(
                              profile.projectAssignments ?? [],
                            );
                        updatedList.removeWhere(
                          (e) => e.projectName == proj.projectName,
                        );

                        final jsonList = updatedList
                            .map(
                              (e) => {
                                "project_name": e.projectName,
                                if (e.projectLead != null)
                                  "report_to_name": e.projectLead,
                              },
                            )
                            .toList();

                        context.read<ProfileBloc>().add(
                          ProfileEvent.projectAssignmentsUpdateRequested(
                            assignmentsJson: jsonEncode(jsonList),
                          ),
                        );
                      },
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
          "${proj.startDate?.isNotEmpty == true ? proj.startDate : 'Start'} to ${proj.endDate?.isNotEmpty == true ? proj.endDate : 'Present'}",
          style: AppTextStyle.bodySmall.copyWith(
            color: isDark ? colors.slate400 : colors.slate500,
          ),
        ),
        if (proj.allocation != null) ...[
          SizedBox(height: 4.h),
          Text(
            "${AppLocalizations.of(context)!.allocationLabel}: ${proj.allocation}%",
            style: AppTextStyle.bodySmall,
          ),
        ],
        if (proj.status?.isNotEmpty == true) ...[
          SizedBox(height: 4.h),
          Text(
            "${AppLocalizations.of(context)!.statusLabel}: ${proj.status}",
            style: AppTextStyle.bodySmall,
          ),
        ],
      ],
    );
  }

  String _formatDateForApi(String dateStr) {
    if (dateStr.isEmpty) return "";
    final parts = dateStr.split('-');
    if (parts.length == 3 && parts[0].length == 2) {
      return "${parts[2]}-${parts[1]}-${parts[0]}";
    }
    return dateStr;
  }

  String _formatDateForUi(String dateStr) {
    if (dateStr.isEmpty) return "";
    final parts = dateStr.split('-');
    if (parts.length == 3 && parts[0].length == 4) {
      return "${parts[2]}-${parts[1]}-${parts[0]}";
    }
    return dateStr;
  }
}

class ApiDropdownField<T> extends StatefulWidget {
  final Future<List<T>> Function() fetcher;
  final String Function(T) displayStringForOption;
  final String labelText;
  final String hintText;
  final T? initialValue;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const ApiDropdownField({
    super.key,
    required this.fetcher,
    required this.displayStringForOption,
    required this.labelText,
    required this.hintText,
    this.initialValue,
    required this.onChanged,
    this.validator,
  });

  @override
  State<ApiDropdownField<T>> createState() => _ApiDropdownFieldState<T>();
}

class _ApiDropdownFieldState<T> extends State<ApiDropdownField<T>> {
  List<T> _items = [];
  bool _isLoading = true;
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final items = await widget.fetcher();
      if (_selectedValue != null) {
        final match = items
            .where(
              (e) =>
                  widget.displayStringForOption(e) ==
                  widget.displayStringForOption(_selectedValue as T),
            )
            .toList();
        if (match.isEmpty) {
          items.insert(0, _selectedValue as T);
        } else {
          _selectedValue = match.first;
        }
      }
      if (mounted) {
        setState(() {
          _items = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: AppLocalizations.of(context)!.loading,
          suffixIcon: const Padding(
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        enabled: false,
      );
    }
    return DropdownButtonFormField<T>(
      value: _selectedValue,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
      ),
      items: _items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            widget.displayStringForOption(item),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: (val) {
        setState(() => _selectedValue = val);
        widget.onChanged(val);
      },
      validator: widget.validator,
    );
  }
}
