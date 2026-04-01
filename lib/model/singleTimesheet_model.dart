class singleTimesheetModel {
  Data? data;

  singleTimesheetModel({this.data});

  singleTimesheetModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? employee;
  String? employeeName;
  String? organizationDepartment;
  String? approver;
  String? approverName;
  String? fromDate;
  String? toDate;
  int? approved;
  double? hoursTotal;
  double? expectedHoursTotal;
  double? remainingHours;
  double? totalSpentHours;
  String? doctype;
  List<ProjectAssignments>? projectAssignments;

  Data(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.employee,
        this.employeeName,
        this.organizationDepartment,
        this.approver,
        this.approverName,
        this.fromDate,
        this.toDate,
        this.approved,
        this.hoursTotal,
        this.expectedHoursTotal,
        this.remainingHours,
        this.totalSpentHours,
        this.doctype,
        this.projectAssignments});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
    name : json['name'],
    owner : json['owner'],
    creation : json['creation'],
    modified : json['modified'],
    modifiedBy : json['modified_by'],
    docstatus : json['docstatus'],
    idx : json['idx'],
    employee : json['employee'],
    employeeName : json['employee_name'],
    organizationDepartment : json['organization_department'],
    approver : json['approver'],
    approverName : json['approver_name'],
    fromDate : json['from_date'].toString(),
    toDate : json['to_date'].toString(),
    approved : json['approved'],
    hoursTotal : json['hours_total'],
    expectedHoursTotal : json['expected_hours_total'],
    remainingHours : json['remaining_hours'],
    totalSpentHours : json['total_spent_hours'],
    doctype : json['doctype'],
      projectAssignments: (json['project_assignments'] as List?)
          ?.map((v) => ProjectAssignments.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['employee'] = employee;
    data['employee_name'] = employeeName;
    data['organization_department'] = organizationDepartment;
    data['approver'] = approver;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['approved'] = approved;
    data['hours_total'] = hoursTotal;
    data['expected_hours_total'] = expectedHoursTotal;
    data['remaining_hours'] = remainingHours;
    data['total_spent_hours'] = totalSpentHours;
    data['doctype'] = doctype;
    if (projectAssignments != null) {
      data['project_assignments'] =
          projectAssignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectAssignments {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? project;
  String? date;
  String? hoursDetails;
  double? expectedHours;
  String? raisedBy;
  double? spentHours;
  int? completed;
  int? approved;
  int? applicableForCompensatoryOff;
  String? status;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  ProjectAssignments(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.project,
        this.date,
        this.hoursDetails,
        this.expectedHours,
        this.raisedBy,
        this.spentHours,
        this.completed,
        this.approved,
        this.applicableForCompensatoryOff,
        this.status,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.doctype});

  factory ProjectAssignments.fromJson(Map<String, dynamic> json) {
    return ProjectAssignments(
      name : json['name'],
      owner : json['owner'],
      creation : json['creation'],
      modified : json['modified'],
      modifiedBy : json['modified_by'],
      docstatus : json['docstatus'],
      idx : json['idx'],
      project : json['project'],
      date : json['date'],
      hoursDetails : json['hours_details'],
      expectedHours : json['expected_hours'],
      raisedBy : json['raised_by'],
      spentHours : json['spent_hours'],
      completed : json['completed'],
      approved : json['approved'],
      applicableForCompensatoryOff : json['applicable_for_compensatory_off'],
      status : json['status'],
      parent : json['parent'],
      parentfield : json['parentfield'],
      parenttype : json['parenttype'],
      doctype : json['doctype'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['project'] = project;
    data['date'] = date;
    data['hours_details'] = hoursDetails;
    data['expected_hours'] = expectedHours;
    data['raised_by'] = raisedBy;
    data['spent_hours'] = spentHours;
    data['completed'] = completed;
    data['approved'] = approved;
    data['applicable_for_compensatory_off'] = applicableForCompensatoryOff;
    data['status'] = status;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}
