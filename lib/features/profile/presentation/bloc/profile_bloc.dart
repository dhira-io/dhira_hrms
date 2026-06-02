import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_avatar_usecase.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/update_profile_details_usecase.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/image_compress_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateAvatarUseCase updateAvatarUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final UpdateProfileDetailsUseCase updateProfileDetailsUseCase;
  final LocalStorageService localStorageService;
  final ImageCompressService imageCompressService;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateAvatarUseCase,
    required this.changePasswordUseCase,
    required this.updateProfileDetailsUseCase,
    required this.localStorageService,
    required this.imageCompressService,
  }) : super(const ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        avatarUpdateRequested: (path) => _onAvatarUpdateRequested(path, emit),
        passwordChangeRequested: (old, newPass, logoutAll) => 
            _onPasswordChangeRequested(old, newPass, logoutAll, emit),
        profileDetailsUpdateRequested: (companyEmail, phone, emergencyContact, currentAddress, permanentAddress) =>
            _onProfileDetailsUpdateRequested(companyEmail, phone, emergencyContact, currentAddress, permanentAddress, emit),
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
    final result = await getProfileUseCase(empid);
    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (profile) => emit(ProfileState.loaded(profile)),
    );
  }

  Future<void> _onAvatarUpdateRequested(String filePath, Emitter<ProfileState> emit) async {
    final profile = state.maybeWhen(
      loaded: (p) => p,
      uploading: (p) => p,
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
    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (success) {
        if (success) {
          emit(const ProfileState.success("Avatar updated successfully"));
          add(const ProfileEvent.started());
        } else {
          emit(const ProfileState.error("Upload failed"));
        }
      },
    );
  }

  Future<void> _onPasswordChangeRequested(
    String oldPassword, 
    String newPassword, 
    String logoutAllSessions, 
    Emitter<ProfileState> emit
  ) async {
    emit(const ProfileState.loading());
    final result = await changePasswordUseCase(
      oldPassword: oldPassword,
      newPassword: newPassword,
      logoutAllSessions: logoutAllSessions,
    );
    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (success) {
        if (success) {
          emit(const ProfileState.success("Password changed successfully"));
        } else {
          emit(const ProfileState.error("Password change failed"));
        }
      },
    );
  }

  Future<void> _onProfileDetailsUpdateRequested(
    String companyEmail,
    String phone,
    String emergencyContact,
    String currentAddress,
    String permanentAddress,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());
    final empid = localStorageService.getEmpId();
    if (empid == null) {
      emit(const ProfileState.error("Session expired. Please login again."));
      return;
    }

    final result = await updateProfileDetailsUseCase(
      identifier: empid,
      companyEmail: companyEmail,
      phone: phone,
      emergencyContact: emergencyContact,
      currentAddress: currentAddress,
      permanentAddress: permanentAddress,
    );

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (success) {
        if (success) {
          emit(const ProfileState.success("Profile updated successfully"));
          add(const ProfileEvent.started());
        } else {
          emit(const ProfileState.error("Failed to update profile"));
        }
      },
    );
  }
}
