import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class GetProjectsUseCase implements UseCase<List<ProjectEntity>, NoParams> {
  final ITimesheetRepository repository;

  GetProjectsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProjectEntity>>> call([NoParams? params]) async {
    return await repository.fetchProjects();
  }
}
