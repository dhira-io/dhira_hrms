import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class ChangePasswordUseCase {
  final IProfileRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  }) async {
    return await repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      logoutAllSessions: logoutAllSessions,
    );
  }
}
