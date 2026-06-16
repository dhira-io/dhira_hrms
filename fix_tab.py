import re

def fix_profile_details():
    with open('lib/features/profile/presentation/widgets/profile_professional_details_tab.dart', 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 1. Add fields to _showAddProjectAssignmentDialog
    target1 = '''  void _showAddProjectAssignmentDialog(BuildContext context, profile) {
    final projectC = TextEditingController();
    final leadC = TextEditingController();
    final formKey = GlobalKey<FormState>();'''
    
    repl1 = '''  void _showAddProjectAssignmentDialog(BuildContext context, profile) {
    final projectC = TextEditingController();
    final roleC = TextEditingController();
    final leadC = TextEditingController();
    final fromC = TextEditingController();
    final toC = TextEditingController();
    final allocationC = TextEditingController();
    String status = "Active";
    final formKey = GlobalKey<FormState>();'''
    
    content = content.replace(target1, repl1)
    
    # 2. Add Role, Start Date, End Date, Allocation, Status UI
    # We will insert them right after Project Lead.
    # Find the end of Project Lead Builder.
    
    # Lead block regex
    lead_block_regex = r'''(Builder\(\s*builder: \(context\) \{\s*return Autocomplete<SearchEmployeeModel>\([\s\S]*?hintText: "Search employee\.\.\.",[\s\S]*?return Align\([\s\S]*?;\s*\},?\s*\);\s*\},\s*\),)'''
    
    match = re.search(lead_block_regex, content)
    if match:
        lead_block = match.group(1)
        
        # We need to insert Role before Lead, and Dates/Allocation after Lead.
        # But wait, we want: Project Name -> Role -> Project Lead -> Dates
        # Let's find Project Name Builder
        project_name_regex = r'''(Builder\(\s*builder: \(context\) \{\s*return Autocomplete<String>\([\s\S]*?hintText: "Search project\.\.\.",[\s\S]*?return Align\([\s\S]*?;\s*\},?\s*\);\s*\},\s*\),)'''
        
        match_proj = re.search(project_name_regex, content)
        if match_proj:
            project_block = match_proj.group(1)
            
            role_block = '''
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
                ),'''
                
            dates_block = '''
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
                ),'''
            
            content = content.replace(project_block, project_block + role_block)
            content = content.replace(lead_block, lead_block + dates_block)
            
    # 3. Add to saving logic
    target_save = '''                  updatedList.add(ProfileProjectAssignmentEntity(
                    projectName: projectC.text,
                    projectLead: leadC.text,
                  ));
                  
                  final jsonList = updatedList.map((e) => {
                    "project_name": e.projectName,
                    if (e.projectLead != null && e.projectLead!.isNotEmpty) "report_to_name": e.projectLead,
                  }).toList();'''
                  
    repl_save = '''                  updatedList.add(ProfileProjectAssignmentEntity(
                    projectName: projectC.text,
                    role: roleC.text,
                    projectLead: leadC.text,
                    startDate: _formatDateForApi(fromC.text),
                    endDate: _formatDateForApi(toC.text),
                    allocation: double.tryParse(allocationC.text),
                    status: status,
                  ));
                  
                  final jsonList = updatedList.map((e) => {
                    "project_name": e.projectName,
                    if (e.projectLead != null && e.projectLead!.isNotEmpty) "report_to_name": e.projectLead,
                    if (e.role != null && e.role!.isNotEmpty) "role": e.role,
                    if (e.startDate != null && e.startDate!.isNotEmpty) "start_date": e.startDate,
                    if (e.endDate != null && e.endDate!.isNotEmpty) "end_date": e.endDate,
                    if (e.allocation != null) "allocation": e.allocation,
                    if (e.status != null && e.status!.isNotEmpty) "status": e.status,
                  }).toList();'''
    content = content.replace(target_save, repl_save)
    
    if not '_formatDateForApi' in content:
        content = content.replace('}\n\n', '''
  String _formatDateForApi(String dateStr) {
    if (dateStr.isEmpty) return "";
    final parts = dateStr.split('-');
    if (parts.length == 3 && parts[0].length == 2) {
      return "${parts[2]}-${parts[1]}-${parts[0]}";
    }
    return dateStr;
  }
}

''')

    with open('lib/features/profile/presentation/widgets/profile_professional_details_tab.dart', 'w', encoding='utf-8') as f:
        f.write(content)

fix_profile_details()
