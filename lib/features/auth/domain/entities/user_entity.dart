import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String fullName,
    required String email,
    required String empId,
    String? department,
    String? userImage,
    String? approver,
    String? gender,
  }) = _UserEntity;

  const UserEntity._();
}
