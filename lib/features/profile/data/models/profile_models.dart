import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_entities.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String email,
    @JsonKey(name: 'desk_theme') String? deskTheme,
    @JsonKey(name: 'user_image') String? userImage,
    @JsonKey(name: 'birth_date') String? birthDate,
    String? gender,
  }) = _ProfileModel;

  const ProfileModel._();

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  ProfileEntity toEntity() {
    return ProfileEntity(
      fullName: fullName,
      firstName: firstName,
      lastName: lastName,
      email: email,
      deskTheme: deskTheme,
      userImage: userImage,
      birthDate: birthDate,
      gender: gender,
    );
  }
}
