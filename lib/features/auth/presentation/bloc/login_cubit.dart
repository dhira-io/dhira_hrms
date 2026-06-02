import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/user_entity.dart';

part 'login_cubit.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(UserEntity user) = _Success;
  const factory LoginState.error(String message) = _Error;
}

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    emit(const LoginState.loading());
    final result = await loginUseCase(email, password);
    result.fold(
      (failure) => emit(LoginState.error(failure.message)),
      (user) => emit(LoginState.success(user)),
    );
  }
}
