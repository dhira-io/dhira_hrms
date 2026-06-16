import re

def fix_file(file_path, is_edit):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Controllers
    if is_edit:
        # Replace leadC
        content = re.sub(
            r'final leadC = TextEditingController\(text: proj\.projectLead \?\? ""\);',
            r'final leadIdC = TextEditingController(text: proj.reportTo ?? "");\n      final leadNameC = TextEditingController(text: proj.projectLead ?? "");',
            content
        )
    else:
        content = re.sub(
            r'final leadC = TextEditingController\(\);',
            r'final leadIdC = TextEditingController();\n      final leadNameC = TextEditingController();',
            content
        )

    # 2. ApiDropdownField for PROJECT LEAD
    # Find the ApiDropdownField for SearchEmployeeModel
    if is_edit:
        lead_dropdown = """ApiDropdownField<SearchEmployeeModel>(
                  labelText: "PROJECT LEAD",
                  hintText: "Select project lead",
                  initialValue: proj.reportTo?.isNotEmpty == true ? SearchEmployeeModel(value: proj.reportTo!, label: proj.projectLead ?? proj.reportTo!, designation: "", department: "") : null,
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
                ),"""
    else:
        lead_dropdown = """ApiDropdownField<SearchEmployeeModel>(
                  labelText: "PROJECT LEAD",
                  hintText: "Select project lead",
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
                ),"""

    content = re.sub(
        r'ApiDropdownField<SearchEmployeeModel>\(.*?\n\s*\}\,\n\s*\),',
        lead_dropdown,
        content,
        flags=re.DOTALL
    )

    # 3. ProfileProjectAssignmentEntity mapping
    content = re.sub(
        r'projectLead:\s*leadC\.text,',
        r'projectLead: leadNameC.text,\n                      reportTo: leadIdC.text,',
        content
    )

    # 4. jsonList mapping
    json_mapping_old = r'if \(e\.projectLead != null && e\.projectLead!\.isNotEmpty\) "report_to_name": e\.projectLead,'
    json_mapping_new = 'if (e.reportTo != null && e.reportTo!.isNotEmpty) "report_to": e.reportTo,\n                    if (e.projectLead != null && e.projectLead!.isNotEmpty) "report_to_name": e.projectLead,'
    
    content = re.sub(json_mapping_old, json_mapping_new, content)

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

if __name__ == '__main__':
    fix_file('lib/features/profile/presentation/widgets/professional/employee_project_assignments_content.dart', True)
    fix_file('lib/features/profile/presentation/widgets/profile_professional_details_tab.dart', False)
