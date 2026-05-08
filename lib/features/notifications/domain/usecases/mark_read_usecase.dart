import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/notification_repository.dart';

class MarkReadUseCase {
  final INotificationRepository repository;

  MarkReadUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.markAsRead(id);
  }
}
