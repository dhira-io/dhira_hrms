import 'package:equatable/equatable.dart';

enum NotificationType { leave, timesheet, policy, team, celebration }

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final NotificationType type;
  final bool isRead;
  final String group; // Today, Yesterday, Earlier

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.isRead,
    required this.group,
  });

  @override
  List<Object?> get props => [id, title, description, time, type, isRead, group];
}
