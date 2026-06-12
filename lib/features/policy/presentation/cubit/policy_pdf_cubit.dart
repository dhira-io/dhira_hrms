import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_policy_pdf_usecase.dart';
import 'policy_pdf_state.dart';

class PolicyPdfCubit extends Cubit<PolicyPdfState> {
  final GetPolicyPdfUseCase getPolicyPdfUseCase;

  PolicyPdfCubit(this.getPolicyPdfUseCase)
    : super(const PolicyPdfState.initial());

  Future<void> loadPdf(String fileUrl) async {
    emit(const PolicyPdfState.loading());
    final result = await getPolicyPdfUseCase(fileUrl);
    result.fold(
      (failure) => emit(PolicyPdfState.failure(failure.message)),
      (pdf) => emit(PolicyPdfState.success(pdf)),
    );
  }
}
