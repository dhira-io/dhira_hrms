import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entities.freezed.dart';

@freezed
abstract class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String fullName,
    required String firstName,
    required String lastName,
    required String email,
    String? deskTheme,
    String? userImage,
    String? birthDate,
    String? gender,
  }) = _ProfileEntity;

  const ProfileEntity._();
}
