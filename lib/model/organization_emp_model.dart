class OrganizationEmpModel {
  Message? message;

  OrganizationEmpModel({this.message});

  OrganizationEmpModel.fromJson(Map<String, dynamic> json) {
    message =
    json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  bool? success;
  String? message;
  Data? data;
  int? totalEmployees;

  Message({this.success, this.message, this.data, this.totalEmployees});

  Message.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    totalEmployees = json['total_employees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total_employees'] = totalEmployees;
    return data;
  }
}

class Data {
  String? employeeId;
  String? profileImage;
  String? name;
  String? role;
  String? department;
  int? totalTeam;
  int? directReports;
  int? indexNumber;
  int? divisionHead;
  List<Data>? subEmployees;

  Data(
      {this.employeeId,
        this.profileImage,
        this.name,
        this.role,
        this.department,
        this.totalTeam,
        this.directReports,
        this.indexNumber,
        this.divisionHead,
        this.subEmployees = const [],
      });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      employeeId: json['employeeId'],
      profileImage: json['profileImage'],
      name: json['name'],
      role: json['role'],
      department: json['department'],
      totalTeam: json['totalTeam'],
      directReports: json['directReports'],
      indexNumber: json['indexNumber'],
      divisionHead: json['divisionHead'],
      subEmployees: json['subEmployees'] != null
          ? List<Data>.from(
        (json['subEmployees'] as List)
            .map((e) => Data.fromJson(e)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeId'] = employeeId;
    data['profileImage'] = profileImage;
    data['name'] = name;
    data['role'] = role;
    data['department'] = department;
    data['totalTeam'] = totalTeam;
    data['directReports'] = directReports;
    data['indexNumber'] = indexNumber;
    data['divisionHead'] = divisionHead;
    if (subEmployees != null) {
      data['subEmployees'] = subEmployees!.map((v) => v.toJson()).toList();
    }
    return data;
  }

/*  Data.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    profileImage = json['profileImage'];
    name = json['name'];
    role = json['role'];
    department = json['department'];
    totalTeam = json['totalTeam'];
    directReports = json['directReports'];
    indexNumber = json['indexNumber'];
    divisionHead = json['divisionHead'];
    if (json['subEmployees'] != null) {
      subEmployees = <SubEmployees>[];
      json['subEmployees'].forEach((v) {
        subEmployees!.add(SubEmployees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    data['profileImage'] = this.profileImage;
    data['name'] = this.name;
    data['role'] = this.role;
    data['department'] = this.department;
    data['totalTeam'] = this.totalTeam;
    data['directReports'] = this.directReports;
    data['indexNumber'] = this.indexNumber;
    data['divisionHead'] = this.divisionHead;
    if (this.subEmployees != null) {
      data['subEmployees'] = this.subEmployees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  */
}

/*
class SubEmployees {
  String? employeeId;
  String? profileImage;
  String? name;
  String? role;
  String? department;
  int? totalTeam;
  int? directReports;
  int? indexNumber;
  int? divisionHead;
  List<SubEmployees>? subEmployees;

  SubEmployees(
      {this.employeeId,
        this.profileImage,
        this.name,
        this.role,
        this.department,
        this.totalTeam,
        this.directReports,
        this.indexNumber,
        this.divisionHead,
        this.subEmployees});

  SubEmployees.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    profileImage = json['profileImage'];
    name = json['name'];
    role = json['role'];
    department = json['department'];
    totalTeam = json['totalTeam'];
    directReports = json['directReports'];
    indexNumber = json['indexNumber'];
    divisionHead = json['divisionHead'];
    if (json['subEmployees'] != null) {
      subEmployees = <SubEmployees>[];
      json['subEmployees'].forEach((v) {
        subEmployees!.add(SubEmployees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    data['profileImage'] = this.profileImage;
    data['name'] = this.name;
    data['role'] = this.role;
    data['department'] = this.department;
    data['totalTeam'] = this.totalTeam;
    data['directReports'] = this.directReports;
    data['indexNumber'] = this.indexNumber;
    data['divisionHead'] = this.divisionHead;
    if (this.subEmployees != null) {
      data['subEmployees'] = this.subEmployees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}*/
