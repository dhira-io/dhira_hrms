import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/search_employee_model.dart';
import '../repositories/profile_repository.dart';

class SearchEmployeesUseCase {
  final IProfileRepository repository;

  SearchEmployeesUseCase(this.repository);

  Future<Either<Failure, List<SearchEmployeeModel>>> call(String query) {
    return repository.searchEmployees(query);
  }
}
