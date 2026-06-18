import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/local_storage_service.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final LocalStorageService _localStorageService;

  OnboardingCubit(this._localStorageService)
    : super(const OnboardingState.initial());

  void completeOnboarding() {
    _localStorageService.saveIsFirstTime(false);
    emit(const OnboardingState.completed());
  }
}
