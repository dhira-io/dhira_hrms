import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/mark_all_read_usecase.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkAllReadUseCase markAllReadUseCase;

  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.markAllReadUseCase,
  }) : super(const NotificationState.initial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<MarkAllAsRead>(_onMarkAllAsRead);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationState.loading());
    final result = await getNotificationsUseCase();
    result.fold(
      (failure) => emit(NotificationState.error(failure.toString())),
      (notifications) => emit(NotificationState.loaded(notifications: notifications)),
    );
  }

  Future<void> _onMarkAllAsRead(
    MarkAllAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await markAllReadUseCase();
    result.fold(
      (failure) => null, // Handle failure if needed
      (_) => add(const NotificationEvent.load()),
    );
  }
}
