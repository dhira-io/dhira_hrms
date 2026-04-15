import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/usecases/forgot_password_usecase.dart';

part 'forgot_password_cubit.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;
  const factory ForgotPasswordState.loading() = _Loading;
  const factory ForgotPasswordState.success(String message) = _Success;
  const factory ForgotPasswordState.error(String message) = _Error;
}

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordCubit({required this.forgotPasswordUseCase}) : super(const ForgotPasswordState.initial());

  Future<void> requestForgotPassword(String email) async {
    emit(const ForgotPasswordState.loading());
    final result = await forgotPasswordUseCase(email);
    result.fold(
      (failure) => emit(ForgotPasswordState.error(failure.message)),
      (_) => emit(const ForgotPasswordState.success("Password reset instructions sent to your email")),
    );
  }
}
