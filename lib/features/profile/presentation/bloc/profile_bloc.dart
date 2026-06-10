import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_avatar_usecase.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/update_profile_details_usecase.dart';
import '../../domain/usecases/delete_profile_image_usecase.dart';
import '../../domain/usecases/get_employee_resume_usecase.dart';
import '../../domain/usecases/upsert_resume_row_usecase.dart';
import '../../domain/usecases/delete_resume_row_usecase.dart';
import '../../domain/usecases/update_employee_resume_usecase.dart';
import '../../domain/usecases/update_employee_sub_skills_usecase.dart';
import '../../domain/usecases/save_sub_skills_for_skill_usecase.dart';
import '../../domain/usecases/update_employee_project_assignments_usecase.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/image_compress_service.dart';
import '../../../performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/resume_entity.dart';
import '../../../../core/utils/date_time_utils.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateAvatarUseCase updateAvatarUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final UpdateProfileDetailsUseCase updateProfileDetailsUseCase;
  final DeleteProfileImageUseCase deleteProfileImageUseCase;
  final GetEmployeeResumeUseCase getEmployeeResumeUseCase;
  final UpsertResumeRowUseCase upsertResumeRowUseCase;
  final DeleteResumeRowUseCase deleteResumeRowUseCase;
  final UpdateEmployeeResumeUseCase updateEmployeeResumeUseCase;
  final UpdateEmployeeSubSkillsUseCase updateEmployeeSubSkillsUseCase;
  final SaveSubSkillsForSkillUseCase saveSubSkillsForSkillUseCase;
  final UpdateEmployeeProjectAssignmentsUseCase updateEmployeeProjectAssignmentsUseCase;
  final LocalStorageService localStorageService;
  final ImageCompressService imageCompressService;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateAvatarUseCase,
    required this.changePasswordUseCase,
    required this.updateProfileDetailsUseCase,
    required this.deleteProfileImageUseCase,
    required this.getEmployeeResumeUseCase,
    required this.upsertResumeRowUseCase,
    required this.deleteResumeRowUseCase,
    required this.updateEmployeeResumeUseCase,
    required this.updateEmployeeSubSkillsUseCase,
    required this.saveSubSkillsForSkillUseCase,
    required this.updateEmployeeProjectAssignmentsUseCase,
    required this.localStorageService,
    required this.imageCompressService,
  }) : super(const ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        avatarUpdateRequested: (path) => _onAvatarUpdateRequested(path, emit),
        avatarDeleteRequested: () => _onAvatarDeleteRequested(emit),
        passwordChangeRequested: (old, newPass, logoutAll) =>
            _onPasswordChangeRequested(old, newPass, logoutAll, emit),
        profileDetailsUpdateRequested:
            (
              personalEmail,
              phone,
              emergencyContact,
              emergencyContactName,
              nationality,
              currentAddress,
              permanentAddress,
              currentLocation,
              dateOfBirth,
            ) => _onProfileDetailsUpdateRequested(
              personalEmail,
              phone,
              emergencyContact,
              emergencyContactName,
              nationality,
              currentAddress,
              permanentAddress,
              currentLocation,
              dateOfBirth,
              emit,
            ),
        resumeRowUpsertRequested: (section, rowDataJson, rowName) =>
            _onResumeRowUpsertRequested(section, rowDataJson, rowName, emit),
        resumeRowDeleteRequested: (section, rowName) =>
            _onResumeRowDeleteRequested(section, rowName, emit),
        resumeUpdateRequested: (resume, summary, awards) =>
            _onResumeUpdateRequested(resume, summary, awards, emit),
        downloadResumeRequested: (empId, l10n) =>
            _onDownloadResumeRequested(empId, l10n, emit),
        projectAssignmentsUpdateRequested: (assignmentsJson) =>
            _onProjectAssignmentsUpdateRequested(assignmentsJson, emit),
      );
    });
  }

  Future<void> _onStarted(Emitter<ProfileState> emit) async {
    final currentProfile = state.profile;
    final currentResume = state.resume;

    if (currentProfile == null || currentResume == null) {
      emit(const ProfileState.loading());
    } else {
      emit(ProfileState.uploading(currentProfile, currentResume));
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(ProfileState.error("Session expired. Please login again.", profile: state.profile, resume: state.resume));
      return;
    }
    final profileResult = await getProfileUseCase(empid);
    final resumeResult = await getEmployeeResumeUseCase(empid);

    profileResult.fold(
      (failure) => emit(ProfileState.error(failure.message, profile: state.profile, resume: state.resume)),
      (profile) {
        resumeResult.fold(
          (failure) => emit(ProfileState.error(failure.message, profile: state.profile, resume: state.resume)),
          (resume) => emit(ProfileState.loaded(profile, resume)),
        );
      },
    );
  }

  Future<void> _onAvatarUpdateRequested(
    String filePath,
    Emitter<ProfileState> emit,
  ) async {
    final profile = state.profile;
    final resume = state.resume;

    if (profile != null) {
      emit(ProfileState.uploading(profile, resume));
    } else {
      emit(const ProfileState.loading());
    }
    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(ProfileState.error("Session expired. Please login again.", profile: profile, resume: resume));
      return;
    }

    // Compress image before upload
    final compressedFile = await imageCompressService.compressImage(filePath);
    final uploadPath = compressedFile?.path ?? filePath;

    final result = await updateAvatarUseCase(uploadPath, empid);
    result.fold((failure) => emit(ProfileState.error(failure.message, profile: profile, resume: resume)), (
      message,
    ) {
      emit(ProfileState.success(message, profile: profile, resume: resume));
      add(const ProfileEvent.started());
    });
  }

  Future<void> _onAvatarDeleteRequested(Emitter<ProfileState> emit) async {
    final profile = state.profile;
    final resume = state.resume;

    if (profile != null) {
      emit(ProfileState.uploading(profile, resume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(ProfileState.error("Session expired. Please login again.", profile: profile, resume: resume));
      return;
    }

    final result = await deleteProfileImageUseCase(empid);
    result.fold((failure) => emit(ProfileState.error(failure.message, profile: profile, resume: resume)), (
      success,
    ) {
      if (success) {
        emit(ProfileState.success("Avatar deleted successfully", profile: profile, resume: resume));
        add(const ProfileEvent.started());
      } else {
        emit(ProfileState.error("Delete failed", profile: profile, resume: resume));
      }
    });
  }

  Future<void> _onPasswordChangeRequested(
    String oldPassword,
    String newPassword,
    String logoutAllSessions,
    Emitter<ProfileState> emit,
  ) async {
    final profile = state.profile;
    final resume = state.resume;
    emit(const ProfileState.loading());
    final result = await changePasswordUseCase(
      oldPassword: oldPassword,
      newPassword: newPassword,
      logoutAllSessions: logoutAllSessions,
    );
    result.fold((failure) => emit(ProfileState.error(failure.message, profile: profile, resume: resume)), (
      success,
    ) {
      if (success) {
        emit(ProfileState.success("Password changed successfully", profile: profile, resume: resume));
      } else {
        emit(ProfileState.error("Password change failed", profile: profile, resume: resume));
      }
    });
  }

  Future<void> _onProfileDetailsUpdateRequested(
    String personalEmail,
    String phone,
    String emergencyContact,
    String? emergencyContactName,
    String? nationality,
    String currentAddress,
    String permanentAddress,
    String? currentLocation,
    String? dateOfBirth,
    Emitter<ProfileState> emit,
  ) async {
    final profile = state.profile;
    final currentResume = state.resume;

    if (profile != null) {
      emit(ProfileState.uploading(profile, currentResume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(ProfileState.error("Session expired. Please login again.", profile: profile, resume: currentResume));
      return;
    }

    final result = await updateProfileDetailsUseCase(
      identifier: empid,
      personalEmail: personalEmail,
      phone: phone,
      emergencyContact: emergencyContact,
      emergencyContactName: emergencyContactName,
      nationality: nationality,
      currentAddress: currentAddress,
      permanentAddress: permanentAddress,
      currentLocation: currentLocation,
      dateOfBirth: dateOfBirth,
    );

    result.fold((failure) => emit(ProfileState.error(failure.message, profile: profile, resume: currentResume)), (
      success,
    ) {
      if (success) {
        if (profile != null) {
          final updatedProfile = profile.copyWith(
            personalEmail: personalEmail,
            phone: phone,
            emergencyContact: emergencyContact,
            emergencyContactName: emergencyContactName,
            nationality: nationality,
            currentAddress: currentAddress,
            permanentAddress: permanentAddress,
            currentLocation: currentLocation,
            birthDate: dateOfBirth,
          );
          emit(ProfileState.loaded(updatedProfile, currentResume));
        } else {
          emit(ProfileState.error("Failed to update profile", profile: profile, resume: currentResume));
        }
      } else {
        emit(ProfileState.error("Failed to update profile", profile: profile, resume: currentResume));
      }
    });
  }

  Future<void> _onResumeRowUpsertRequested(
    String section,
    String rowDataJson,
    String? rowName,
    Emitter<ProfileState> emit,
  ) async {
    final currentProfile = state.profile;
    final currentResume = state.resume;

    if (currentProfile != null) {
      emit(ProfileState.uploading(currentProfile, currentResume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(ProfileState.error("Session expired. Please login again.", profile: currentProfile, resume: currentResume));
      return;
    }

    // Process custom_sub_skill separately if it exists in rowDataJson
    String? subSkillsJson;
    String? skillName;
    String finalRowDataJson = rowDataJson;

    if (section == 'skills') {
      try {
        final Map<String, dynamic> rowDataMap = jsonDecode(rowDataJson);
        if (rowDataMap.containsKey('custom_sub_skill')) {
          final customSubSkill = rowDataMap['custom_sub_skill'];
          skillName = rowDataMap['skill'];
          if (customSubSkill is List) {
            // Transform [{"sub_skill": "A"}] to [{"sub_skill": "A", "parent_skill": skillName, "rating": 0.8, "description": ""}]
            final transformedSubSkills = customSubSkill.map((e) {
              return {
                "sub_skill": e['sub_skill'],
                "parent_skill": skillName,
                "rating": 0.8,
                "description": ""
              };
            }).toList();
            subSkillsJson = jsonEncode(transformedSubSkills);
          }
          rowDataMap.remove('custom_sub_skill');
          finalRowDataJson = jsonEncode(rowDataMap);
        }
      } catch (_) {}
    }

    final result = await upsertResumeRowUseCase(UpsertResumeRowParams(
      employeeId: empid,
      section: section,
      rowDataJson: finalRowDataJson,
      rowName: rowName,
    ));

    await result.fold(
      (failure) async => emit(ProfileState.error(failure.message, profile: currentProfile, resume: currentResume)),
      (_) async {
        if (subSkillsJson != null && skillName != null) {
          final subSkillsResult = await saveSubSkillsForSkillUseCase(
            SaveSubSkillsForSkillParams(
              employeeId: empid,
              skillName: skillName,
              subSkillsJson: subSkillsJson,
            ),
          );
          
          subSkillsResult.fold(
            (failure) => emit(ProfileState.error(failure.message, profile: currentProfile, resume: currentResume)),
            (_) {
              emit(ProfileState.success("Saved successfully", profile: currentProfile, resume: currentResume));
              add(const ProfileEvent.started());
            },
          );
        } else {
          emit(ProfileState.success("Saved successfully", profile: currentProfile, resume: currentResume));
          add(const ProfileEvent.started());
        }
      },
    );
  }

  Future<void> _onResumeRowDeleteRequested(
    String section,
    String rowName,
    Emitter<ProfileState> emit,
  ) async {
    final currentProfile = state.profile;
    final currentResume = state.resume;

    if (currentProfile != null && currentResume != null) {
      emit(ProfileState.uploading(currentProfile, currentResume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(ProfileState.error("Session expired. Please login again.", profile: currentProfile, resume: currentResume));
      return;
    }

    final result = await deleteResumeRowUseCase(DeleteResumeRowParams(
      employeeId: empid,
      section: section,
      rowName: rowName,
    ));

    result.fold(
      (failure) => emit(ProfileState.error(failure.message, profile: currentProfile, resume: currentResume)),
      (_) {
        emit(ProfileState.success("Deleted successfully", profile: currentProfile, resume: currentResume));
        add(const ProfileEvent.started());
      },
    );
  }

  Future<void> _onResumeUpdateRequested(
    ResumeEntity resume,
    String professionalSummary,
    String awardsAndAchievements,
    Emitter<ProfileState> emit,
  ) async {
    final currentProfile = state.profile;
    final currentResume = state.resume;

    if (currentProfile != null && currentResume != null) {
      emit(ProfileState.uploading(currentProfile, currentResume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(ProfileState.error("Session expired. Please login again.", profile: currentProfile, resume: currentResume));
      return;
    }

    final resumeDataJson = jsonEncode({
      "professional_summary": professionalSummary,
      "awards_and_achievements": awardsAndAchievements,
      "skills": resume.skills
          .map(
            (e) => {
              if (e.name.isNotEmpty) "name": e.name,
              "skill": e.skill,
              "proficiency": e.proficiency,
              "years_of_experience": e.yearsOfExperience,
              "display_order": e.displayOrder,
            },
          )
          .toList(),
      "work_experience": resume.workExperience
          .map(
            (e) => {
              if (e.name.isNotEmpty) "name": e.name,
              "company_name": e.companyName,
              "designation": e.designation,
              "custom_from_date": e.customFromDate,
              "custom_to_date": e.customToDate,
              "currently_working": e.currentlyWorking ? 1 : 0,
              "custom_assignment_summary": e.customAssignmentSummary,
              "custom_key_responsibilities": e.customKeyResponsibilities,
              "custom_key_achievements": e.customKeyAchievements,
              "custom_currently_working": e.customCurrentlyWorking ? 1 : 0,
              "custom_employment_type": e.customEmploymentType,
              "display_order": e.displayOrder,
            },
          )
          .toList(),
      "projects": resume.projects
          .map(
            (e) => {
              if (e.name.isNotEmpty) "name": e.name,
              "project_name": e.projectName,
              "role": e.role,
              "start_date": e.startDate,
              "end_date": e.endDate,
              "allocation": e.allocation,
              "status": e.status,
              "report_to": e.reportTo,
              "report_to_name": e.reportToName,
              "display_order": e.displayOrder,
            },
          )
          .toList(),
      "languages": resume.languages
          .map(
            (e) => {
              if (e.name.isNotEmpty) "name": e.name,
              "language": e.language,
              "speaking": e.speaking,
              "reading": e.reading,
              "writing": e.writing,
              "display_order": e.displayOrder,
            },
          )
          .toList(),
      "education": resume.education
          .map(
            (e) => {
              if (e.name.isNotEmpty) "name": e.name,
              "school_univ": e.schoolUniv,
              "qualification": e.qualification,
              "year_of_passing": e.yearOfPassing,
              "level": e.level,
              "display_order": e.displayOrder,
            },
          )
          .toList(),
      "certifications": resume.certifications
          .map(
            (e) => {
              if (e.name.isNotEmpty) "name": e.name,
              "certification_name": e.certificationName,
              "issuing_institute": e.issuingInstitute,
              "year_obtained": e.yearObtained,
              "certification_url": e.certificationUrl,
              "display_order": e.displayOrder,
            },
          )
          .toList(),
      "consulting_experience": resume.consultingExperience
          .map(
            (e) => {
              if (e.name.isNotEmpty) "name": e.name,
              "parent_company": e.parentCompany,
              "client_name": e.clientName,
              "project": e.project,
              "from_date": e.fromDate,
              "to_date": e.toDate,
              "duration": (e.duration.isNotEmpty &&
                      e.duration.toLowerCase() != "no data filled" &&
                      e.duration.toLowerCase() != "no data")
                  ? e.duration
                  : DateTimeUtils.calculateDuration(
                      e.fromDate,
                      e.toDate,
                    ),
              "project_overview": e.projectOverview,
              "business_impact": e.businessImpact,
              "tools_and_technologies": e.toolsAndTechnologies,
              "custom_role": e.customRole,
              "custom_project_lead": e.customProjectLead,
              "custom_allocation": e.customAllocation,
              "custom_status": e.customStatus,
              "display_order": e.displayOrder,
            },
          )
          .toList(),
    });

    final resumeResult = await updateEmployeeResumeUseCase(UpdateEmployeeResumeParams(
      employeeId: empid,
      resumeDataJson: resumeDataJson,
    ));

    resumeResult.fold(
      (failure) => emit(ProfileState.error(failure.message, profile: currentProfile, resume: currentResume)),
      (_) {
        emit(ProfileState.success("Profile saved successfully", profile: currentProfile, resume: currentResume));
        add(const ProfileEvent.started());
      },
    );
  }

  Future<void> _onDownloadResumeRequested(
    String empId,
    AppLocalizations l10n,
    Emitter<ProfileState> emit,
  ) async {
    final fileOpCubit = Get.find<FileOperationCubit>();
    final baseUrl = fileOpCubit.dioClient.baseUrl;

    // Build URL
    final url =
        '$baseUrl/api/method/dhira_hrms.api.download_resume.download_resume?employee_id=$empId';

    // Derive a clean file name
    final fileName = 'Resume_$empId.pdf';

    await fileOpCubit.downloadFile(url, fileName, l10n);
  }
  Future<void> _onProjectAssignmentsUpdateRequested(
    String assignmentsJson,
    Emitter<ProfileState> emit,
  ) async {
    final currentProfile = state.profile;
    final currentResume = state.resume;

    if (currentProfile != null) {
      emit(ProfileState.uploading(currentProfile, currentResume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(ProfileState.error("Session expired. Please login again.", profile: currentProfile, resume: currentResume));
      return;
    }

    final result = await updateEmployeeProjectAssignmentsUseCase(empid, assignmentsJson);

    result.fold(
      (failure) => emit(ProfileState.error(failure.message, profile: currentProfile, resume: currentResume)),
      (_) {
        emit(ProfileState.success("Project assignments updated successfully", profile: currentProfile, resume: currentResume));
        add(const ProfileEvent.started());
      },
    );
  }
}
