import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_avatar_usecase.dart';
import '../../domain/usecases/change_password_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateAvatarUseCase updateAvatarUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateAvatarUseCase,
    required this.changePasswordUseCase,
  }) : super(const ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      await event.when(
        started: (email) => _onStarted(email, emit),
        avatarUpdateRequested: (path, email) => _onAvatarUpdateRequested(path, email, emit),
        passwordChangeRequested: (old, newPass, logoutAll) => 
            _onPasswordChangeRequested(old, newPass, logoutAll, emit),
      );
    });
  }

  Future<void> _onStarted(String email, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());
    final result = await getProfileUseCase(email);
    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (profile) => emit(ProfileState.loaded(profile)),
    );
  }

  Future<void> _onAvatarUpdateRequested(String filePath, String email, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());
    final result = await updateAvatarUseCase(filePath, email);
    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (success) {
        if (success) {
          emit(const ProfileState.success("Avatar updated successfully"));
          add(ProfileEvent.started(email));
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
}
