import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:get/get.dart';
import '../../../performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import '../../data/constants/payslip_constants.dart';
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
    on<DownloadPayslipPdf>(_onDownloadPayslipPdf);
    on<UpdateFilter>(_onUpdateFilter);
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

  Future<void> _onDownloadPayslipPdf(
    DownloadPayslipPdf event,
    Emitter<PayslipState> emit,
  ) async {
    final fileOpCubit = Get.find<FileOperationCubit>();
    final baseUrl = fileOpCubit.dioClient.baseUrl;

    // Build URL: salary_slip_names=["<name>"]
    final encoded = Uri.encodeQueryComponent(jsonEncode([event.name]));
    final url =
        '$baseUrl${PayslipApiConstants.downloadSalarySlips}'
        '?salary_slip_names=$encoded';

    // Derive a clean file name from the slip name, e.g. "Sal_Slip_CNT-EMP-00001_00003.pdf"
    final fileName =
        '${event.name.replaceAll('/', '_').replaceAll(' ', '_')}.pdf';

    await fileOpCubit.downloadFile(url, fileName, event.l10n);
  }

  void _onUpdateFilter(
    UpdateFilter event,
    Emitter<PayslipState> emit,
  ) {
    emit(state.copyWith(
      selectedYear: event.selectedYear,
      selectedMonth: event.selectedMonth,
    ));
  }
}
