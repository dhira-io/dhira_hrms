class SearchEmployeeModel {
  final String value;
  final String label;
  final String designation;
  final String department;

  SearchEmployeeModel({
    required this.value,
    required this.label,
    required this.designation,
    required this.department,
  });

  factory SearchEmployeeModel.fromJson(Map<String, dynamic> json) {
    return SearchEmployeeModel(
      value: json['value'] ?? '',
      label: json['label'] ?? '',
      designation: json['designation'] ?? '',
      department: json['department'] ?? '',
    );
  }
}
