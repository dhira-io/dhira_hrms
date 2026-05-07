import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_entity.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  final bool hasMore;
  final int currentPage;
  final bool isFetchingMore;

  const NotificationLoaded({
    required this.notifications,
    required this.hasMore,
    required this.currentPage,
    this.isFetchingMore = false,
  });

  @override
  List<Object?> get props => [notifications, hasMore, currentPage, isFetchingMore];

  NotificationLoaded copyWith({
    List<NotificationEntity>? notifications,
    bool? hasMore,
    int? currentPage,
    bool? isFetchingMore,
  }) {
    return NotificationLoaded(
      notifications: notifications ?? this.notifications,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }

  Map<String, List<NotificationEntity>> get groupedNotifications {
    final groups = <String, List<NotificationEntity>>{};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var n in notifications) {
      String groupKey;
      final nDate = DateTime(n.time.year, n.time.month, n.time.day);

      if (nDate == today) {
        groupKey = 'Today';
      } else if (nDate == yesterday) {
        groupKey = 'Yesterday';
      } else {
        groupKey = 'Earlier';
      }

      groups.putIfAbsent(groupKey, () => []).add(n);
    }
    return groups;
  }

  List<String> get sortedGroupKeys {
    final available = groupedNotifications.keys.toList();
    return ['Today', 'Yesterday', 'Earlier']
        .where((g) => available.contains(g))
        .toList();
  }
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}
