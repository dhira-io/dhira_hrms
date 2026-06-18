import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification_settings_entity.dart';

abstract class INotificationSettingsRepository {
  Future<Either<Failure, NotificationSettingsEntity>> getSettings();
  Future<Either<Failure, void>> updateItem(String field, bool value);
}
