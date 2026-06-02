import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileDetailsUseCase {
  final IProfileRepository repository;

  UpdateProfileDetailsUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String identifier,
    required String personalEmail,
    required String phone,
    required String emergencyContact,
    required String currentAddress,
    required String permanentAddress,
    String? dateOfBirth,
  }) async {
    return await repository.updateProfileDetails(
      identifier: identifier,
      personalEmail: personalEmail,
      phone: phone,
      emergencyContact: emergencyContact,
      currentAddress: currentAddress,
      permanentAddress: permanentAddress,
      dateOfBirth: dateOfBirth,
    );
  }
}
