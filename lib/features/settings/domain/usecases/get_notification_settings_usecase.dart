import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification_settings_entity.dart';
import '../repositories/notification_settings_repository.dart';

class GetNotificationSettingsUseCase implements UseCase<NotificationSettingsEntity, NoParams> {
  final INotificationSettingsRepository _repository;

  GetNotificationSettingsUseCase(this._repository);

  @override
  Future<Either<Failure, NotificationSettingsEntity>> call(NoParams params) async {
    return await _repository.getSettings();
  }
}
