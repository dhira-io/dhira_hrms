import re

def fix_content():
    with open('lib/features/profile/presentation/widgets/professional/employee_project_assignments_content.dart', 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 1. We need to swap Role and Project Lead blocks in _showEditProjectAssignmentDialog
    # But wait, Project Name is duplicated in the current broken version of the file!
    # Let's fix the whole dialog body by just finding `void _showEditProjectAssignmentDialog` and replacing the rest of the class.

    start_idx = content.find('  void _showEditProjectAssignmentDialog(BuildContext context, ProfileProjectAssignmentEntity proj) {')
    if start_idx == -1:
        return
        
    correct_dialog = """  void _showEditProjectAssignmentDialog(BuildContext context, ProfileProjectAssignmentEntity proj) {
    final projectC = TextEditingController(text: proj.projectName);
    final roleC = TextEditingController(text: proj.role ?? "");
    final leadC = TextEditingController(text: proj.projectLead ?? "");
    final fromC = TextEditingController(text: _formatDateForUi(proj.startDate ?? ""));
    final toC = TextEditingController(text: _formatDateForUi(proj.endDate ?? ""));
    final allocationC = TextEditingController(text: proj.allocation?.toString() ?? "");
    String status = proj.status?.isNotEmpty == true ? proj.status! : "Active";
    final formKey = GlobalKey<FormState>();

    String? requiredValidator(String? value) {
      if (value == null || value.trim().isEmpty) return "Required field";
      return null;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              title: "Edit Project Assignment",
              formKey: formKey,
              fields: [
                Builder(
                  builder: (context) {
                    return Autocomplete<String>(
                      initialValue: TextEditingValue(text: proj.projectName),
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
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        controller.addListener(() {
                          projectC.text = controller.text;
                        });
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: "PROJECT NAME",
                            hintText: "Search project...",
                            suffixIcon: Icon(Icons.search, size: 20),
                          ),
                          validator: requiredValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        );
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            color: isDark ? AppColors.of(context).surface : AppColors.of(context).white,
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
                                    onTap: () => onSelected(option),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                      child: Text(option, style: AppTextStyle.bodyMedium),
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
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: "ROLE",
                            hintText: "Search role...",
                            suffixIcon: Icon(Icons.search, size: 20),
                          ),
                          onChanged: (val) {
                            roleC.text = val;
                          },
                        );
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            color: isDark ? AppColors.of(context).surface : AppColors.of(context).white,
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
                                    onTap: () => onSelected(option),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                      child: Text(option, style: AppTextStyle.bodyMedium),
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
                      initialValue: TextEditingValue(text: proj.projectLead ?? ""),
                      displayStringForOption: (option) => option.label,
                      optionsBuilder: (TextEditingValue textEditingValue) async {
                        final useCase = Get.find<SearchEmployeesUseCase>();
                        final result = await useCase(textEditingValue.text);
                        return result.fold(
                          (failure) => const Iterable<SearchEmployeeModel>.empty(),
                          (employees) => employees,
                        );
                      },
                      onSelected: (SearchEmployeeModel selection) {
                        leadC.text = selection.value;
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: "PROJECT LEAD",
                            hintText: "Search employee...",
                            suffixIcon: Icon(Icons.search, size: 20),
                          ),
                          onChanged: (val) {
                            leadC.text = val;
                          },
                        );
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            color: isDark ? AppColors.of(context).surface : AppColors.of(context).white,
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
                                  final SearchEmployeeModel option = options.elementAt(index);
                                  return InkWell(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(option.label, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                                          Text("${option.designation} • ${option.department}", style: AppTextStyle.bodySmall),
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
                  decoration: const InputDecoration(
                    labelText: "START DATE",
                    hintText: "dd-mm-yyyy",
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
                      fromC.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: toC,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "END DATE",
                    hintText: "dd-mm-yyyy",
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
                      toC.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: allocationC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "ALLOCATION (%)",
                    hintText: "e.g. 80",
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: status,
                  decoration: const InputDecoration(labelText: "STATUS"),
                  items: ["Active", "Inactive", "Completed", "On Hold"]
                      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => status = val!),
                ),
              ],
              onSave: () {
                if (formKey.currentState!.validate()) {
                  final updatedList = List<ProfileProjectAssignmentEntity>.from(profile.projectAssignments ?? []);
                  final index = updatedList.indexWhere((e) => e.projectName == proj.projectName);
                  
                  if (index != -1) {
                    updatedList[index] = updatedList[index].copyWith(
                      projectName: projectC.text,
                      projectLead: leadC.text,
                      role: roleC.text,
                      startDate: _formatDateForApi(fromC.text),
                      endDate: _formatDateForApi(toC.text),
                      allocation: double.tryParse(allocationC.text),
                      status: status,
                    );
                  } else {
                    updatedList.add(ProfileProjectAssignmentEntity(
                      projectName: projectC.text,
                      projectLead: leadC.text,
                      role: roleC.text,
                      startDate: _formatDateForApi(fromC.text),
                      endDate: _formatDateForApi(toC.text),
                      allocation: double.tryParse(allocationC.text),
                      status: status,
                    ));
                  }
                  
                  final jsonList = updatedList.map((e) => {
                    "project_name": e.projectName,
                    if (e.projectLead != null && e.projectLead!.isNotEmpty) "report_to_name": e.projectLead,
                    if (e.role != null && e.role!.isNotEmpty) "role": e.role,
                    if (e.startDate != null && e.startDate!.isNotEmpty) "start_date": e.startDate,
                    if (e.endDate != null && e.endDate!.isNotEmpty) "end_date": e.endDate,
                    if (e.allocation != null) "allocation": e.allocation,
                    if (e.status != null && e.status!.isNotEmpty) "status": e.status,
                  }).toList();

                  context.read<ProfileBloc>().add(
                        ProfileEvent.projectAssignmentsUpdateRequested(
                          assignmentsJson: jsonEncode(jsonList),
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
"""

    content = content[:start_idx] + correct_dialog
    with open('lib/features/profile/presentation/widgets/professional/employee_project_assignments_content.dart', 'w', encoding='utf-8') as f:
        f.write(content)

fix_content()
