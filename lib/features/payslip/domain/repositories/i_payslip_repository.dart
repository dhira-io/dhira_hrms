import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payslip_entities.dart';

abstract class IPayslipRepository {
  Future<Either<Failure, List<PayslipEntity>>> getPayslips({
    required String employeeId,
    required int start,
    required int limit,
  });

  Future<Either<Failure, PayslipDetailEntity>> getPayslipDetail({
    required String name,
  });
}
