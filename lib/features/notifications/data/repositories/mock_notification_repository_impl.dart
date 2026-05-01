import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';

class MockNotificationRepositoryImpl implements INotificationRepository {
  List<NotificationEntity> _notifications = [
    NotificationEntity(
      id: '1',
      title: 'Leave Approved',
      description: 'Your leave request for 25th Oct has been approved by John Doe.',
      time: DateTime.now().subtract(const Duration(hours: 1)),
      type: NotificationType.leave,
      isRead: false,
      group: 'Today',
    ),
    NotificationEntity(
      id: '2',
      title: 'Timesheet Reminder',
      description: 'Please ensure your weekly timesheet is submitted before EOD.',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.timesheet,
      isRead: true,
      group: 'Today',
    ),
    NotificationEntity(
      id: '3',
      title: 'Policy Updated',
      description: "The 'Remote Work Policy' has been revised. Tap to view the document.",
      time: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.policy,
      isRead: true,
      group: 'Yesterday',
    ),
    NotificationEntity(
      id: '4',
      title: 'New Team Member',
      description: 'Sarah Chen has joined the Engineering team. Say hello!',
      time: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      type: NotificationType.team,
      isRead: true,
      group: 'Yesterday',
    ),
    NotificationEntity(
      id: '5',
      title: 'Work Anniversary',
      description: 'Congratulations on completing 2 years at Dhira!',
      time: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.celebration,
      isRead: true,
      group: 'Earlier',
    ),
  ];

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Right(_notifications);
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    _notifications = _notifications.map((n) => NotificationEntity(
      id: n.id,
      title: n.title,
      description: n.description,
      time: n.time,
      type: n.type,
      isRead: true,
      group: n.group,
    )).toList();
    return const Right(null);
  }
}
