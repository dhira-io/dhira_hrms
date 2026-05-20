import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_payslip_detail_usecase.dart';
import '../../domain/usecases/get_payslips_usecase.dart';
import 'payslip_event.dart';
import 'payslip_state.dart';

class PayslipBloc extends Bloc<PayslipEvent, PayslipState> {
  final GetPayslipsUseCase getPayslipsUseCase;
  final GetPayslipDetailUseCase getPayslipDetailUseCase;

  PayslipBloc({
    required this.getPayslipsUseCase,
    required this.getPayslipDetailUseCase,
  }) : super(const PayslipState()) {
    on<FetchPayslips>(_onFetchPayslips);
    on<FetchPayslipDetail>(_onFetchPayslipDetail);
  }

  Future<void> _onFetchPayslips(
    FetchPayslips event,
    Emitter<PayslipState> emit,
  ) async {
    emit(state.copyWith(
      isListLoading: true,
      listError: null,
    ));

    final result = await getPayslipsUseCase(
      employeeId: event.employeeId,
      start: event.start,
      limit: event.limit,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isListLoading: false,
        listError: failure.message,
      )),
      (payslips) => emit(state.copyWith(
        isListLoading: false,
        payslips: payslips,
      )),
    );
  }

  Future<void> _onFetchPayslipDetail(
    FetchPayslipDetail event,
    Emitter<PayslipState> emit,
  ) async {
    emit(state.copyWith(
      isDetailLoading: true,
      detailError: null,
      detail: null,
    ));

    final result = await getPayslipDetailUseCase(name: event.name);

    result.fold(
      (failure) => emit(state.copyWith(
        isDetailLoading: false,
        detailError: failure.message,
      )),
      (detail) => emit(state.copyWith(
        isDetailLoading: false,
        detail: detail,
      )),
    );
  }
}
