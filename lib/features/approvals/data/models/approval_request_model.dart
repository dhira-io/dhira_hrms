// lib/features/approvals/data/models/approval_request_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approval_request_entity.dart';

part 'approval_request_model.freezed.dart';
part 'approval_request_model.g.dart';

@freezed
class ApprovalRequestModel with _$ApprovalRequestModel {
  // Redirect to the concrete generated class [_ApprovalRequestModel]
  const factory ApprovalRequestModel({
    required String name,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'designation') String? employeeRole,
    @JsonKey(name: 'image') String? profileImage,
    @JsonKey(name: 'leave_type') String? leaveType,
    @JsonKey(name: 'attendance_date') String? attendanceDate,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
    @JsonKey(name: 'total_leave_days') double? duration,
    required String status,
  }) = _ApprovalRequestModel;

  // This private constructor is MANDATORY to allow custom methods like toEntity()
  const ApprovalRequestModel._();

  factory ApprovalRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ApprovalRequestModelFromJson(json);

  /// Maps the Data Model to your pure ApprovalRequestEntity
  ApprovalRequestEntity toEntity() {
    return ApprovalRequestEntity(
      id: name,
      employeeName: employeeName,
      employeeRole: employeeRole ?? '',
      profileImage: profileImage,
      requestType: leaveType ?? '',
      dateRange: fromDate != null ? '$fromDate - $toDate' : (attendanceDate ?? ''),
      duration: duration != null ? '${duration!.toInt()} Day' : '',
      status: status,
    );
  }

  @override
  // TODO: implement attendanceDate
  String? get attendanceDate => throw UnimplementedError();

  @override
  // TODO: implement duration
  double? get duration => throw UnimplementedError();

  @override
  // TODO: implement employeeName
  String get employeeName => throw UnimplementedError();

  @override
  // TODO: implement employeeRole
  String? get employeeRole => throw UnimplementedError();

  @override
  // TODO: implement fromDate
  String? get fromDate => throw UnimplementedError();

  @override
  // TODO: implement leaveType
  String? get leaveType => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  // TODO: implement profileImage
  String? get profileImage => throw UnimplementedError();

  @override
  // TODO: implement status
  String get status => throw UnimplementedError();

  @override
  // TODO: implement toDate
  String? get toDate => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}