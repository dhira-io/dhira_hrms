import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'employee_name') String? employeeName,
    @JsonKey(name: 'full_name') String? fullName,
    String? email,
    @JsonKey(name: 'name') required String empId,
    @JsonKey(name: 'custom_organization_department') String? department,
    @JsonKey(name: 'user_image') String? userImage,
    @JsonKey(name: 'leave_approver') String? approver,
    String? gender,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // Conversion from Data Model to Domain Entity
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName ?? employeeName ?? "Unknown",
      email: email ?? "",
      empId: empId,
      department: department,
      userImage: userImage,
      approver: approver,
      gender: gender,
    );
  }
}
