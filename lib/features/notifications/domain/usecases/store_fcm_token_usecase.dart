import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/notification_repository.dart';

class StoreFcmTokenUseCase {
  final INotificationRepository repository;

  StoreFcmTokenUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String token, required String deviceId, required String platform}) {
    return repository.storeFcmToken(token: token, deviceId: deviceId, platform: platform);
  }
}
