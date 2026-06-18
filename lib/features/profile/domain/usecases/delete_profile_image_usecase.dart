import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class DeleteProfileImageUseCase {
  final IProfileRepository repository;

  DeleteProfileImageUseCase(this.repository);

  Future<Either<Failure, bool>> call(String employeeId) async {
    return await repository.deleteProfileImage(employeeId);
  }
}
