import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/network/network_info.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_summary_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_eligible_date_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_request_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/repositories/i_compensatory_leave_repository.dart';
import 'package:dhira_hrms/features/compensatory_leave/data/datasources/compensatory_leave_remote_datasource.dart';
import 'package:dhira_hrms/features/compensatory_leave/data/models/compensatory_leave_request_model.dart';

class CompensatoryLeaveRepositoryImpl implements ICompensatoryLeaveRepository {
  final ICompensatoryLeaveRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CompensatoryLeaveRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CompensatoryLeaveSummaryEntity>>
  getCompensatoryLeaveSummary(String employeeId) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getCompensatoryLeaveSummary(
          employeeId,
        );
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<CompensatoryLeaveEligibleDateEntity>>>
  getEligibleDates(String employeeId) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getEligibleDates(employeeId);
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> submitCompensatoryLeaveRequest({
    required String employeeId,
    required CompensatoryLeaveRequestEntity request,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = CompensatoryLeaveRequestModel.fromEntity(request);
        final success = await remoteDataSource.submitCompensatoryLeaveRequest(
          employeeId: employeeId,
          request: model,
        );
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
