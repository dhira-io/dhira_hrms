import json

def inject_add_dialog():
    with open('lib/features/profile/presentation/widgets/professional/employee_project_assignments_content.dart', 'r', encoding='utf-8') as f:
        source = f.read()
        
    start_idx = source.find('  void _showEditProjectAssignmentDialog(')
    end_idx = source.find('  String _formatDateForApi')
    
    dialog_code = source[start_idx:end_idx]
    
    # Convert Edit to Add
    dialog_code = dialog_code.replace('void _showEditProjectAssignmentDialog(BuildContext context, ProfileProjectAssignmentEntity proj)', 'void _showAddProjectAssignmentDialog(BuildContext context, dynamic profile)')
    
    dialog_code = dialog_code.replace('final projectC = TextEditingController(text: proj.projectName);', 'final projectC = TextEditingController();')
    dialog_code = dialog_code.replace('final roleC = TextEditingController(text: proj.role ?? "");', 'final roleC = TextEditingController();')
    dialog_code = dialog_code.replace('final leadC = TextEditingController(text: proj.projectLead ?? "");', 'final leadC = TextEditingController();')
    dialog_code = dialog_code.replace('final fromC = TextEditingController(text: _formatDateForUi(proj.startDate ?? ""));', 'final fromC = TextEditingController();')
    dialog_code = dialog_code.replace('final toC = TextEditingController(text: _formatDateForUi(proj.endDate ?? ""));', 'final toC = TextEditingController();')
    dialog_code = dialog_code.replace('final allocationC = TextEditingController(text: proj.allocation?.toString() ?? "");', 'final allocationC = TextEditingController();')
    dialog_code = dialog_code.replace('String status = proj.status?.isNotEmpty == true ? proj.status! : "Active";', 'String status = "Active";')
    
    dialog_code = dialog_code.replace('title: "Edit Project Assignment",', 'title: "Add Project Assignment",')
    
    import re
    dialog_code = re.sub(r'initialValue: TextEditingValue\(text: proj\.projectName\),', '', dialog_code)
    dialog_code = re.sub(r'initialValue: TextEditingValue\(text: proj\.role \?\? ""\),', '', dialog_code)
    dialog_code = re.sub(r'initialValue: TextEditingValue\(text: proj\.projectLead \?\? ""\),', '', dialog_code)
    
    # Save logic replace
    save_start = dialog_code.find('                  final updatedList = ')
    save_end = dialog_code.find('                  final jsonList =')
    
    new_save_logic = """                  final updatedList = List<ProfileProjectAssignmentEntity>.from(profile.projectAssignments ?? []);
                  updatedList.add(ProfileProjectAssignmentEntity(
                    projectName: projectC.text,
                    projectLead: leadC.text,
                    role: roleC.text,
                    startDate: _formatDateForApi(fromC.text),
                    endDate: _formatDateForApi(toC.text),
                    allocation: double.tryParse(allocationC.text),
                    status: status,
                  ));
                  
"""
    dialog_code = dialog_code[:save_start] + new_save_logic + dialog_code[save_end:]
    
    with open('lib/features/profile/presentation/widgets/profile_professional_details_tab.dart', 'r', encoding='utf-8') as f:
        target = f.read()
        
    target_insert_idx = target.rfind('}')
    
    insert_code = dialog_code + """

  String _formatDateForApi(String dateStr) {
    if (dateStr.isEmpty) return "";
    final parts = dateStr.split('-');
    if (parts.length == 3 && parts[0].length == 2) {
      return "${parts[2]}-${parts[1]}-${parts[0]}";
    }
    return dateStr;
  }
}
"""

    new_target = target[:target_insert_idx] + insert_code
    
    with open('lib/features/profile/presentation/widgets/profile_professional_details_tab.dart', 'w', encoding='utf-8') as f:
        f.write(new_target)

inject_add_dialog()
