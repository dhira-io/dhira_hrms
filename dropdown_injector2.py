import re

api_dropdown_class = """

class ApiDropdownField<T> extends StatefulWidget {
  final Future<List<T>> Function() fetcher;
  final String Function(T) displayStringForOption;
  final String labelText;
  final String hintText;
  final T? initialValue;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const ApiDropdownField({
    Key? key,
    required this.fetcher,
    required this.displayStringForOption,
    required this.labelText,
    required this.hintText,
    this.initialValue,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  _ApiDropdownFieldState<T> createState() => _ApiDropdownFieldState<T>();
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
        final match = items.where((e) => widget.displayStringForOption(e) == widget.displayStringForOption(_selectedValue as T)).toList();
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
          hintText: "Loading...",
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
"""

def replace_edit_dialog():
    file_path = 'lib/features/profile/presentation/widgets/professional/employee_project_assignments_content.dart'
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

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
    
    if "class ApiDropdownField" not in content:
        content += api_dropdown_class

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

def replace_add_dialog():
    file_path = 'lib/features/profile/presentation/widgets/profile_professional_details_tab.dart'
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # The add dialog doesn't have initialValue for String Autocompletes
    # It has SearchProjectsUseCase inside
    project_builder_pattern = r'Builder\(\s*builder: \(context\) \{\s*return Autocomplete<String>\(\s*optionsBuilder: \(TextEditingValue textEditingValue\) async \{\s*final useCase = Get\.find<SearchProjectsUseCase>\(\);.*?optionsViewBuilder.*?\}\s*\);\s*\},\s*\),'
    project_dropdown = """ApiDropdownField<String>(
                  labelText: "PROJECT NAME",
                  hintText: "Select project",
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
    
    role_builder_pattern = r'Builder\(\s*builder: \(context\) \{\s*return Autocomplete<String>\(\s*optionsBuilder: \(TextEditingValue textEditingValue\) async \{\s*final useCase = Get\.find<SearchDesignationsUseCase>\(\);.*?optionsViewBuilder.*?\}\s*\);\s*\},\s*\),'
    role_dropdown = """ApiDropdownField<String>(
                  labelText: "ROLE",
                  hintText: "Select role",
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
    
    lead_builder_pattern = r'Builder\(\s*builder: \(context\) \{\s*return Autocomplete<SearchEmployeeModel>\(\s*displayStringForOption: \(option\) => option\.label,\s*optionsBuilder: \(TextEditingValue textEditingValue\) async \{\s*final useCase = Get\.find<SearchEmployeesUseCase>\(\);.*?optionsViewBuilder.*?\}\s*\);\s*\},\s*\),'
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
                    if (val != null) leadC.text = val.value;
                  },
                ),"""
    content = re.sub(lead_builder_pattern, lead_dropdown, content, flags=re.DOTALL)
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

replace_edit_dialog()
replace_add_dialog()
