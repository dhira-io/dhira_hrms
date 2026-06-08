import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_entity.freezed.dart';

@freezed
abstract class ResumeEntity with _$ResumeEntity {
  const factory ResumeEntity({
    @Default('') String employee,
    @Default('') String employeeName,
    @Default('') String designation,
    @Default('') String company,
    @Default('') String department,
    @Default('') String companyEmail,
    @Default('') String cellNumber,
    @Default('') String dateOfJoining,
    @Default('') String image,
    @Default('') String nationality,
    @Default('') String currentLocation,
    @Default('') String professionalSummary,
    @Default('') String awardsAndAchievements,
    @Default([]) List<ResumeSkillEntity> skills,
    @Default([]) List<ResumeWorkExperienceEntity> workExperience,
    @Default([]) List<ResumeProjectEntity> projects,
    @Default([]) List<ResumeLanguageEntity> languages,
    @Default([]) List<ResumeEducationEntity> education,
    @Default([]) List<ResumeCertificationEntity> certifications,
    @Default([]) List<ResumeConsultingExperienceEntity> consultingExperience,
  }) = _ResumeEntity;
}

@freezed
abstract class ResumeSkillEntity with _$ResumeSkillEntity {
  const factory ResumeSkillEntity({
    @Default('') String name,
    @Default('') String skill,
    @Default('') String proficiency,
    @Default(0) double yearsOfExperience,
    @Default(0) int displayOrder,
    @Default([]) List<ResumeSubSkillEntity> subSkills,
  }) = _ResumeSkillEntity;
}

@freezed
abstract class ResumeWorkExperienceEntity with _$ResumeWorkExperienceEntity {
  const factory ResumeWorkExperienceEntity({
    @Default('') String name,
    @Default('') String companyName,
    @Default('') String designation,
    @Default('') String customFromDate,
    @Default('') String customToDate,
    @Default(false) bool currentlyWorking,
    @Default('') String customAssignmentSummary,
    @Default('') String customKeyResponsibilities,
    @Default('') String customKeyAchievements,
    @Default(false) bool customCurrentlyWorking,
    @Default('') String customEmploymentType,
    @Default(0) int displayOrder,
  }) = _ResumeWorkExperienceEntity;
}

@freezed
abstract class ResumeProjectEntity with _$ResumeProjectEntity {
  const factory ResumeProjectEntity({
    @Default('') String name,
    @Default(0) int displayOrder,
  }) = _ResumeProjectEntity;
}

@freezed
abstract class ResumeLanguageEntity with _$ResumeLanguageEntity {
  const factory ResumeLanguageEntity({
    @Default('') String name,
    @Default('') String language,
    @Default('') String speaking,
    @Default('') String reading,
    @Default('') String writing,
    @Default(0) int displayOrder,
  }) = _ResumeLanguageEntity;
}

@freezed
abstract class ResumeEducationEntity with _$ResumeEducationEntity {
  const factory ResumeEducationEntity({
    @Default('') String name,
    @Default('') String schoolUniv,
    @Default('') String qualification,
    @Default('') String yearOfPassing,
    @Default('') String level,
    @Default(0) int displayOrder,
  }) = _ResumeEducationEntity;
}

@freezed
abstract class ResumeCertificationEntity with _$ResumeCertificationEntity {
  const factory ResumeCertificationEntity({
    @Default('') String name,
    @Default('') String certificationName,
    @Default('') String issuingInstitute,
    @Default('') String yearObtained,
    @Default('') String certificationUrl,
    @Default(0) int displayOrder,
  }) = _ResumeCertificationEntity;
}

@freezed
abstract class ResumeConsultingExperienceEntity with _$ResumeConsultingExperienceEntity {
  const factory ResumeConsultingExperienceEntity({
    @Default('') String name,
    @Default('') String parentCompany,
    @Default('') String clientName,
    @Default('') String project,
    @Default('') String fromDate,
    @Default('') String toDate,
    @Default('') String duration,
    @Default('') String projectOverview,
    @Default('') String businessImpact,
    @Default('') String toolsAndTechnologies,
    @Default('') String customRole,
    @Default('') String customProjectLead,
    @Default('') String customAllocation,
    @Default('') String customStatus,
    @Default(0) int displayOrder,
  }) = _ResumeConsultingExperienceEntity;
}

@freezed
abstract class SubSkillEntity with _$SubSkillEntity {
  const factory SubSkillEntity({
    @Default('') String name,
    @Default('') String skillName,
  }) = _SubSkillEntity;
}

@freezed
abstract class ResumeSubSkillEntity with _$ResumeSubSkillEntity {
  const factory ResumeSubSkillEntity({
    @Default('') String name,
    @Default('') String subSkill,
    @Default(0.0) double rating,
    @Default('') String parentSkill,
  }) = _ResumeSubSkillEntity;
}
