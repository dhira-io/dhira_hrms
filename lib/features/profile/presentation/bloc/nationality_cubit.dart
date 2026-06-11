import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_nationalities_usecase.dart';
import 'nationality_state.dart';

class NationalityCubit extends Cubit<NationalityState> {
  final GetNationalitiesUseCase _getNationalitiesUseCase;
  List<String> _cachedNationalities = [];

  NationalityCubit(this._getNationalitiesUseCase) : super(const NationalityState.initial());

  Future<void> fetchNationalities() async {
    if (_cachedNationalities.isNotEmpty) {
      emit(NationalityState.loaded(_cachedNationalities));
      return;
    }

    emit(const NationalityState.loading());
    final result = await _getNationalitiesUseCase(NoParams());

    result.fold(
      (failure) => emit(NationalityState.error(failure.message)),
      (nationalities) {
        _cachedNationalities = nationalities;
        emit(NationalityState.loaded(nationalities));
      },
    );
  }
}
