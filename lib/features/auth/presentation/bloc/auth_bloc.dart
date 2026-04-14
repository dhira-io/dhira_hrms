import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        started: () => _onAuthStatusChecked(emit),
        authStatusChecked: () => _onAuthStatusChecked(emit),
        logoutRequested: () => _onLogoutRequested(emit),
        loggedIn: (user) async => emit(AuthState.authenticated(user)),
      );
    });
  }

  Future<void> _onLogoutRequested(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await logoutUseCase();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> _onAuthStatusChecked(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final isActive = await loginUseCase.repository.isSessionActive();
    if (isActive) {
      final result = await loginUseCase.repository.getCurrentUser();
      result.fold(
        (failure) => emit(const AuthState.unauthenticated()),
        (user) => emit(AuthState.authenticated(user)),
      );
    } else {
      emit(const AuthState.unauthenticated());
    }
  }
}
