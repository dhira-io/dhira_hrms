import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/usecases/get_theme_usecase.dart';
import '../../domain/usecases/set_theme_usecase.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SetThemeUseCase setThemeUseCase;

  ThemeBloc({
    required this.getThemeUseCase,
    required this.setThemeUseCase,
  }) : super(const ThemeState.initial()) {
    on<ThemeEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        themeChanged: (mode) => _onThemeChanged(mode, emit),
      );
    });
  }

  Future<void> _onStarted(Emitter<ThemeState> emit) async {
    emit(const ThemeState.loading());
    final result = await getThemeUseCase();
    result.fold(
      (failure) => emit(ThemeState.error(failure.message)),
      (mode) {
        AppColors.updateThemeMode(mode);
        emit(ThemeState.loaded(mode));
      },
    );
  }

  Future<void> _onThemeChanged(ThemeMode mode, Emitter<ThemeState> emit) async {
    final result = await setThemeUseCase(mode);
    result.fold(
      (failure) => emit(ThemeState.error(failure.message)),
      (_) {
        AppColors.updateThemeMode(mode);
        emit(ThemeState.success(AppConstants.themeUpdatedSuccessfully, mode));
        // Reset to loaded state to allow repeated side effects and stable UI
        emit(ThemeState.loaded(mode));
      },
    );
  }
}
