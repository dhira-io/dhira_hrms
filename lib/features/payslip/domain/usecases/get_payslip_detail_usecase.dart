import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payslip_entities.dart';
import '../repositories/i_payslip_repository.dart';

class GetPayslipDetailUseCase {
  final IPayslipRepository repository;

  GetPayslipDetailUseCase(this.repository);

  Future<Either<Failure, PayslipDetailEntity>> call({
    required String name,
  }) async {
    return await repository.getPayslipDetail(name: name);
  }
}
