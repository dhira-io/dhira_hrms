class getemp_detailsModel {
  List<Data>? data;

  getemp_detailsModel({this.data});

  getemp_detailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? employeeName;
  String? departmentName;
  String? leaveapprover;

  Data({this.name, this.employeeName, this.departmentName, this.leaveapprover});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    employeeName = json['employee_name'];
    departmentName = json['custom_organization_department'];
    leaveapprover = json['leave_approver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['employee_name'] = this.employeeName;
    data['custom_organization_department'] = this.departmentName;
    data['leave_approver'] = this.leaveapprover;
    return data;
  }
}