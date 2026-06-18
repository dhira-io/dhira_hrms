import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification_entity.dart';

abstract class INotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    int? limit,
    int? offset,
  });
  Future<Either<Failure, void>> markAllAsRead();
  Future<Either<Failure, void>> markAsRead(String id);
  Future<Either<Failure, void>> storeFcmToken({
    required String token,
    required String deviceId,
    required String platform,
  });
  Future<Either<Failure, void>> deactivateDevice({
    required String token,
    required String deviceId,
    required String platform,
  });
}
