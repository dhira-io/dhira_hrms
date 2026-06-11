import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/country_code_entity.dart';
import '../../domain/usecases/get_country_codes_usecase.dart';
import 'country_code_state.dart';

class CountryCodeCubit extends Cubit<CountryCodeState> {
  final GetCountryCodesUseCase _getCountryCodesUseCase;
  List<CountryCodeEntity>? _cachedCodes;

  CountryCodeCubit(this._getCountryCodesUseCase) : super(const CountryCodeState.initial());

  Future<void> fetchCountryCodes() async {
    if (_cachedCodes != null) {
      emit(CountryCodeState.loaded(_cachedCodes!));
      return;
    }

    emit(const CountryCodeState.loading());
    final result = await _getCountryCodesUseCase(NoParams());

    result.fold(
      (failure) {
        // Fallback to default codes
        _cachedCodes = [
          const CountryCodeEntity(code: '+1', label: '+1 (US)'),
          const CountryCodeEntity(code: '+91', label: '+91 (IN)'),
          const CountryCodeEntity(code: '+44', label: '+44 (GB)'),
          const CountryCodeEntity(code: '+61', label: '+61 (AU)'),
        ];
        emit(CountryCodeState.loaded(_cachedCodes!));
      },
      (codes) {
        _cachedCodes = codes;
        emit(CountryCodeState.loaded(codes));
      },
    );
  }
}
