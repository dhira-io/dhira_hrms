import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/country_code_entity.dart';

part 'country_code_state.freezed.dart';

@freezed
class CountryCodeState with _$CountryCodeState {
  const factory CountryCodeState.initial() = _Initial;
  const factory CountryCodeState.loading() = _Loading;
  const factory CountryCodeState.loaded(List<CountryCodeEntity> countryCodes) = _Loaded;
  const factory CountryCodeState.error(String message) = _Error;
}
