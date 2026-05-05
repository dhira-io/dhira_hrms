import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final INotificationRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<Either<Failure, List<NotificationEntity>>> call({int? limit, int? offset}) {
    return repository.getNotifications(limit: limit, offset: offset);
  }
}
