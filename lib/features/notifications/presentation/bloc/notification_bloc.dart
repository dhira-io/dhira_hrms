import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/constants/notification_constants.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/mark_all_read_usecase.dart';
import '../../domain/usecases/mark_read_usecase.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkAllReadUseCase markAllReadUseCase;
  final MarkReadUseCase markReadUseCase;

  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.markAllReadUseCase,
    required this.markReadUseCase,
  }) : super(const NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<LoadMoreNotifications>(_onLoadMoreNotifications);
    on<MarkRead>(_onMarkRead);
    on<MarkAllAsRead>(_onMarkAllAsRead);
  }

  static const int _pageSize = 20;

  Future<void> _onMarkRead(
    MarkRead event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      // 1. Optimistic Update in the main list
      final updatedNotifications = currentState.notifications.map((n) {
        if (n.id == event.id) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();

      // 2. Optimistic Update in the grouped map (to avoid full re-grouping)
      final updatedGrouped = Map<String, List<NotificationEntity>>.from(
        currentState.groupedNotifications,
      );
      for (final entry in updatedGrouped.entries) {
        final list = entry.value;
        final index = list.indexWhere((n) => n.id == event.id);
        if (index != -1) {
          final updatedList = List<NotificationEntity>.from(list);
          updatedList[index] = updatedList[index].copyWith(isRead: true);
          updatedGrouped[entry.key] = updatedList;
          break; // Found and updated
        }
      }

      emit(
        currentState.copyWith(
          notifications: updatedNotifications,
          groupedNotifications: updatedGrouped,
        ),
      );

      // 3. Background Sync
      final result = await markReadUseCase(event.id);

      // 3. Rollback on failure (optional, but good practice)
      result.fold((failure) {
        // If needed, we could revert the state or show an error
        // For now, we'll just keep the optimistic state as subsequent refreshes will fix it
      }, (_) => null);
    }
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    final result = await getNotificationsUseCase(limit: _pageSize, offset: 0);
    result.fold((failure) => emit(NotificationError(failure.toString())), (
      notifications,
    ) {
      final grouped = _groupNotifications(notifications);
      emit(
        NotificationLoaded(
          notifications: notifications,
          groupedNotifications: grouped.map,
          sortedGroupKeys: grouped.keys,
          hasMore: notifications.length == _pageSize,
          currentPage: 0,
        ),
      );
    });
  }

  Future<void> _onLoadMoreNotifications(
    LoadMoreNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded &&
        currentState.hasMore &&
        !currentState.isFetchingMore) {
      emit(currentState.copyWith(isFetchingMore: true));

      final nextOffset = (currentState.currentPage + 1) * _pageSize;
      final result = await getNotificationsUseCase(
        limit: _pageSize,
        offset: nextOffset,
      );

      result.fold(
        (failure) => emit(currentState.copyWith(isFetchingMore: false)),
        (newNotifications) {
          // Prevent duplicates that can cause "Duplicate Key" crashes in the UI
          final existingIds = currentState.notifications.map((n) => n.id).toSet();
          final uniqueNewItems = newNotifications.where((n) => !existingIds.contains(n.id)).toList();
          
          final updatedNotifications = List<NotificationEntity>.from(
            currentState.notifications,
          )..addAll(uniqueNewItems);

          final grouped = _groupNotifications(updatedNotifications);

          final hasMore = newNotifications.length == _pageSize && uniqueNewItems.isNotEmpty;

          emit(
            currentState.copyWith(
              notifications: updatedNotifications,
              groupedNotifications: grouped.map,
              sortedGroupKeys: grouped.keys,
              hasMore: hasMore,
              currentPage: currentState.currentPage + 1,
              isFetchingMore: false,
            ),
          );
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

  _GroupedData _groupNotifications(List<NotificationEntity> notifications) {
    final groups = <String, List<NotificationEntity>>{};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var n in notifications) {
      String groupKey;
      final nDate = DateTime(n.time.year, n.time.month, n.time.day);

      if (nDate == today) {
        groupKey = NotificationGroupConstants.groupToday;
      } else if (nDate == yesterday) {
        groupKey = NotificationGroupConstants.groupYesterday;
      } else {
        groupKey = NotificationGroupConstants.groupEarlier;
      }

      groups.putIfAbsent(groupKey, () => []).add(n);
    }

    final sortedKeys = NotificationGroupConstants.groupOrder
        .where((g) => groups.containsKey(g))
        .toList();

    return _GroupedData(groups, sortedKeys);
  }
}

class _GroupedData {
  final Map<String, List<NotificationEntity>> map;
  final List<String> keys;
  _GroupedData(this.map, this.keys);
}
