import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:get/get.dart';
import '../../../attendance/presentation/bloc/attendance_bloc.dart';
import '../../../leave/presentation/bloc/leave_bloc.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../timesheet/presentation/bloc/timesheet_bloc.dart';
import '../../../approvals/presentation/bloc/approvals_bloc.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';
import '../../../../core/services/notification_manager.dart';
import 'dart:developer';

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
        forcedLogoutRequested: () => _onLogoutRequested(emit),
        loggedIn: (user) async {
          emit(AuthState.authenticated(user));
          // Register device on successful login
          NotificationManager().getToken();
        },
      );
    });
  }

  Future<void> _onLogoutRequested(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    
    // Deactivate Firebase device on logout
    try {
      await NotificationManager().deactivate();
    } catch (_) {}

    final result = await logoutUseCase();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) {
        // Destroy locally scoped Blocs to clear all data and force recreation on next login
        Get.delete<AttendanceBloc>(force: true);
        Get.delete<LeaveBloc>(force: true);
        Get.delete<ProfileBloc>(force: true);
        Get.delete<TimesheetBloc>(force: true);
        Get.delete<ApprovalsBloc>(force: true);
        Get.delete<NotificationBloc>(force: true);

        emit(const AuthState.unauthenticated());
      },
    );
  }

  Future<void> _onAuthStatusChecked(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final isActive = await loginUseCase.repository.isSessionActive();
    if (isActive) {
      final result = await loginUseCase.repository.getCurrentUser();
      result.fold(
        (failure) => emit(const AuthState.unauthenticated()),
        (user) {
          emit(AuthState.authenticated(user));
          // Ensure device is registered
          NotificationManager().getToken();
        },
      );
    } else {
      emit(const AuthState.unauthenticated());
    }
  }
}