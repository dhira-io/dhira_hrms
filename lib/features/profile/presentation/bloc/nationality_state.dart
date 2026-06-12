import 'package:freezed_annotation/freezed_annotation.dart';

part 'nationality_state.freezed.dart';

@freezed
class NationalityState with _$NationalityState {
  const factory NationalityState.initial() = _Initial;
  const factory NationalityState.loading() = _Loading;
  const factory NationalityState.loaded(List<String> nationalities) = _Loaded;
  const factory NationalityState.error(String message) = _Error;
}
