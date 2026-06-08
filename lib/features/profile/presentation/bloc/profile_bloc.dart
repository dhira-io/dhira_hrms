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
        resumeUpdateRequested: (resumeDataJson, subSkillsJson) =>
            _onResumeUpdateRequested(resumeDataJson, subSkillsJson, emit),
        downloadResumeRequested: (empId, l10n) =>
            _onDownloadResumeRequested(empId, l10n, emit),
        projectAssignmentsUpdateRequested: (assignmentsJson) =>
            _onProjectAssignmentsUpdateRequested(assignmentsJson, emit),
      );
    });
  }

  Future<void> _onStarted(Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());
    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(const ProfileState.error("Session expired. Please login again."));
      return;
    }
    final profileResult = await getProfileUseCase(empid);
    final resumeResult = await getEmployeeResumeUseCase(empid);

    profileResult.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (profile) {
        resumeResult.fold(
          (failure) => emit(ProfileState.error(failure.message)),
          (resume) => emit(ProfileState.loaded(profile, resume)),
        );
      },
    );
  }

  Future<void> _onAvatarUpdateRequested(
    String filePath,
    Emitter<ProfileState> emit,
  ) async {
    final profile = state.maybeWhen(
      loaded: (p, resume) => p,
      uploading: (p, resume) => p,
      orElse: () => null,
    );

    if (profile != null) {
      emit(ProfileState.uploading(profile));
    } else {
      emit(const ProfileState.loading());
    }
    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(const ProfileState.error("Session expired. Please login again."));
      return;
    }

    // Compress image before upload
    final compressedFile = await imageCompressService.compressImage(filePath);
    final uploadPath = compressedFile?.path ?? filePath;

    final result = await updateAvatarUseCase(uploadPath, empid);
    result.fold((failure) => emit(ProfileState.error(failure.message)), (
      message,
    ) {
      emit(ProfileState.success(message));
      add(const ProfileEvent.started());
    });
  }

  Future<void> _onAvatarDeleteRequested(Emitter<ProfileState> emit) async {
    final profile = state.maybeWhen(loaded: (p, resume) => p, orElse: () => null);

    if (profile != null) {
      emit(ProfileState.uploading(profile));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(const ProfileState.error("Session expired. Please login again."));
      return;
    }

    final result = await deleteProfileImageUseCase(empid);
    result.fold((failure) => emit(ProfileState.error(failure.message)), (
      success,
    ) {
      if (success) {
        emit(const ProfileState.success("Avatar deleted successfully"));
        add(const ProfileEvent.started());
      } else {
        emit(const ProfileState.error("Delete failed"));
      }
    });
  }

  Future<void> _onPasswordChangeRequested(
    String oldPassword,
    String newPassword,
    String logoutAllSessions,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());
    final result = await changePasswordUseCase(
      oldPassword: oldPassword,
      newPassword: newPassword,
      logoutAllSessions: logoutAllSessions,
    );
    result.fold((failure) => emit(ProfileState.error(failure.message)), (
      success,
    ) {
      if (success) {
        emit(const ProfileState.success("Password changed successfully"));
      } else {
        emit(const ProfileState.error("Password change failed"));
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
    final profile = state.maybeWhen(loaded: (p, resume) => p, orElse: () => null);

    if (profile != null) {
      emit(ProfileState.uploading(profile));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(const ProfileState.error("Session expired. Please login again."));
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

    result.fold((failure) => emit(ProfileState.error(failure.message)), (
      success,
    ) {
      if (success) {
        emit(const ProfileState.success("Profile updated successfully"));
        add(const ProfileEvent.started());
      } else {
        emit(const ProfileState.error("Failed to update profile"));
      }
    });
  }

  Future<void> _onResumeRowUpsertRequested(
    String section,
    String rowDataJson,
    String? rowName,
    Emitter<ProfileState> emit,
  ) async {
    final currentProfile = state.maybeWhen(loaded: (p, _) => p, orElse: () => null);
    final currentResume = state.maybeWhen(loaded: (_, r) => r, orElse: () => null);

    if (currentProfile != null) {
      emit(ProfileState.uploading(currentProfile, currentResume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(const ProfileState.error("Session expired. Please login again."));
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
      (failure) async => emit(ProfileState.error(failure.message)),
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
            (failure) => emit(ProfileState.error(failure.message)),
            (_) {
              emit(const ProfileState.success("Saved successfully"));
              add(const ProfileEvent.started());
            },
          );
        } else {
          emit(const ProfileState.success("Saved successfully"));
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
    final currentProfile = state.maybeWhen(loaded: (p, _) => p, orElse: () => null);
    final currentResume = state.maybeWhen(loaded: (_, r) => r, orElse: () => null);

    if (currentProfile != null) {
      emit(ProfileState.uploading(currentProfile, currentResume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(const ProfileState.error("Session expired. Please login again."));
      return;
    }

    final result = await deleteResumeRowUseCase(DeleteResumeRowParams(
      employeeId: empid,
      section: section,
      rowName: rowName,
    ));

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (_) {
        emit(const ProfileState.success("Deleted successfully"));
        add(const ProfileEvent.started());
      },
    );
  }

  Future<void> _onResumeUpdateRequested(
    String resumeDataJson,
    String subSkillsJson,
    Emitter<ProfileState> emit,
  ) async {
    final currentProfile = state.maybeWhen(loaded: (p, _) => p, orElse: () => null);
    final currentResume = state.maybeWhen(loaded: (_, r) => r, orElse: () => null);

    if (currentProfile != null) {
      emit(ProfileState.uploading(currentProfile, currentResume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(const ProfileState.error("Session expired. Please login again."));
      return;
    }

    final resumeResult = await updateEmployeeResumeUseCase(UpdateEmployeeResumeParams(
      employeeId: empid,
      resumeDataJson: resumeDataJson,
    ));

    dynamic subSkillsResult;
    if (subSkillsJson != "{}" && subSkillsJson != "[]" && subSkillsJson.isNotEmpty) {
      subSkillsResult = await updateEmployeeSubSkillsUseCase(UpdateEmployeeSubSkillsParams(
        employeeId: empid,
        subSkillsJson: subSkillsJson,
      ));
    }

    resumeResult.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (_) {
        if (subSkillsResult != null) {
          subSkillsResult.fold(
            (failure) => emit(ProfileState.error(failure.message)),
            (_) {
              emit(const ProfileState.success("Profile saved successfully"));
              add(const ProfileEvent.started());
            },
          );
        } else {
          emit(const ProfileState.success("Profile saved successfully"));
          add(const ProfileEvent.started());
        }
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
    final currentProfile = state.maybeWhen(loaded: (p, _) => p, orElse: () => null);
    final currentResume = state.maybeWhen(loaded: (_, r) => r, orElse: () => null);

    if (currentProfile != null) {
      emit(ProfileState.uploading(currentProfile, currentResume));
    } else {
      emit(const ProfileState.loading());
    }

    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(const ProfileState.error("Session expired. Please login again."));
      return;
    }

    final result = await updateEmployeeProjectAssignmentsUseCase(empid, assignmentsJson);

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (_) {
        emit(const ProfileState.success("Project assignments updated successfully"));
        add(const ProfileEvent.started());
      },
    );
  }
}
