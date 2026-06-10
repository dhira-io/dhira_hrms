import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/search_locations_usecase.dart';
import 'location_search_state.dart';
import '../../data/constants/profile_api_constants.dart';

class LocationSearchCubit extends Cubit<LocationSearchState> {
  final SearchLocationsUseCase _searchLocationsUseCase;

  LocationSearchCubit(this._searchLocationsUseCase)
      : super(LocationSearchState.initial(results: List.from(ProfileApiConstants.defaultLocations)));

  Future<void> searchLocations(String query) async {
    emit(LocationSearchState.loading(results: state.results));

    final result = await _searchLocationsUseCase(query);
    result.fold(
      (failure) => emit(LocationSearchState.error(failure.message, results: state.results)),
      (locations) => emit(LocationSearchState.loaded(locations)),
    );
  }
}
