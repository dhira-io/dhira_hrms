import re

def main():
    file_path = 'lib/features/profile/presentation/widgets/professional/employee_project_assignments_content.dart'
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find the _showEditProjectAssignmentDialog function
    # It has 3 Builder widgets containing Autocomplete
    
    # Let's replace the first Builder block (PROJECT NAME)
    project_builder_pattern = r'Builder\(\s*builder: \(context\) \{\s*return Autocomplete<String>\(\s*initialValue: TextEditingValue\(text: proj\.projectName\),.*?optionsViewBuilder.*?\}\s*\);\s*\},\s*\),'
    
    project_dropdown = """ApiDropdownField<String>(
                  labelText: "PROJECT NAME",
                  hintText: "Select project",
                  initialValue: proj.projectName?.isEmpty == true ? null : proj.projectName,
                  fetcher: () async {
                    final useCase = Get.find<SearchProjectsUseCase>();
                    final result = await useCase("");
                    return result.fold((f) => [], (projects) => projects);
                  },
                  displayStringForOption: (option) => option,
                  onChanged: (val) {
                    if (val != null) projectC.text = val;
                  },
                  validator: requiredValidator,
                ),"""
                
    content = re.sub(project_builder_pattern, project_dropdown, content, flags=re.DOTALL)
    
    # Replace second Builder block (ROLE)
    role_builder_pattern = r'Builder\(\s*builder: \(context\) \{\s*return Autocomplete<String>\(\s*initialValue: TextEditingValue\(text: proj\.role \?\? ""\),.*?optionsViewBuilder.*?\}\s*\);\s*\},\s*\),'
    
    role_dropdown = """ApiDropdownField<String>(
                  labelText: "ROLE",
                  hintText: "Select role",
                  initialValue: proj.role?.isEmpty == true ? null : proj.role,
                  fetcher: () async {
                    final useCase = Get.find<SearchDesignationsUseCase>();
                    final result = await useCase("");
                    return result.fold((f) => [], (roles) => roles);
                  },
                  displayStringForOption: (option) => option,
                  onChanged: (val) {
                    if (val != null) roleC.text = val;
                  },
                ),"""
                
    content = re.sub(role_builder_pattern, role_dropdown, content, flags=re.DOTALL)
    
    # Replace third Builder block (PROJECT LEAD)
    lead_builder_pattern = r'Builder\(\s*builder: \(context\) \{\s*return Autocomplete<SearchEmployeeModel>\(\s*initialValue: TextEditingValue\(text: proj\.projectLead \?\? ""\),.*?optionsViewBuilder.*?\}\s*\);\s*\},\s*\),'
    
    lead_dropdown = """ApiDropdownField<SearchEmployeeModel>(
                  labelText: "PROJECT LEAD",
                  hintText: "Select project lead",
                  initialValue: proj.projectLead?.isEmpty == true ? null : SearchEmployeeModel(value: proj.projectLead!, label: proj.projectLead!, designation: "", department: ""),
                  fetcher: () async {
                    final useCase = Get.find<SearchEmployeesUseCase>();
                    final result = await useCase("");
                    return result.fold((f) => [], (emps) => emps);
                  },
                  displayStringForOption: (option) => option.label,
                  onChanged: (val) {
                    if (val != null) leadC.text = val.value;
                  },
                ),"""
                
    content = re.sub(lead_builder_pattern, lead_dropdown, content, flags=re.DOTALL)
    
    # Now for the ADD dialog: _showAddProjectAssignmentDialog
    
    add_project_builder_pattern = r'Builder\(\s*builder: \(context\) \{\s*return Autocomplete<String>\(\s*optionsBuilder:.*?optionsViewBuilder.*?\}\s*\);\s*\},\s*\),'
    
    # Notice Add dialog lacks initialValue for Autocomplete so regex is different
    # We can replace them sequentially or using slightly looser regexes.
    
    # Wait, the add dialog is inside profile_professional_details_tab.dart
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

if __name__ == '__main__':
    main()
