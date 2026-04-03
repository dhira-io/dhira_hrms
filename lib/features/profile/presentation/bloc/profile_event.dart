import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started(String email) = _Started;
  const factory ProfileEvent.avatarUpdateRequested({
    required String filePath,
    required String email,
  }) = _AvatarUpdateRequested;
  const factory ProfileEvent.passwordChangeRequested({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  }) = _PasswordChangeRequested;
}
