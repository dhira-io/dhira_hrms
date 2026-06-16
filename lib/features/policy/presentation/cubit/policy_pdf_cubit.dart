import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/policy/domain/usecases/get_policy_pdf_usecase.dart';
import 'package:dhira_hrms/features/policy/presentation/cubit/policy_pdf_state.dart';

class PolicyPdfCubit extends Cubit<PolicyPdfState> {
  final GetPolicyPdfUseCase getPolicyPdfUseCase;

  PolicyPdfCubit(this.getPolicyPdfUseCase)
    : super(const PolicyPdfState());

  Future<void> loadPdf(String fileUrl) async {
    emit(const PolicyPdfState(status: PolicyPdfStatus.loading));
    final result = await getPolicyPdfUseCase(fileUrl);
    result.fold(
      (failure) => emit(PolicyPdfState(status: PolicyPdfStatus.failure, message: failure.message)),
      (pdf) => emit(PolicyPdfState(status: PolicyPdfStatus.success, pdf: pdf)),
    );
  }
}
