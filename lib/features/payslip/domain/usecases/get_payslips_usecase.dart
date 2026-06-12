import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payslip_entities.dart';
import '../repositories/i_payslip_repository.dart';

class GetPayslipsUseCase {
  final IPayslipRepository repository;

  GetPayslipsUseCase(this.repository);

  Future<Either<Failure, List<PayslipEntity>>> call({
    required String employeeId,
    required int start,
    required int limit,
  }) async {
    return await repository.getPayslips(
      employeeId: employeeId,
      start: start,
      limit: limit,
    );
  }
}
