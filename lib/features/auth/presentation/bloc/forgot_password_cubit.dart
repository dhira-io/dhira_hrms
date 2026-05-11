import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/usecases/forgot_password_usecase.dart';

part 'forgot_password_cubit.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = ForgotPasswordInitial;
  const factory ForgotPasswordState.loading() = ForgotPasswordLoading;
  const factory ForgotPasswordState.success(String message) = ForgotPasswordSuccess;
  const factory ForgotPasswordState.error(String message) = ForgotPasswordError;
}

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordCubit({required this.forgotPasswordUseCase})
      : super(const ForgotPasswordState.initial());

  Future<void> requestForgotPassword(String email) async {
    emit(const ForgotPasswordState.loading());
    final result = await forgotPasswordUseCase(email);
    result.fold(
      (failure) => emit(ForgotPasswordState.error(failure.message)),
      (_) => emit(
        const ForgotPasswordState.success(AppConstants.passwordResetSent),
      ),
    );
  }
}
