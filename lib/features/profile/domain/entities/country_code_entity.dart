import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_code_entity.freezed.dart';

@freezed
abstract class CountryCodeEntity with _$CountryCodeEntity {
  const factory CountryCodeEntity({
    required String code,
    required String label,
  }) = _CountryCodeEntity;
}
