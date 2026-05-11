import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/notification_entity.dart';

part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = NotificationInitial;

  const factory NotificationState.loading() = NotificationLoading;

  const factory NotificationState.loaded({
    required List<NotificationEntity> notifications,
    required Map<String, List<NotificationEntity>> groupedNotifications,
    required List<String> sortedGroupKeys,
    required bool hasMore,
    required int currentPage,
    @Default(false) bool isFetchingMore,
  }) = NotificationLoaded;

  const factory NotificationState.error(String message) = NotificationError;
}
