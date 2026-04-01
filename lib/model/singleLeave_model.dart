class singleLeaveModel {
  Data? data;

  singleLeaveModel({this.data});

  singleLeaveModel.fromJson(Map<String, dynamic> json) {
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
  String? namingSeries;
  String? employee;
  String? employeeName;
  String? leaveType;
  String? company;
  String? department;
  String? fromDate;
  String? toDate;
  int? halfDay;
  String? halfDayDate;
  double? totalLeaveDays;
  String? description;
  double? leaveBalance;
  int? followViaEmail;
  String? postingDate;
  String? status;
  String? doctype;

  Data(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.namingSeries,
        this.employee,
        this.employeeName,
        this.leaveType,
        this.company,
        this.department,
        this.fromDate,
        this.toDate,
        this.halfDay,
        this.halfDayDate,
        this.totalLeaveDays,
        this.description,
        this.leaveBalance,
        this.followViaEmail,
        this.postingDate,
        this.status,
        this.doctype});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    namingSeries = json['naming_series'];
    employee = json['employee'];
    employeeName = json['employee_name'];
    leaveType = json['leave_type'];
    company = json['company'];
    department = json['department'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    halfDay = json['half_day'];
    halfDayDate = json['half_day_date'];
    totalLeaveDays = json['total_leave_days'];
    description = json['description'];
    leaveBalance = json['leave_balance'];
    followViaEmail = json['follow_via_email'];
    postingDate = json['posting_date'];
    status = json['status'];
    doctype = json['doctype'];
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
    data['naming_series'] = namingSeries;
    data['employee'] = employee;
    data['employee_name'] = employeeName;
    data['leave_type'] = leaveType;
    data['company'] = company;
    data['department'] = department;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['half_day'] = halfDay;
    data['half_day_date'] = halfDayDate;
    data['total_leave_days'] = totalLeaveDays;
    data['description'] = description;
    data['leave_balance'] = leaveBalance;
    data['follow_via_email'] = followViaEmail;
    data['posting_date'] = postingDate;
    data['status'] = status;
    data['doctype'] = doctype;
    return data;
  }
}
