import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/timesheet_entities.dart';
import '../repositories/timesheet_repository.dart';

class GetProjectsUseCase {
  final ITimesheetRepository repository;

  GetProjectsUseCase(this.repository);

  Future<Either<Failure, List<ProjectEntity>>> call() async {
    return await repository.fetchProjects();
  }
}
