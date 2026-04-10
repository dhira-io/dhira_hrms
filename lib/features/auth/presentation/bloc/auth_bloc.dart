import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/microsoft_sso_usecase.dart';
import '../../domain/usecases/exchange_sso_token_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final MicrosoftSSOUseCase microsoftSSOUseCase;
  final ExchangeSSOTokenUseCase exchangeSSOTokenUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.forgotPasswordUseCase,
    required this.microsoftSSOUseCase,
    required this.exchangeSSOTokenUseCase,
    required this.verifyOtpUseCase,
    required this.resendOtpUseCase,
  }) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        loginRequested: (email, password) => _onLoginRequested(email, password, emit),
        logoutRequested: () => _onLogoutRequested(emit),
        authStatusChecked: () => _onAuthStatusChecked(emit),
        forgotPasswordRequested: (email) => _onForgotPasswordRequested(email, emit),
        microsoftSSORequested: () => _onMicrosoftSSORequested(emit),
        ssoCallbackReceived: (apiKey, apiSecret) => _onSSOCallbackReceived(apiKey, apiSecret, emit),
        verifyOtpRequested: (email, otp) => _onVerifyOtpRequested(email, otp, emit),
        resendOtpRequested: (email) => _onResendOtpRequested(email, emit),
      );
    });
  }

  Future<void> _onStarted(Emitter<AuthState> emit) async {
    add(const AuthEvent.authStatusChecked());
  }

  Future<void> _onLoginRequested(String email, String password, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await loginUseCase(email, password);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
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

  Future<void> _onForgotPasswordRequested(String email, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await forgotPasswordUseCase(email);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(const AuthState.success("Password reset instructions sent to your email")),
    );
  }

  Future<void> _onMicrosoftSSORequested(Emitter<AuthState> emit) async {
    final result = await microsoftSSOUseCase();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => null, // Initiation success, wait for callback
    );
  }

  Future<void> _onSSOCallbackReceived(String apiKey, String apiSecret, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await exchangeSSOTokenUseCase(apiKey, apiSecret);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onVerifyOtpRequested(String email, String otp, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await verifyOtpUseCase(email, otp);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(const AuthState.success("OTP Verified Successfully")),
    );
  }

  Future<void> _onResendOtpRequested(String email, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await resendOtpUseCase(email);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(const AuthState.success("OTP Resent Successfully")),
    );
  }
}
