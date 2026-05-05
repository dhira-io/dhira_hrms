import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification_entity.dart';

abstract class INotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({int? limit, int? offset});
  Future<Either<Failure, void>> markAllAsRead();
  Future<Either<Failure, void>> storeFcmToken(String token);
}



