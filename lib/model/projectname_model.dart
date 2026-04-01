class ProjectNameModel {
  final String name;
  final String projectName;
  final String status;
  final String? expectedStartDate;
  final String? expectedEndDate;

  ProjectNameModel({
    required this.name,
    required this.projectName,
    required this.status,
    this.expectedStartDate,
    this.expectedEndDate,
  });

  factory ProjectNameModel.fromJson(Map<String, dynamic> json) {
    return ProjectNameModel(
      name: json['name'] ?? '',
      projectName: json['project_name'] ?? '',
      status: json['status'] ?? '',
      expectedStartDate: json['expected_start_date'],
      expectedEndDate: json['expected_end_date'],
    );
  }
}
