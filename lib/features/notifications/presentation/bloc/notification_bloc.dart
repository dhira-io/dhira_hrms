import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/notification_entity.dart';
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
  }) : super(const NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<LoadMoreNotifications>(_onLoadMoreNotifications);
    on<MarkAllAsRead>(_onMarkAllAsRead);
  }

  static const int _pageSize = 20;

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    final result = await getNotificationsUseCase(limit: _pageSize, offset: 0);
    result.fold(
      (failure) => emit(NotificationError(failure.toString())),
      (notifications) => emit(NotificationLoaded(
        notifications: notifications,
        hasMore: notifications.length == _pageSize,
        currentPage: 0,
      )),
    );
  }

  Future<void> _onLoadMoreNotifications(
    LoadMoreNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded && currentState.hasMore && !currentState.isFetchingMore) {
      emit(currentState.copyWith(isFetchingMore: true));
      
      final nextOffset = (currentState.currentPage + 1) * _pageSize;
      final result = await getNotificationsUseCase(limit: _pageSize, offset: nextOffset);
      
      result.fold(
        (failure) => emit(currentState.copyWith(isFetchingMore: false)),
        (newNotifications) {
          final updatedNotifications = List<NotificationEntity>.from(currentState.notifications)
            ..addAll(newNotifications);
          
          emit(currentState.copyWith(
            notifications: updatedNotifications,
            hasMore: newNotifications.length == _pageSize,
            currentPage: currentState.currentPage + 1,
            isFetchingMore: false,
          ));
        },
      );
    }
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
