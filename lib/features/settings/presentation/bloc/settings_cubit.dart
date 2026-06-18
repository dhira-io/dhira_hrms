import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/features/profile/domain/usecases/get_profile_usecase.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetProfileUseCase getProfileUseCase;
  final LocalStorageService localStorageService;

  SettingsCubit({
    required this.getProfileUseCase,
    required this.localStorageService,
  }) : super(const SettingsState());

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final empId = localStorageService.getEmpId() ?? '';

    if (empId.isEmpty) {
      emit(state.copyWith(isLoading: false, errorMessage: 'userEmailNotFound'));
      return;
    }

    final result = await getProfileUseCase(empId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (profile) => emit(state.copyWith(isLoading: false, userProfile: profile)),
    );
  }
}
