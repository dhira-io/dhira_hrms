import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.avatarUpdateRequested({
    required String filePath,
  }) = _AvatarUpdateRequested;
  const factory ProfileEvent.passwordChangeRequested({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  }) = _PasswordChangeRequested;
  const factory ProfileEvent.profileDetailsUpdateRequested({
    required String companyEmail,
    required String phone,
    required String emergencyContact,
    required String currentAddress,
    required String permanentAddress,
  }) = _ProfileDetailsUpdateRequested;
}
