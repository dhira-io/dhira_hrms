import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_settings_repository.dart';

class UpdateNotificationSettingsUseCase implements UseCase<void, UpdateNotificationSettingsParams> {
  final INotificationSettingsRepository _repository;

  UpdateNotificationSettingsUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(UpdateNotificationSettingsParams params) async {
    return await _repository.updateItem(params.field, params.value);
  }
}

class UpdateNotificationSettingsParams extends Equatable {
  final String field;
  final bool value;

  const UpdateNotificationSettingsParams({
    required this.field,
    required this.value,
  });

  @override
  List<Object?> get props => [field, value];
}
