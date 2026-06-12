import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_search_state.freezed.dart';

@freezed
class LocationSearchState with _$LocationSearchState {
  const factory LocationSearchState.initial({@Default([]) List<String> results}) = _Initial;
  const factory LocationSearchState.loading({@Default([]) List<String> results}) = _Loading;
  const factory LocationSearchState.loaded(List<String> results) = _Loaded;
  const factory LocationSearchState.error(String message, {@Default([]) List<String> results}) = _Error;
}
