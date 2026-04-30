import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/usecases/microsoft_sso_usecase.dart';
import '../../domain/usecases/exchange_sso_token_usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../core/services/local_storage_service.dart';

part 'sso_cubit.freezed.dart';

@freezed
class SSOState with _$SSOState {
  const factory SSOState.initial() = _Initial;
  const factory SSOState.loading() = _Loading;
  const factory SSOState.success(UserEntity user) = _Success;
  const factory SSOState.error(String message) = _Error;
  const factory SSOState.redirecting() = _Redirecting;
}

class SSOCubit extends Cubit<SSOState> {
  final MicrosoftSSOUseCase microsoftSSOUseCase;
  final ExchangeSSOTokenUseCase exchangeSSOTokenUseCase;
  final LocalStorageService localStorageService;

  SSOCubit({
    required this.microsoftSSOUseCase,
    required this.exchangeSSOTokenUseCase,
    required this.localStorageService,
  }) : super(const SSOState.initial());

  Future<void> initiateMicrosoftSSO() async {
    emit(const SSOState.loading());
    final result = await microsoftSSOUseCase();
    result.fold(
      (failure) => emit(SSOState.error(failure.message)),
      (_) => emit(const SSOState.redirecting()),
    );
  }

  Future<void> onSSOCallbackReceived(String apiKey, String apiSecret) async {
    emit(const SSOState.loading());
    final result = await exchangeSSOTokenUseCase(apiKey, apiSecret);
    result.fold(
      (failure) => emit(SSOState.error(failure.message)),
      (user) async {
        await localStorageService.saveUserEmail(user.email);
        emit(SSOState.success(user));
      },
    );
  }
}
