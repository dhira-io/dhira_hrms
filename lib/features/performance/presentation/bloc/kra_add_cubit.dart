import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/usecases/get_kra_list_usecase.dart';

part 'kra_add_cubit.freezed.dart';

@freezed
class KraAddState with _$KraAddState {
  const factory KraAddState.initial() = _Initial;
  const factory KraAddState.loading() = _Loading;
  const factory KraAddState.loaded(List<String> kras) = _Loaded;
  const factory KraAddState.error(String message) = _Error;
}

class KraAddCubit extends Cubit<KraAddState> {
  final GetKraListUseCase getKraListUseCase;

  KraAddCubit({required this.getKraListUseCase}) : super(const KraAddState.initial());

  Future<void> loadKras(String jobFamily) async {
    emit(const KraAddState.loading());
    final result = await getKraListUseCase(jobFamily);
    result.fold(
      (failure) => emit(KraAddState.error(failure.message)),
      (kras) => emit(KraAddState.loaded(kras)),
    );
  }
}
