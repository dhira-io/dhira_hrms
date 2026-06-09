import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_entities.dart';
import '../../domain/entities/resume_entity.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.uploading(ProfileEntity profile, [ResumeEntity? resume]) = _Uploading;
  const factory ProfileState.loaded(ProfileEntity profile, [ResumeEntity? resume]) = _Loaded;
  const factory ProfileState.success(String message, {ProfileEntity? profile, ResumeEntity? resume}) = _Success;
  const factory ProfileState.error(String message, {ProfileEntity? profile, ResumeEntity? resume}) = _Error;
}

extension ProfileStateX on ProfileState {
  ProfileEntity? get profile => maybeMap(
        loaded: (s) => s.profile,
        uploading: (s) => s.profile,
        success: (s) => s.profile,
        error: (s) => s.profile,
        orElse: () => null,
      );

  ResumeEntity? get resume => maybeMap(
        loaded: (s) => s.resume,
        uploading: (s) => s.resume,
        success: (s) => s.resume,
        error: (s) => s.resume,
        orElse: () => null,
      );

  int get profileCompletionPercentage {
    int score = 0;
    final p = profile;
    final r = resume;

    if (p != null) {
      if ((p.employee?.isNotEmpty ?? false) || (p.empId?.isNotEmpty ?? false)) score += 5;
      if (p.fullName.isNotEmpty) score += 5;
      if ((p.companyEmail?.isNotEmpty ?? false)) score += 5;
      if ((p.phone?.isNotEmpty ?? false)) score += 5;
      if ((p.designation?.isNotEmpty ?? false)) score += 5;
      if ((p.department?.isNotEmpty ?? false)) score += 5;
    }

    if (r != null) {
      if (r.professionalSummary.isNotEmpty) score += 10;
      if (r.skills.isNotEmpty) score += 10;
      if (r.workExperience.isNotEmpty) score += 15;
      if (r.consultingExperience.isNotEmpty) score += 10;
      if (r.education.isNotEmpty) score += 10;
      if (r.certifications.isNotEmpty) score += 5;
      if (r.languages.isNotEmpty) score += 10;
    }

    return score > 100 ? 100 : score;
  }

  int get resumeCompletionPercentage {
    int score = 0;
    int total = 7;
    final r = resume;

    if (r != null) {
      if (r.professionalSummary.isNotEmpty) score++;
      if (r.skills.isNotEmpty) score++;
      if (r.workExperience.isNotEmpty) score++;
      if (r.consultingExperience.isNotEmpty) score++;
      if (r.languages.isNotEmpty) score++;
      if (r.certifications.isNotEmpty) score++;
      if (r.education.isNotEmpty) score++;
    }

    return ((score / total) * 100).toInt();
  }
}
