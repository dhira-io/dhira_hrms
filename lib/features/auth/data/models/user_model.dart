import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    @JsonKey(name: 'name') required String empId,
    @JsonKey(name: 'department') String? department,
    @JsonKey(name: 'user_image') String? userImage,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // Conversion from Data Model to Domain Entity
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName,
      email: email,
      empId: empId,
      department: department,
      userImage: userImage,
    );
  }
}
