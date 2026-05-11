import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/notification_repository.dart';

class DeactivateDeviceUseCase {
  final INotificationRepository repository;

  DeactivateDeviceUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String token, required String deviceId, required String platform}) async {
    return await repository.deactivateDevice(token: token, deviceId: deviceId, platform: platform);
  }
}
