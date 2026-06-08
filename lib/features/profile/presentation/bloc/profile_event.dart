import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../l10n/app_localizations.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.avatarUpdateRequested({required String filePath}) =
      _AvatarUpdateRequested;
  const factory ProfileEvent.avatarDeleteRequested() = _AvatarDeleteRequested;
  const factory ProfileEvent.passwordChangeRequested({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  }) = _PasswordChangeRequested;
  const factory ProfileEvent.profileDetailsUpdateRequested({
    required String personalEmail,
    required String phone,
    required String emergencyContact,
    String? emergencyContactName,
    String? nationality,
    required String currentAddress,
    required String permanentAddress,
    String? currentLocation,
    String? dateOfBirth,
  }) = _ProfileDetailsUpdateRequested;
  const factory ProfileEvent.resumeRowUpsertRequested({
    required String section,
    required String rowDataJson,
    String? rowName,
  }) = _ResumeRowUpsertRequested;
  const factory ProfileEvent.resumeRowDeleteRequested({
    required String section,
    required String rowName,
  }) = _ResumeRowDeleteRequested;
  const factory ProfileEvent.resumeUpdateRequested({
    required String resumeDataJson,
    required String subSkillsJson,
  }) = _ResumeUpdateRequested;
  const factory ProfileEvent.downloadResumeRequested({
    required String empId,
    required AppLocalizations l10n,
  }) = _DownloadResumeRequested;
  const factory ProfileEvent.projectAssignmentsUpdateRequested({
    required String assignmentsJson,
  }) = _ProjectAssignmentsUpdateRequested;
}
