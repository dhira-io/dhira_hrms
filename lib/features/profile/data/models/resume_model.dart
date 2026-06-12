import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/resume_entity.dart';

part 'resume_model.freezed.dart';
part 'resume_model.g.dart';

double? _parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) {
    if (value.isEmpty) return null;
    return double.tryParse(value);
  }
  return null;
}

List<dynamic> _readSubSkills(Map<dynamic, dynamic> json, String key) {
  final keysToCheck = [
    'custom_sub_skill',
    'sub_skills',
    'custom_sub_skills',
    'subSkills',
    'customSubSkills'
  ];

  for (final k in keysToCheck) {
    if (json[k] != null) {
      final value = json[k];
      if (value is List) {
        return value;
      } else if (value is String) {
        try {
          final decoded = jsonDecode(value);
          if (decoded is List) return decoded;
        } catch (_) {}
      }
    }
  }
  return [];
}

int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toInt();
  if (value is String) {
    if (value.isEmpty) return null;
    return int.tryParse(value);
  }
  return null;
}

bool? _parseBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) {
    if (value == '1' || value.toLowerCase() == 'true') return true;
    if (value == '0' || value.toLowerCase() == 'false') return false;
  }
  return null;
}

String _unescapeHtml(String str) {
  return str
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>');
}

@freezed
abstract class ResumeModel with _$ResumeModel {
  const factory ResumeModel({
    @JsonKey(name: 'employee') String? employee,
    @JsonKey(name: 'employee_name') String? employeeName,
    @JsonKey(name: 'designation') String? designation,
    @JsonKey(name: 'company') String? company,
    @JsonKey(name: 'department') String? department,
    @JsonKey(name: 'company_email') String? companyEmail,
    @JsonKey(name: 'cell_number') String? cellNumber,
    @JsonKey(name: 'date_of_joining') String? dateOfJoining,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'nationality') String? nationality,
    @JsonKey(name: 'current_location') String? currentLocation,
    @JsonKey(name: 'professional_summary') String? professionalSummary,
    @JsonKey(name: 'awards_and_achievements') String? awardsAndAchievements,
    @Default([]) List<ResumeSkillModel> skills,
    @JsonKey(name: 'work_experience') @Default([]) List<ResumeWorkExperienceModel> workExperience,
    @Default([]) List<ResumeProjectModel> projects,
    @Default([]) List<ResumeLanguageModel> languages,
    @Default([]) List<ResumeEducationModel> education,
    @Default([]) List<ResumeCertificationModel> certifications,
    @JsonKey(name: 'consulting_experience') @Default([]) List<ResumeConsultingExperienceModel> consultingExperience,
  }) = _ResumeModel;

  const ResumeModel._();

  factory ResumeModel.fromJson(Map<String, dynamic> json) => _$ResumeModelFromJson(json);

  static Map<String, dynamic> preprocessJson(Map<String, dynamic> json) {
    final skillsList = json['skills'];
    final subskillsList = json['subskills'];
    if (skillsList is List && subskillsList is List) {
      final Map<String, List<Map<String, dynamic>>> groupedSubskills = {};
      for (final sub in subskillsList) {
        if (sub is Map) {
          final parentSkill = (sub['parent_skill'] as String? ?? '').trim().toLowerCase();
          if (parentSkill.isNotEmpty) {
            groupedSubskills.putIfAbsent(parentSkill, () => []).add(Map<String, dynamic>.from(sub));
          }
        }
      }

      final updatedSkills = skillsList.map((skill) {
        if (skill is Map) {
          final skillMap = Map<String, dynamic>.from(skill);
          final skillName = (skillMap['skill'] as String? ?? '').trim().toLowerCase();
          if (groupedSubskills.containsKey(skillName)) {
            skillMap['sub_skills'] = groupedSubskills[skillName];
          }
          return skillMap;
        }
        return skill;
      }).toList();

      final modifiedJson = Map<String, dynamic>.from(json);
      modifiedJson['skills'] = updatedSkills;
      return modifiedJson;
    }
    return json;
  }

  ResumeEntity toEntity() {
    return ResumeEntity(
      employee: employee ?? '',
      employeeName: employeeName ?? '',
      designation: designation ?? '',
      company: company ?? '',
      department: department ?? '',
      companyEmail: companyEmail ?? '',
      cellNumber: cellNumber ?? '',
      dateOfJoining: dateOfJoining ?? '',
      image: image ?? '',
      nationality: nationality ?? '',
      currentLocation: currentLocation ?? '',
      professionalSummary: professionalSummary ?? '',
      awardsAndAchievements: awardsAndAchievements ?? '',
      skills: skills.map((e) => e.toEntity()).toList(),
      workExperience: workExperience.map((e) => e.toEntity()).toList(),
      projects: projects.map((e) => e.toEntity()).toList(),
      languages: languages.map((e) => e.toEntity()).toList(),
      education: education.map((e) => e.toEntity()).toList(),
      certifications: certifications.map((e) => e.toEntity()).toList(),
      consultingExperience: consultingExperience.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
abstract class ResumeSkillModel with _$ResumeSkillModel {
  const factory ResumeSkillModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'skill') String? skill,
    @JsonKey(name: 'proficiency') String? proficiency,
    @JsonKey(name: 'years_of_experience', fromJson: _parseDouble) double? yearsOfExperience,
    @JsonKey(name: 'display_order', fromJson: _parseInt) int? displayOrder,
    @JsonKey(readValue: _readSubSkills) @Default([]) List<ResumeSubSkillModel> subSkills,
  }) = _ResumeSkillModel;

  const ResumeSkillModel._();

  factory ResumeSkillModel.fromJson(Map<String, dynamic> json) => _$ResumeSkillModelFromJson(json);

  ResumeSkillEntity toEntity() => ResumeSkillEntity(
        name: _unescapeHtml(name ?? ''),
        skill: _unescapeHtml(skill ?? ''),
        proficiency: proficiency ?? '',
        yearsOfExperience: yearsOfExperience ?? 0,
        displayOrder: displayOrder ?? 0,
        subSkills: subSkills.map((e) => e.toEntity()).toList(),
      );
}

@freezed
abstract class ResumeWorkExperienceModel with _$ResumeWorkExperienceModel {
  const factory ResumeWorkExperienceModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'company_name') String? companyName,
    @JsonKey(name: 'designation') String? designation,
    @JsonKey(name: 'custom_from_date') String? customFromDate,
    @JsonKey(name: 'custom_to_date') String? customToDate,
    @JsonKey(name: 'currently_working', fromJson: _parseBool) bool? currentlyWorking,
    @JsonKey(name: 'custom_assignment_summary') String? customAssignmentSummary,
    @JsonKey(name: 'custom_key_responsibilities') String? customKeyResponsibilities,
    @JsonKey(name: 'custom_key_achievements') String? customKeyAchievements,
    @JsonKey(name: 'custom_currently_working', fromJson: _parseBool) bool? customCurrentlyWorking,
    @JsonKey(name: 'custom_employment_type') String? customEmploymentType,
    @JsonKey(name: 'display_order', fromJson: _parseInt) int? displayOrder,
  }) = _ResumeWorkExperienceModel;

  const ResumeWorkExperienceModel._();

  factory ResumeWorkExperienceModel.fromJson(Map<String, dynamic> json) => _$ResumeWorkExperienceModelFromJson(json);

  ResumeWorkExperienceEntity toEntity() => ResumeWorkExperienceEntity(
        name: name ?? '',
        companyName: companyName ?? '',
        designation: designation ?? '',
        customFromDate: customFromDate ?? '',
        customToDate: customToDate ?? '',
        currentlyWorking: currentlyWorking ?? false,
        customAssignmentSummary: customAssignmentSummary ?? '',
        customKeyResponsibilities: customKeyResponsibilities ?? '',
        customKeyAchievements: customKeyAchievements ?? '',
        customCurrentlyWorking: customCurrentlyWorking ?? false,
        customEmploymentType: customEmploymentType ?? '',
        displayOrder: displayOrder ?? 0,
      );
}

@freezed
abstract class ResumeProjectModel with _$ResumeProjectModel {
  const factory ResumeProjectModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'project_name') String? projectName,
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'allocation', fromJson: _parseDouble) double? allocation,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'report_to') String? reportTo,
    @JsonKey(name: 'report_to_name') String? reportToName,
    @JsonKey(name: 'display_order', fromJson: _parseInt) int? displayOrder,
  }) = _ResumeProjectModel;

  const ResumeProjectModel._();

  factory ResumeProjectModel.fromJson(Map<String, dynamic> json) => _$ResumeProjectModelFromJson(json);

  ResumeProjectEntity toEntity() => ResumeProjectEntity(
        name: name ?? '',
        projectName: projectName ?? '',
        role: role ?? '',
        startDate: startDate ?? '',
        endDate: endDate ?? '',
        allocation: allocation ?? 0.0,
        status: status ?? '',
        reportTo: reportTo ?? '',
        reportToName: reportToName ?? '',
        displayOrder: displayOrder ?? 0,
      );
}

@freezed
abstract class ResumeLanguageModel with _$ResumeLanguageModel {
  const factory ResumeLanguageModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'language') String? language,
    @JsonKey(name: 'speaking') String? speaking,
    @JsonKey(name: 'reading') String? reading,
    @JsonKey(name: 'writing') String? writing,
    @JsonKey(name: 'display_order', fromJson: _parseInt) int? displayOrder,
  }) = _ResumeLanguageModel;

  const ResumeLanguageModel._();

  factory ResumeLanguageModel.fromJson(Map<String, dynamic> json) => _$ResumeLanguageModelFromJson(json);

  ResumeLanguageEntity toEntity() => ResumeLanguageEntity(
        name: name ?? '',
        language: language ?? '',
        speaking: speaking ?? '',
        reading: reading ?? '',
        writing: writing ?? '',
        displayOrder: displayOrder ?? 0,
      );
}

@freezed
abstract class ResumeEducationModel with _$ResumeEducationModel {
  const factory ResumeEducationModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'school_univ') String? schoolUniv,
    @JsonKey(name: 'qualification') String? qualification,
    @JsonKey(name: 'year_of_passing') dynamic yearOfPassing, // Can be String or int
    @JsonKey(name: 'level') String? level,
    @JsonKey(name: 'display_order', fromJson: _parseInt) int? displayOrder,
  }) = _ResumeEducationModel;

  const ResumeEducationModel._();

  factory ResumeEducationModel.fromJson(Map<String, dynamic> json) => _$ResumeEducationModelFromJson(json);

  ResumeEducationEntity toEntity() => ResumeEducationEntity(
        name: name ?? '',
        schoolUniv: schoolUniv ?? '',
        qualification: qualification ?? '',
        yearOfPassing: yearOfPassing?.toString() ?? '',
        level: level ?? '',
        displayOrder: displayOrder ?? 0,
      );
}

@freezed
abstract class ResumeCertificationModel with _$ResumeCertificationModel {
  const factory ResumeCertificationModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'certification_name') String? certificationName,
    @JsonKey(name: 'issuing_institute') String? issuingInstitute,
    @JsonKey(name: 'year_obtained') dynamic yearObtained,
    @JsonKey(name: 'certification_url') String? certificationUrl,
    @JsonKey(name: 'display_order', fromJson: _parseInt) int? displayOrder,
  }) = _ResumeCertificationModel;

  const ResumeCertificationModel._();

  factory ResumeCertificationModel.fromJson(Map<String, dynamic> json) => _$ResumeCertificationModelFromJson(json);

  ResumeCertificationEntity toEntity() => ResumeCertificationEntity(
        name: name ?? '',
        certificationName: certificationName ?? '',
        issuingInstitute: issuingInstitute ?? '',
        yearObtained: yearObtained?.toString() ?? '',
        certificationUrl: certificationUrl ?? '',
        displayOrder: displayOrder ?? 0,
      );
}

@freezed
abstract class ResumeConsultingExperienceModel with _$ResumeConsultingExperienceModel {
  const factory ResumeConsultingExperienceModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'parent_company') String? parentCompany,
    @JsonKey(name: 'client_name') String? clientName,
    @JsonKey(name: 'project') String? project,
    @JsonKey(name: 'from_date') String? fromDate,
    @JsonKey(name: 'to_date') String? toDate,
    @JsonKey(name: 'duration') String? duration,
    @JsonKey(name: 'project_overview') String? projectOverview,
    @JsonKey(name: 'business_impact') String? businessImpact,
    @JsonKey(name: 'tools_and_technologies') String? toolsAndTechnologies,
    @JsonKey(name: 'custom_role') String? customRole,
    @JsonKey(name: 'custom_project_lead') String? customProjectLead,
    @JsonKey(name: 'custom_allocation') String? customAllocation,
    @JsonKey(name: 'custom_status') String? customStatus,
    @JsonKey(name: 'display_order', fromJson: _parseInt) int? displayOrder,
  }) = _ResumeConsultingExperienceModel;

  const ResumeConsultingExperienceModel._();

  factory ResumeConsultingExperienceModel.fromJson(Map<String, dynamic> json) => _$ResumeConsultingExperienceModelFromJson(json);

  ResumeConsultingExperienceEntity toEntity() => ResumeConsultingExperienceEntity(
        name: name ?? '',
        parentCompany: parentCompany ?? '',
        clientName: clientName ?? '',
        project: project ?? '',
        fromDate: fromDate ?? '',
        toDate: toDate ?? '',
        duration: duration ?? '',
        projectOverview: projectOverview ?? '',
        businessImpact: businessImpact ?? '',
        toolsAndTechnologies: toolsAndTechnologies ?? '',
        customRole: customRole ?? '',
        customProjectLead: customProjectLead ?? '',
        customAllocation: customAllocation ?? '',
        customStatus: customStatus ?? '',
        displayOrder: displayOrder ?? 0,
      );
}

@freezed
abstract class SubSkillModel with _$SubSkillModel {
  const factory SubSkillModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'skill_name') String? skillName,
  }) = _SubSkillModel;

  const SubSkillModel._();

  factory SubSkillModel.fromJson(Map<String, dynamic> json) => _$SubSkillModelFromJson(json);

  SubSkillEntity toEntity() => SubSkillEntity(
        name: _unescapeHtml(name ?? ''),
        skillName: _unescapeHtml(skillName ?? ''),
      );
}

@freezed
abstract class ResumeSubSkillModel with _$ResumeSubSkillModel {
  const factory ResumeSubSkillModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'sub_skill') String? subSkill,
    @JsonKey(name: 'rating', fromJson: _parseDouble) double? rating,
    @JsonKey(name: 'parent_skill') String? parentSkill,
  }) = _ResumeSubSkillModel;

  const ResumeSubSkillModel._();

  factory ResumeSubSkillModel.fromJson(Map<String, dynamic> json) => _$ResumeSubSkillModelFromJson(json);

  ResumeSubSkillEntity toEntity() => ResumeSubSkillEntity(
        name: _unescapeHtml(name ?? ''),
        subSkill: _unescapeHtml(subSkill ?? ''),
        rating: rating ?? 0.0,
        parentSkill: _unescapeHtml(parentSkill ?? ''),
      );
}
