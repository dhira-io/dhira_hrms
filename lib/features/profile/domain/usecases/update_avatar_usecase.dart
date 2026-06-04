import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class UpdateAvatarUseCase {
  final IProfileRepository repository;

  UpdateAvatarUseCase(this.repository);

  Future<Either<Failure, String>> call(String filePath, String email) async {
    return await repository.updateAvatar(filePath, email);
  }
}
