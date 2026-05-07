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
  final Map<String, List<NotificationEntity>> groupedNotifications;
  final List<String> sortedGroupKeys;
  final bool hasMore;
  final int currentPage;
  final bool isFetchingMore;

  const NotificationLoaded({
    required this.notifications,
    required this.groupedNotifications,
    required this.sortedGroupKeys,
    required this.hasMore,
    required this.currentPage,
    this.isFetchingMore = false,
  });

  @override
  List<Object?> get props => [
        notifications,
        groupedNotifications,
        sortedGroupKeys,
        hasMore,
        currentPage,
        isFetchingMore
      ];

  NotificationLoaded copyWith({
    List<NotificationEntity>? notifications,
    Map<String, List<NotificationEntity>>? groupedNotifications,
    List<String>? sortedGroupKeys,
    bool? hasMore,
    int? currentPage,
    bool? isFetchingMore,
  }) {
    return NotificationLoaded(
      notifications: notifications ?? this.notifications,
      groupedNotifications: groupedNotifications ?? this.groupedNotifications,
      sortedGroupKeys: sortedGroupKeys ?? this.sortedGroupKeys,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}
